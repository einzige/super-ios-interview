import UIKit

class PostCell: UICollectionViewCell {
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.cornerRadius = 3
        layer.masksToBounds = false
        layer.shadowOpacity = 0.1
        layer.shadowRadius = 2.0
        layer.shadowOffset = CGSize(width: 1, height: 1)
        //layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: 5).CGPath
        //layer.shouldRasterize = true
    }
}