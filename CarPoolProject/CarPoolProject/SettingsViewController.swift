//
//  SettingsViewController.swift
//  CarPoolProject
//
//  Created by Christopher Wainwright Aaron on 7/8/15.
//  Copyright (c) 2015 Christopher Wainwright Aaron. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UITextFieldDelegate, UIAlertViewDelegate, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var firstnameLabel: UILabel!
    @IBOutlet weak var lastnameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var phonenumberLabel: UILabel!
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var firstnameTextField: UITextField!
    @IBOutlet weak var lastnameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var currentUsernameTextField: UITextField!
    
    @IBOutlet weak var childrenTableView: UITableView!
    
//    var childrenArray: [[String:AnyObject]] = [[:]]
    var setUsernameLabel = ""
    var setFirstnameLabel = ""
    var setLastnameLabel = ""
    var setAddressLabel = ""
    var setEmailLabel = ""
    var setPhoneLabel = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameTextField.delegate = self
        passwordTextField.delegate = self
        firstnameTextField.delegate = self
        lastnameTextField.delegate = self
        emailTextField.delegate = self
        addressTextField.delegate = self
        phoneNumberTextField.delegate = self

        
        childrenTableView.delegate = self
        childrenTableView.dataSource = self
        childrenTableView.layer.cornerRadius = 10

            RailsRequest.session().getUserInfoWithCompletion { () -> Void in
                
                self.setUsernameLabel = RailsRequest.session().usernameLabel
                self.setFirstnameLabel = RailsRequest.session().firstnameLabel
                self.setLastnameLabel = RailsRequest.session().lastnameLabel
                self.setAddressLabel = RailsRequest.session().addressLabel
                self.setEmailLabel = RailsRequest.session().emailLabel
                self.setPhoneLabel = RailsRequest.session().phoneLabel
            
                self.usernameLabel.text = self.setUsernameLabel
                self.firstnameLabel.text = self.setFirstnameLabel
                self.lastnameLabel.text = self.setLastnameLabel
                self.addressLabel.text = self.setAddressLabel
                self.emailLabel.text = self.setEmailLabel
                self.phonenumberLabel.text = self.setPhoneLabel
                
            }
        
        RailsRequest.session().getChildrenIndexWithCompletion { () -> Void in
            self.childrenTableView.reloadData()
        }
}
    
    override func viewWillAppear(animated: Bool) {
        childrenTableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        view.endEditing(true)
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return RailsRequest.session().childIds.count
        
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("childCell", forIndexPath: indexPath) as! ChildrenTableViewCell
        
        
     
        if let childFName = RailsRequest.session().childIds[indexPath.row]["first_name"] as? String {
            
            cell.childFName.text = childFName
            cell.updateButton.tag = indexPath.row
            cell.deleteButton.tag = indexPath.row
        }
        
        
        return cell
    }
    
    @IBAction func updateUserButton(sender: AnyObject) {
        
        let username = usernameTextField.text
        let password = passwordTextField.text
        let firstname = firstnameTextField.text
        let lastname = lastnameTextField.text
        let email = emailTextField.text
        let address = addressTextField.text
        let phoneNumber = phoneNumberTextField.text


        
        RailsRequest.session().username = username
        RailsRequest.session().password = password
        RailsRequest.session().firstName = firstname
        RailsRequest.session().lastName = lastname
        RailsRequest.session().email = email
        RailsRequest.session().address = address
        RailsRequest.session().phoneNumber = phoneNumber

        
        if username.isEmpty || password.isEmpty || firstname.isEmpty || lastname.isEmpty || email.isEmpty {
            
            let alertView = UIAlertView()
            alertView.title = "Invalid Sign Up"
            alertView.message = "Please enter all required fields"
            alertView.delegate = self
            alertView.addButtonWithTitle("OK")
            alertView.show()
        } else {
            
            RailsRequest.session().updateUserWithCompletion({ () -> Void in
                
                let alertView = UIAlertView()
                alertView.title = "Success"
                alertView.message = "User has been updated"
                alertView.delegate = self
                alertView.addButtonWithTitle("OK")
                alertView.show()

                self.dismissViewControllerAnimated(false, completion: nil)
            })
        }
    }
    
    @IBAction func deleteChild(sender: UIButton) {
    
        let cellButton = sender 
        
        let child = RailsRequest.session().childIds[cellButton.tag]
        
        RailsRequest.session().childIds.removeAtIndex(cellButton.tag)
        self.childrenTableView.reloadData()
    
        RailsRequest.session().deleteChildWithCompletion(child, completion: { () -> Void in
            println("child has been deleted")
        })
        
        
    }
    
    
    
    @IBAction func addOrUpdateChildButton(sender: AnyObject) {
        
        let ccvc = storyboard?.instantiateViewControllerWithIdentifier("createChildVC") as! CreateChildViewController
        presentViewController(ccvc, animated: true, completion: nil)
        
    }
    
    
    @IBAction func logout(sender: AnyObject) {
        
        RailsRequest.session().givenUser = nil
        RailsRequest.session().token = nil
        
        if RailsRequest.session().givenUser == nil {
            
            dismissViewControllerAnimated(false, completion: nil)
            
            let wvc = storyboard?.instantiateViewControllerWithIdentifier("welcomeVC") as! WelcomeViewController
            
            tabBarController?.presentViewController(wvc, animated: true, completion: nil)
        }
    }
    
    @IBAction func backButton(sender: AnyObject) {
        
//        let dvc = storyboard?.instantiateViewControllerWithIdentifier("dashoboardVC") as! DashboardViewController
//        presentViewController(dvc, animated: true, completion: nil)
        
        dismissViewControllerAnimated(false, completion: nil)
        
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

        if let cellButton = sender as? UIButton {
            
//            let indexPath = childrenTableView.indexPathForCell(cell)!
            
          //  let child = RailsRequest.session().childIds[indexPath.row]
            let child = RailsRequest.session().childIds[cellButton.tag]
            
            if let updateVC = segue.destinationViewController as? UpdateChildViewController {
                
                updateVC.child = child
                
            }
            
            
        }
    
    }

}
