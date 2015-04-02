import UIKit
import AVFoundation

@IBDesignable class AudioPlayer: DesignableView, PlayableDelegate {
    override var nibName: String? { return "AudioPlayer" }
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var timing: UILabel!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var seekTarget: UIView!
    
    @IBAction func onPlayButtonClicked() {
        if player.playing {
            player.pause()
        } else {
            player.play(position: position)
        }
    }
    
    var filePath: String? = "https://connectpal-media.s3.amazonaws.com/9e212140d69511e482582df3baba0229__a8beb860d69511e49f659554a76238a2____03-29-15---Andy-Dean---Whole-Show.mp3"
    
    private var _textColor = UIColor.blackColor()
    private var _position: Float = 0.0
    private var _item: AVPlayerItem?
    
    lazy var player: Player = {
        let result = Player(playerItem: self.item)
        result.delegate = self
        return result
    }()
    
    lazy var item: AVPlayerItem = {
        return AVPlayerItem(URL: NSURL(string: self.filePath!))
    }()
    
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
        
        progressBar.setProgress(position, animated: true)
        player.play(position: position)
    }
    
    func onPause() {
        playButton.setTitle("▶︎", forState: UIControlState.Normal)
    }
    
    func onPlay() {
        let font = playButton.titleLabel!.font
        //playButton.titleLabel.font = font.set
        playButton.setTitle("▌▌", forState: UIControlState.Normal)
    }
}