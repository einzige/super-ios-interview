//
//  ViewController.swift
//  Connectpal
//
//  Created by Sergei Zinin on 06/03/15.
//  Copyright (c) 2015 Connectpal. All rights reserved.
//

import UIKit

class PostsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet var postsTableView: UITableView?
    
    var postsData = []
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postsData.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "MyTestCell")
        
        let rowData: NSDictionary = self.postsData[indexPath.row] as NSDictionary
        
        cell.textLabel?.text = rowData["trackName"] as? String
        cell.detailTextLabel?.text = "Subtitle #\(indexPath.row)"
        
        // Grab the artworkUrl60 key to get an image URL for the app's thumbnail
        let urlString: NSString = rowData["artworkUrl60"] as NSString
        let imgURL: NSURL? = NSURL(string: urlString)
        
        // Download an NSData representation of the image at the URL
        let imgData = NSData(contentsOfURL: imgURL!)
        cell.imageView?.image = UIImage(data: imgData!)
        
        // Get the formatted price string for display in the subtitle
        let formattedPrice: NSString = rowData["formattedPrice"] as NSString
        
        cell.detailTextLabel?.text = formattedPrice
        
        return cell
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        api.onDataReceived() {
            var results = $0
            var resultsArr: NSArray = results["results"] as NSArray
            dispatch_async(dispatch_get_main_queue(), {
                self.postsData = resultsArr
                self.postsTableView?.reloadData()
            })
        }
        
        api.searchItunesFor("JQ Software")
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

