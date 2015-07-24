//
//  CreateChildViewController.swift
//  CarPoolProject
//
//  Created by Christopher Wainwright Aaron on 7/8/15.
//  Copyright (c) 2015 Christopher Wainwright Aaron. All rights reserved.
//

import UIKit

class CreateChildViewController: UIViewController, UITextFieldDelegate, UIAlertViewDelegate {

    @IBOutlet weak var firstnameTextField: UITextField!
    @IBOutlet weak var lastnameTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var dobTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var heightTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstnameTextField.delegate = self
        lastnameTextField.delegate = self
        addressTextField.delegate = self
        dobTextField.delegate = self
        ageTextField.delegate = self
        phoneNumberTextField.delegate = self
        heightTextField.delegate = self
        weightTextField.delegate = self

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        view.endEditing(true)
    }
    
   
    @IBAction func createChildButton(sender: AnyObject) {
        
//        let firstName = firstnameTextField.text
        let lastName = lastnameTextField.text
        let address = addressTextField.text
        let dob = dobTextField.text
        let age = ageTextField.text
        let phoneNumber = phoneNumberTextField.text
        let height = heightTextField.text.toInt() ?? 0
        let weight = weightTextField.text.toInt() ?? 0
        
        RailsRequest.session().firstName = firstnameTextField.text
        RailsRequest.session().lastName = lastName
        RailsRequest.session().address = address
        RailsRequest.session().dob = dob
        RailsRequest.session().phoneNumber = phoneNumber
        RailsRequest.session().height = height
        RailsRequest.session().weight = weight
        
        if RailsRequest.session().firstName.isEmpty || lastName.isEmpty {
            
            let alertView = UIAlertView()
            alertView.title = "Invalid"
            alertView.message = "Please enter all required fields"
            alertView.delegate = self
            alertView.addButtonWithTitle("OK")
            alertView.show()
            
        } else {
            
            RailsRequest.session().createChildWithCompletion({ (childInfo) -> Void in
                
                let alertView = UIAlertView()
                alertView.title = "Success"
                alertView.message = "Child was created"
                alertView.delegate = self
                alertView.addButtonWithTitle("OK")
                alertView.show()
                
                println(" This is sparta \(childInfo)")
                
                RailsRequest.session().childIds.append(childInfo)

                self.dismissViewControllerAnimated(false, completion: nil)
            })
        }
    }
    
    @IBAction func cancelButton(sender: AnyObject) {
        
        dismissViewControllerAnimated(true, completion: nil)
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
