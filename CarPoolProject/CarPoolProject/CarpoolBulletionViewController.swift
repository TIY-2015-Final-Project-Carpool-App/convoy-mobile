//
//  CarpoolBulletionViewController.swift
//  CarPoolProject
//
//  Created by Christopher Wainwright Aaron on 7/19/15.
//  Copyright (c) 2015 Christopher Wainwright Aaron. All rights reserved.
//

import UIKit

class CarpoolBulletionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var carpoolTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        carpoolTableView.dataSource = self
        carpoolTableView.delegate = self
        
        RailsRequest.session().getCarpoolIndexWithCompletion { () -> Void in
            self.carpoolTableView.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return RailsRequest.session().carpools.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("carpoolBulletinCell", forIndexPath: indexPath) as! CarpoolBulletinTableViewCell
        
        cell.carpoolTitle.text = RailsRequest.session().carpools[indexPath.row]["title"] as? String
        cell.checkBoardButton.tag = indexPath.row
        
        return cell
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if let cellButton = sender as? UIButton {
            
            let carpoolId = RailsRequest.session().carpools[cellButton.tag]["id"] as! Int
            
            if let bulletinTVC = segue.destinationViewController as? BulletinTableViewController {
                
                bulletinTVC.carpoolId = carpoolId
            }
        }
    }
    

}
