import UIKit
import AVFoundation

@IBDesignable class AudioPlayer: DesignableView, AVAudioPlayerDelegate {
    override var nibName: String? { return "AudioPlayer" }
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var timing: UILabel!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var seekTarget: UIView!
    
    var position: Float = 0.0
    var item: AVPlayerItem?
    var filePath: String?
    var player: AVPlayer?
    
    private var _textColor = UIColor.blackColor()
    
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
    
    func play() {
        filePath = "rtmp://s3kch7itxilxuh.cloudfront.net/cfx/st/9e212140d69511e482582df3baba0229__a8beb860d69511e49f659554a76238a2____03-29-15---Andy-Dean---Whole-Show.mp3"
        //filePath = "https://connectpal-media.s3.amazonaws.com/9e212140d69511e482582df3baba0229__a8beb860d69511e49f659554a76238a2____03-29-15---Andy-Dean---Whole-Show.mp3"
        filePath = "https://connectpal-media.s3.amazonaws.com/dfb57310d7c411e4ad01a3186666885f__e1157840d7c411e4908873727e9d01ac____sample2.mp3"
        
        if item == nil {
            let fileURL = NSURL(string: filePath!)
            item = AVPlayerItem(URL: fileURL)
        }
        
        if player == nil {
            player = AVPlayer(playerItem: item)
            player!.addObserver(self, forKeyPath: "status", options: nil, context: nil)
            item!.addObserver(self, forKeyPath: "status", options: nil, context: nil)
        } else {
            _play()
        }
    }
    
    override func observeValueForKeyPath(keyPath: String, ofObject object: AnyObject, change: [NSObject : AnyObject], context: UnsafeMutablePointer<Void>) {
        if keyPath == "status" {
            if player!.status == AVPlayerStatus.Failed {
                println("failed")
            } else {
                _play()
            }
        }
    }
    
    func _play() {
        if player!.status == AVPlayerStatus.ReadyToPlay {
            if player!.currentItem.status == AVPlayerItemStatus.ReadyToPlay {
                println("PLAYING NOW")
                player!.seekToTime(getSeekTime())
                player!.play()
            }
        }
    }
    
    func getSeekTime() -> CMTime {
        //let cpos = Double(position) * Double(item!.duration.value.value)
        let dur = CMTimeGetSeconds(item!.duration)
        let p = dur * Float64(position)
        println(p)
        return CMTimeMakeWithSeconds(p, item!.duration.timescale)
        //return CMTimeMake(cpos, timescale: item!.duration.timescale)//(Float64(position), timescale: item!.duration.timescale)
    }
}