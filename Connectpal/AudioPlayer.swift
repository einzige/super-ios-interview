import UIKit

@IBDesignable class AudioPlayer: DesignableView {
    override var nibName: String? { return "AudioPlayer" }
    
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
        newFrame.size = CGSizeMake(newFrame.width, 50.0);
        view.frame = newFrame;
    }
}