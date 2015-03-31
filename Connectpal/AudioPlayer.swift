import UIKit

@IBDesignable class AudioPlayer: DesignableView {
    override var nibName: String? { return "AudioPlayer" }
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var timing: UILabel!
    @IBOutlet weak var progressbar: NSLayoutConstraint!
    @IBOutlet weak var playButton: UIButton!
    
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }
    
    override func setupView() {
        view.autoresizingMask = UIViewAutoresizing.FlexibleWidth
        var newFrame = view.frame
        newFrame.size = CGSizeMake(newFrame.width, 40.0);
        view.frame = newFrame;
    }
}