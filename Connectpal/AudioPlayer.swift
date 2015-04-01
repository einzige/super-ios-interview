import UIKit
import AVFoundation

@IBDesignable class AudioPlayer: DesignableView, AVAudioPlayerDelegate {
    override var nibName: String? { return "AudioPlayer" }
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var timing: UILabel!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var seekTarget: UIView!
    
    var filePath: String? = "https://connectpal-media.s3.amazonaws.com/9e212140d69511e482582df3baba0229__a8beb860d69511e49f659554a76238a2____03-29-15---Andy-Dean---Whole-Show.mp3"
    
    private var _textColor = UIColor.blackColor()
    private var _position: Float = 0.0
    private var _item: AVPlayerItem?
    
    lazy var player: Player = {
        let result = Player(playerItem: self.item)
        result.addStatusObserver(self)
        return result
    }()
    
    var item: AVPlayerItem {
        get {
            if _item == nil {
                _item = AVPlayerItem(URL: NSURL(string: filePath!))
            }
            return _item!
        }
        
        set(newItem) {
            _item = newItem
            
            player.pause()
            player.cancelPendingPrerolls()
            
            if _item != nil {
                player.replaceCurrentItemWithPlayerItem(_item)
                _item!.addObserver(self, forKeyPath: "status", options: nil, context: nil)
            }
        }
    }
    
    var position: Float {
        get { return _position }
        
        set(value) {
            if value < 0.03 {
                _position = 0.0
            } else if value > 1.0 {
                _position = 1.0
            } else if position < 0.0 {
                _position = 0.0
            } else {
                _position = value
            }
        }
    }

    
    @IBInspectable var textColor: UIColor {
        get { return _textColor }
        
        set(value) {
            _textColor = value
            title.textColor = _textColor
            timing.textColor = _textColor
        }
    }
    
    @IBInspectable var backgroundLayerColor: UIColor? {
        get { return view.backgroundColor }
        
        set(value) {
            view.backgroundColor = value
        }
    }
    
    override func didMoveToSuperview() {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: Selector("onSeek:"))
        seekTarget.addGestureRecognizer(tapRecognizer)
    }
    
    override func setupView() {
        view.autoresizingMask = UIViewAutoresizing.FlexibleWidth
        var newFrame = view.frame
        newFrame.size = CGSizeMake(newFrame.width, 40.0);
        view.frame = newFrame;
    }
    
    func onSeek(sender: UITapGestureRecognizer) {
        let xLocation = sender.locationInView(seekTarget).x
        position = Float(xLocation / seekTarget.bounds.width)
        if position < 0.03 { position = 0.0 }
        
        progressBar.setProgress(position, animated: true)
        play()
    }
    
    override func observeValueForKeyPath(keyPath: String, ofObject object: AnyObject, change: [NSObject : AnyObject], context: UnsafeMutablePointer<Void>) {
        if keyPath == "status" {
            if player.status == AVPlayerStatus.Failed {
                println("failed")
            } else {
                play()
            }
        }
    }
    
    func play() {
        if player.status == AVPlayerStatus.ReadyToPlay {
            if player.currentItem != nil {
                if player.currentItem.status == AVPlayerItemStatus.ReadyToPlay {
                    println("PLAYING \(filePath)")
                    player.seekToTime(getSeekTime())
                    player.play()
                } else {
                    if player.currentItem.status == AVPlayerItemStatus.Failed {
                        println("failed!")
                    }
                    println("fuck you")
                }
            } else {
                println("current item is nil")
            }
        } else {
            println("player is not ready")
        }
    }
    
    func getSeekTime() -> CMTime {
        let currentItemDuration = player.currentItem!.duration
        let duration = CMTimeGetSeconds(currentItemDuration)
        let seekPosition = duration * Float64(position)

        return CMTimeMakeWithSeconds(seekPosition, currentItemDuration.timescale)
    }
}