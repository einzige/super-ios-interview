import UIKit

class DesignableView: UIView {
    var view: UIView!
    var nibName: String? { return nil }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }
    
    func xibSetup() {
        view = loadViewFromNib()
        view.frame = bounds
        view.autoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight
        setupView()
        addSubview(view)
    }
    
    func setupView() {
    }
    
    func loadViewFromNib() -> UIView {
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: nibName!, bundle: bundle)
        
        let view = nib.instantiateWithOwner(self, options: nil)[0] as UIView
        return view
    }
}