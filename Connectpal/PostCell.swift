import UIKit

class PostCell: UICollectionViewCell {
    @IBOutlet weak var postTitle: UILabel!
    @IBOutlet weak var postMessage: UILabel!
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var postTime: UILabel!
    @IBOutlet weak var commentButton: StyledButton!
    @IBOutlet weak var likeButton: StyledButton!
}