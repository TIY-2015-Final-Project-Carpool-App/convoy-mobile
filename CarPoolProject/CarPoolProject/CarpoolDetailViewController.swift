//
//  DashDetailViewController.swift
//  CarPoolProject
//
//  Created by Christopher Wainwright Aaron on 7/4/15.
//  Copyright (c) 2015 Christopher Wainwright Aaron. All rights reserved.
//

import UIKit

class CarpoolDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate {
    
    var users: [[String:AnyObject]]?
    var carpoolId: Int?

    @IBOutlet weak var carpoolUserTableView: UITableView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        carpoolUserTableView.dataSource = self
        carpoolUserTableView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        carpoolUserTableView.reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users!.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("carpoolUserCell", forIndexPath: indexPath) as! CarpoolUserTableViewCell
        
        if let name = users![indexPath.row]["first_name"] as? String {
            
            cell.nameLabel.text = name
            cell.detailButton.tag = indexPath.row
            cell.deleteUser.tag = indexPath.row
        }
   
        
        return cell
    }
    
    func configurationTextField(textField: UITextField!) {
        
        println("Configure alertTextField")
        
        textField.placeholder = "Email"
        
    }
    
    func handleCancel(alertView: UIAlertAction!) {
        println("User click Cancel button")
    }
    
    @IBAction func inviteUserToCarpoolButton(sender: UIButton) {
        
        var alert = UIAlertController(title: "Invitation", message: "Send an invite to the carpool", preferredStyle: UIAlertControllerStyle.Alert)
        
        
        alert.addTextFieldWithConfigurationHandler(configurationTextField)
        
        alert.addAction(UIAlertAction(title: "Close", style: UIAlertActionStyle.Cancel, handler:handleCancel))
        
        alert.addAction(UIAlertAction(title: "Enter", style: UIAlertActionStyle.Default, handler: { (action) in
            
            let alertTextField = alert.textFields![0] as! UITextField
            RailsRequest.session().email = alertTextField.text
            
            RailsRequest.session().inviteUserWithCompletion(self.carpoolId!, completion: { () -> Void in
                
                let alertView = UIAlertView()
                alertView.title = "Success"
                alertView.message = "Invite has been sent to email"
                alertView.delegate = self
                alertView.addButtonWithTitle("OK")
                alertView.show()

            })

        }))
        
        self.presentViewController(alert, animated: true, completion: {
            println("completion block")
        })
    }
    
    @IBAction func deleteUser(sender: AnyObject) {
        
        let cellButton = sender as! UIButton
        
        let carpool = RailsRequest.session().carpools[cellButton.tag]
        
        RailsRequest.session().carpools.removeAtIndex(cellButton.tag) // confused as to why this works and not deleting the actaull carpool
        self.carpoolUserTableView.reloadData()
        
        RailsRequest.session().deleteUserFromCarpoolWithCompletion(carpool, completion: { () -> Void in
            println("the job is done")
        })
    }
    
    
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}
