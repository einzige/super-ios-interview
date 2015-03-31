import UIKit

@IBDesignable class AudioPlayer: DesignableView {
    override var nibName: String? { return "AudioPlayer" }
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var timing: UILabel!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var seekTarget: UIView!
    
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
        var progress = Float(xLocation / seekTarget.bounds.width)
        println(progress)
        if progress < 0.03 { progress = 0.0 }
        
        progressBar.setProgress(progress, animated: true)
    }
}