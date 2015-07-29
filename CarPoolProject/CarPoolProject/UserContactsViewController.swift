//
//  UserContactsViewController.swift
//  CarPoolProject
//
//  Created by Christopher Wainwright Aaron on 7/12/15.
//  Copyright (c) 2015 Christopher Wainwright Aaron. All rights reserved.
//

import UIKit

class UserContactsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var userContactTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        userContactTableView.delegate = self
        userContactTableView.dataSource = self
        userContactTableView.backgroundColor = UIColor.clearColor()
        
        RailsRequest.session().getUserContactIndexWithCompletion { () -> Void in
            
            self.userContactTableView.reloadData()
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        userContactTableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func presentContactCreation(sender: AnyObject) {
        
        let ccVC = storyboard?.instantiateViewControllerWithIdentifier("createUCVC") as! CreateUserContactsViewController
        presentViewController(ccVC, animated: true, completion: nil)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return RailsRequest.session().contactIds.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("userContactCell", forIndexPath: indexPath) as! UserContactTableViewCell
        
        if let contactFName = RailsRequest.session().contactIds[indexPath.row]["first_name"] as? String {
            
            cell.fNameLabel.text = contactFName
            cell.contactDetail.tag = indexPath.row
            
        }
        cell.backgroundColor = UIColor.clearColor()
        return cell
    }
    
    
    @IBAction func backButton(sender: AnyObject) {
        
        navigationController?.dismissViewControllerAnimated(false, completion: nil)
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if let cellButton = sender as? UIButton {
            
            if !RailsRequest.session().contactIds.isEmpty {
            
            let contact = RailsRequest.session().contactIds[cellButton.tag]
            
            if let updateUserContactVC = segue.destinationViewController as? UpdateUserContactsViewController {
                
                updateUserContactVC.contact = contact
                }
            } else { return }
        }
    }
    

}
