import UIKit

class FeedViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    @IBOutlet weak var loader: UIActivityIndicatorView!
    
    var posts: [AnyObject] = [AnyObject]()
    var profileImageCache = [Int: UIImage]()
    
    override func viewDidAppear(animated: Bool) {
        { return api.feed() } ~> postsLoaded
    }
    
    func postsLoaded(response: APIResponse) {
        self.posts = response.getData()["posts"] as [AnyObject]
        self.collectionView?.reloadData()
        loader.hidden = true
    }
    
    // UICOllectionViewDelegateFlowLayout
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        collectionViewLayout.invalidateLayout()
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("post-cell", forIndexPath: indexPath) as PostCell
        let post = Post(data: posts[indexPath.row] as [String: AnyObject])
        
        cell.pullFields(post)
        
        let authorData = post["user"] as [String: AnyObject]
        let authorID = authorData["id"] as Int
        var image = profileImageCache[authorID]
        
        if image == nil {
            // If the image does not exist, we need to download it
            var imgURL: NSURL = NSURL(string: authorData["small_profile_picture_url"] as String)!
            
            // Download an NSData representation of the image at the URL
            let request: NSURLRequest = NSURLRequest(URL: imgURL)
            
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {(response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
                if error == nil {
                    image = UIImage(data: data)
                    
                    // Store the image into the cache
                    self.profileImageCache[authorID] = image! as UIImage
                    dispatch_async(dispatch_get_main_queue(), {
                        if let cellToUpdate = collectionView.cellForItemAtIndexPath(indexPath) as? PostCell {
                            cellToUpdate.postImage?.image = image
                        }
                    })
                }
                else {
                    println("Error: \(error.localizedDescription)")
                }
            })
        } else {
            dispatch_async(dispatch_get_main_queue(), {
                if let cellToUpdate = collectionView.cellForItemAtIndexPath(indexPath) as? PostCell {
                    cellToUpdate.postImage?.image = image
                }
            })
        }
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let post: [String: AnyObject] = posts[indexPath.row] as [String: AnyObject]
        
        // Virtual label to estimate cell's height
        let label = UILabel()
        label.font = UIFont(name: "Helvetica Neue", size: 14.0)
        label.text = post["message"] as? String
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.ByWordWrapping
        
        let screenSize = UIScreen.mainScreen().bounds
        let padding = 5 + 5 as CGFloat
        let margin = 5 + 5 as CGFloat
        
        let labelWidth = screenSize.width - padding - margin
        let maxHeight = 3999 as CGFloat
        
        let maxLabelSize = CGSizeMake(labelWidth, maxHeight)
        let size = label.sizeThatFits(maxLabelSize)
    
        return CGSizeMake(screenSize.width - margin, size.height + 120)
    }
    
    private func setImageAt(indexPath: NSIndexPath, image: UIImage) {
        dispatch_async(dispatch_get_main_queue(), {
            if let cellToUpdate = (self.view as UICollectionView).cellForItemAtIndexPath(indexPath) as? PostCell {
                cellToUpdate.postImage?.image = image
            }
        })
    }
}