import UIKit

class StyledButton: UIButton {
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.borderWidth = 1
        layer.cornerRadius = 3
        titleLabel!.textColor = UIColor.grayColor()
        layer.borderColor = UIColor(white: 0.5, alpha: 0.2).CGColor
    }
}