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
    @IBOutlet weak var userAppointmentTableView: UITableView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        carpoolUserTableView.dataSource = self
        carpoolUserTableView.delegate = self
        
        userAppointmentTableView.delegate = self
        userAppointmentTableView.dataSource = self
        
        carpoolUserTableView.backgroundColor = UIColor.clearColor()
        userAppointmentTableView.backgroundColor = UIColor.clearColor()
        
        RailsRequest.session().getUserAppointmentsWithCompletion { () -> Void in
            
            self.userAppointmentTableView.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        carpoolUserTableView.reloadData()
        RailsRequest.session().getUserAppointmentsWithCompletion { () -> Void in
            
            self.userAppointmentTableView.reloadData()
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (tableView == carpoolUserTableView) {
            return users!.count
        }
        return RailsRequest.session().userAppointments.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if (tableView == carpoolUserTableView) {
            let cell = tableView.dequeueReusableCellWithIdentifier("carpoolUserCell", forIndexPath: indexPath) as! CarpoolUserTableViewCell
            
            if let name = users![indexPath.row]["first_name"] as? String {
                
                cell.nameLabel.text = name
                cell.detailButton.tag = indexPath.row
                cell.deleteUser.tag = indexPath.row
            }
            cell.backgroundColor = UIColor.clearColor()
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier("appointmentCell", forIndexPath: indexPath) as! UserAppointmentTableViewCell
            
            cell.detailButton.tag = indexPath.row
            cell.setMap.tag = indexPath.row
            
            if let creatorDetail = RailsRequest.session().userAppointments[indexPath.row]["creator"] as? [String:AnyObject] {
            
                if let creator = creatorDetail["username"] as? String {
                    cell.creatorLabel.text = creator
                }
            }
            cell.destinationLabel.text = RailsRequest.session().userAppointments[indexPath.row]["destination"] as? String
            cell.roleLabel.text = RailsRequest.session().userAppointments[indexPath.row]["rider_role"] as? String
            cell.titleLabel.text = RailsRequest.session().userAppointments[indexPath.row]["title"] as? String
            
            cell.backgroundColor = UIColor.clearColor()
            
            return cell
        }
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
        
        let user = users![cellButton.tag]["username"] as! String
        println(user)
        println("this is the carpool id \(carpoolId!)")
        users!.removeAtIndex(cellButton.tag)
        self.carpoolUserTableView.reloadData()
        
        RailsRequest.session().deleteUserFromCarpoolWithCompletion(carpoolId!, user: user) { () -> Void in
            println("user was deleted from carpool")
        }
    }
    
    
    @IBAction func setMapButton(sender: AnyObject) {
        
        if let cellButton = sender as? UIButton {
            
            chosenAppointmentIndex = cellButton.tag
            
            let mvc = storyboard?.instantiateViewControllerWithIdentifier("mapVC") as! MapViewController
            presentViewController(mvc, animated: true, completion: nil)
            
        }

    }
    

    @IBAction func backButton(sender: AnyObject) {
        
        dismissViewControllerAnimated(false, completion: nil)
        
        
        //let dvc = storyboard?.instantiateViewControllerWithIdentifier("dashoboardVC") as! DashboardViewController
        //presentViewController(dvc, animated: true, completion: nil)

        
        //navigationController?.popViewControllerAnimated(true)
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if let cellButton = sender as? UIButton {
            
            let userDetail = users![cellButton.tag]
            
            if let carpoolUserVC = segue.destinationViewController as? CarpoolUserViewController {
                
                carpoolUserVC.userDetail = userDetail
            }
        }
        
        if let cellButton = sender as? UIButton {
            
            if let createAppointmentVC = segue.destinationViewController as? CreateAppointmentViewController {
                
                createAppointmentVC.carpoolId = carpoolId!
            }
        }
        
        if let cellButton = sender as? UIButton {
           let appointmentDetail = RailsRequest.session().userAppointments[cellButton.tag]
            
            if let userAppointmentVC = segue.destinationViewController as? UserAppointmentViewController {
                userAppointmentVC.appointmentDetail = appointmentDetail
            }
        }
        
        if let joinButton = sender as? UIButton {
            
            if let carpoolAppointmentsVC = segue.destinationViewController as? CarpoolAppointmentViewController {
                
                carpoolAppointmentsVC.carpoolId = carpoolId!
            }
        }
    }
    

}
