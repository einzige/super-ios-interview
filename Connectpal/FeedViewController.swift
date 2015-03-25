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
        cell.postMessage?.text = post["message"] as? String
        cell.postTime?.text = post["created_at"] as? String
        
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
        
        cell.sizeToFit()
        
        return cell
    }
    
    private func setImageAt(indexPath: NSIndexPath, image: UIImage) {
        dispatch_async(dispatch_get_main_queue(), {
            if let cellToUpdate = (self.view as UICollectionView).cellForItemAtIndexPath(indexPath) as? PostCell {
                cellToUpdate.postImage?.image = image
            }
        })
    }
}