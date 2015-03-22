import UIKit

class FeedViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    @IBOutlet weak var loader: UIActivityIndicatorView!
    
    var posts: [AnyObject] = [AnyObject]()
    
    override func viewDidAppear(animated: Bool) {
        { return api.feed() } ~> postsLoaded
    }
    
    func postsLoaded(response: APIResponse) {
        
    }
    
    // UICOllectionViewDelegateFlowLayout
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("post-cell", forIndexPath: indexPath) as PostCell
        
        let post: [String: AnyObject] = posts[indexPath.row] as [String: AnyObject]
        cell.postTitle?.text = post["title"] as? String
        
        return cell
    }
}