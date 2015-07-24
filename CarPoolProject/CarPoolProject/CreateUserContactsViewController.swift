//
//  CreateUserContactsViewController.swift
//  CarPoolProject
//
//  Created by Christopher Wainwright Aaron on 7/12/15.
//  Copyright (c) 2015 Christopher Wainwright Aaron. All rights reserved.
//

import UIKit

class CreateUserContactsViewController: UIViewController, UIAlertViewDelegate, UITextFieldDelegate {

    @IBOutlet weak var firstnameField: UITextField!
    @IBOutlet weak var lastnameField: UITextField!
    @IBOutlet weak var relationshipField: UITextField!
    @IBOutlet weak var addressField: UITextField!
    @IBOutlet weak var phonenumberField: UITextField!
    @IBOutlet weak var altnumberField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        view.endEditing(true)
    }
    
    @IBAction func createUserContact(sender: AnyObject) {
        
        RailsRequest.session().firstName = firstnameField.text
        RailsRequest.session().lastName = lastnameField.text
        RailsRequest.session().relationship = relationshipField.text
        RailsRequest.session().address = addressField.text
        RailsRequest.session().phoneNumber = phonenumberField.text
        RailsRequest.session().altNumber = altnumberField.text
        
        RailsRequest.session().createUserContactWithCompletion { () -> Void in
            
            let alertView = UIAlertView()
            alertView.title = "Success"
            alertView.message = "Contact was created"
            alertView.delegate = self
            alertView.addButtonWithTitle("OK")
            alertView.show()
            
            self.dismissViewControllerAnimated(false, completion: nil)

        }
    }
    
    @IBAction func cancelButton(sender: AnyObject) {
        
        dismissViewControllerAnimated(false, completion: nil)
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
