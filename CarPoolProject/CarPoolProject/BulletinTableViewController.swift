//
//  BulletinTableViewController.swift
//  CarPoolProject
//
//  Created by Christopher Wainwright Aaron on 7/2/15.
//  Copyright (c) 2015 Christopher Wainwright Aaron. All rights reserved.
//

import UIKit

class BulletinTableViewController: UITableViewController {
    
    var carpoolId: Int?
    
    @IBOutlet var bulletinTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        bulletinTableView.separatorStyle = UITableViewCellSeparatorStyle.None
        
        
        let imageView = UIImageView()
        imageView.frame = bulletinTableView.frame
        imageView.image = UIImage(named: "corktexture")!
        
//        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Dark)
//        var blurView = UIVisualEffectView(effect: blurEffect)
//        blurView.frame = imageView.frame
//        imageView.addSubview(blurView)
        bulletinTableView.backgroundView = imageView
        view.preservesSuperviewLayoutMargins = true
        
      //  bulletinTableView.estimatedRowHeight = 10
      //  bulletinTableView.rowHeight = UITableViewAutomaticDimension
        
//        self.tableView.reloadSections(NSIndexSet(indexesInRange: NSMakeRange(0, self.tableView.numberOfSections())), withRowAnimation: .None)
        
        RailsRequest.session().getPostsWithCompletion(carpoolId!, completion: { () -> Void in
            
            self.bulletinTableView.reloadData()
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return RailsRequest.session().posts.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("bulletinCell2", forIndexPath: indexPath) as! BulletinTableViewCell
        
        let text = RailsRequest.session().posts[indexPath.row]["body"] as? String
        
        cell.bulletinTextView.text = text
        
        let postInfo = RailsRequest.session().posts[indexPath.row]
            
            if let user = postInfo["user"] as? [String:AnyObject] {
                
              let username = user["username"] as? String
            }
        
        
        
        // Configure the cell...
        cell.backgroundColor = UIColor.clearColor()
        cell.contentView.backgroundColor = UIColor.clearColor()
        
//        let bulletinImageView = UIImageView()
//        bulletinImageView.frame = separatorLineView.frame
//        bulletinImageView.image = UIImage(named: "bulletinboard")
//        
//        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Dark)
//        var blurView = UIVisualEffectView(effect: blurEffect)
//        blurView.frame = bulletinImageView.frame
//        bulletinImageView.addSubview(blurView)
        
     //   cell.contentView.addSubview(separatorLineView)
 //       cell.layoutMargins = UIEdgeInsets(top: 20, left: 100, bottom: 20, right: 100)
        cell.frameForAlignmentRect(cell.frame)
//        cell.layer.borderWidth = 10
        cell.wrapperView.layer.cornerRadius = cell.frame.height / 4
        cell.wrapperView.layer.masksToBounds = true
//        cell.layer.borderColor = UIColor.whiteColor().CGColor
        cell.clipsToBounds = true
        
        
     //   let distanceTo = cell.frame.height
    //    bulletinTableView.rowHeight = UITableViewAutomaticDimension.distanceTo(distanceTo)
        
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        let textView = UITextView(frame: CGRect(x: 0, y: 0, width: 440, height: 1000))
        
        let text = RailsRequest.session().posts[indexPath.row]["body"] as? String
        
        textView.text = text
        
        
        println(text)
        
        let size = textView.sizeThatFits(CGSize(width: textView.frame.width, height: 1000))
        
        println(size)
        
        var height = size.height + 14
        
        if height < 100 { height = 80 }
        
        return height
        
    }
    
//    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//        
//        return UITableViewAutomaticDimension
//    }
//    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        
        if let barButton = sender as? UIButton {
            
            if let createPostVC = segue.destinationViewController as? CreatePostViewController {
                
                createPostVC.carpoolId = carpoolId!
            }
        }
    }
    

}
