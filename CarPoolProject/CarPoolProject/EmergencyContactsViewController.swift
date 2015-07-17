//
//  EmergencyContactsViewController.swift
//  CarPoolProject
//
//  Created by Christopher Wainwright Aaron on 7/11/15.
//  Copyright (c) 2015 Christopher Wainwright Aaron. All rights reserved.
//

import UIKit

class EmergencyContactsViewController: UIViewController, UITextFieldDelegate, UIAlertViewDelegate {
    
    @IBOutlet weak var firstnameField: UITextField!
    @IBOutlet weak var lastnameField: UITextField!
    @IBOutlet weak var relationshipField: UITextField!
    @IBOutlet weak var addressField: UITextField!
    @IBOutlet weak var phoneNumberField: UITextField!
    @IBOutlet weak var altNumberField: UITextField!
    
    var child: [String:AnyObject]?

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func createContact(sender: AnyObject) {
        
        RailsRequest.session().firstName = firstnameField.text
        RailsRequest.session().lastName = lastnameField.text
        RailsRequest.session().relationship = relationshipField.text
        RailsRequest.session().address = addressField.text
        RailsRequest.session().phoneNumber = phoneNumberField.text
        RailsRequest.session().altNumber = altNumberField.text
        
        RailsRequest.session().createChildContactWithCompletion(child!, completion: { () -> Void in
            
            
            let alertView = UIAlertView()
            alertView.title = "Success"
            alertView.message = "Child's emergency contact was created"
            alertView.delegate = self
            alertView.addButtonWithTitle("OK")
            alertView.show()
            
            self.dismissViewControllerAnimated(false, completion: nil)
        })
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
