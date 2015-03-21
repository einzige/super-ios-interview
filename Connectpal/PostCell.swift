import UIKit

class PostCell: UICollectionViewCell {
    
    @IBOutlet weak var postTitle: UILabel!
    
    @IBOutlet weak var postMessage: UILabel!
    
    @IBOutlet weak var postImage: UIImageView!
    
    @IBOutlet weak var postTime: UILabel!
    
    @IBOutlet weak var commentButton: StyledButton!
    
    @IBOutlet weak var likeButton: StyledButton!
    
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