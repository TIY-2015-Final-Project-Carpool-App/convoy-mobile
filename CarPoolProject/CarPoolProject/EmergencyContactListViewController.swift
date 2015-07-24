//
//  EmergencyContactListViewController.swift
//  CarPoolProject
//
//  Created by Christopher Wainwright Aaron on 7/13/15.
//  Copyright (c) 2015 Christopher Wainwright Aaron. All rights reserved.
//

import UIKit

class EmergencyContactListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var child: [String:AnyObject]?

    @IBOutlet weak var emergencyContactTableView: UITableView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emergencyContactTableView.delegate = self
        emergencyContactTableView.dataSource = self
        
        RailsRequest.session().getChildContactIndexWithCompletion(child!, completion: { () -> Void in
            self.emergencyContactTableView.reloadData()
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return RailsRequest.session().contactIds.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("childContactCell", forIndexPath: indexPath) as! EmergencyContactTableViewCell
        
        if let contactFName = RailsRequest.session().contactIds[indexPath.row]["first_name"] as? String {
            
            cell.contactFName.text = contactFName
            cell.editContact.tag = indexPath.row
            cell.deleteContact.tag = indexPath.row
            
        }
        
        return cell
    }
    
    @IBAction func deleteContact(sender: AnyObject) {
        
        let cellButton = sender as! UIButton
        
        let contact = RailsRequest.session().contactIds[cellButton.tag]
        
        RailsRequest.session().contactIds.removeAtIndex(cellButton.tag)
        self.emergencyContactTableView.reloadData()
        
        RailsRequest.session().deleteContactWithCompletion(contact, completion: { () -> Void in
            println("contact deleted")
        })

    }
    
    
    @IBAction func backButton(sender: AnyObject) {
        
        dismissViewControllerAnimated(false, completion: nil)
        
        //navigationController?.popViewControllerAnimated(true)
    }
    
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if let cellButton = sender as? UIButton {
            
            if RailsRequest.session().contactIds.isEmpty { return }
            
            let contact = RailsRequest.session().contactIds[cellButton.tag]
            
            if let updateContactVC = segue.destinationViewController as? UpdateChildContactViewController {
                
                updateContactVC.contact = contact 
            }
        }
    }
    

}
