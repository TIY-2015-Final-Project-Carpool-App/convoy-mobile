//
//  UpdateChildViewController.swift
//  CarPoolProject
//
//  Created by Christopher Wainwright Aaron on 7/9/15.
//  Copyright (c) 2015 Christopher Wainwright Aaron. All rights reserved.
//

import UIKit

class UpdateChildViewController: UIViewController, UITextFieldDelegate, UIAlertViewDelegate {
    
    
    @IBOutlet weak var firstnameTextField: UITextField!
    @IBOutlet weak var lastnameTextField: UITextField!
    @IBOutlet weak var dobTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var heightTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    
    var child: [String:AnyObject]?
    @IBOutlet weak var medicalButton: CreateCarPoolButton!
    @IBOutlet weak var emergencyContactButton: CreateCarPoolButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstnameTextField.delegate = self
        lastnameTextField.delegate = self
        addressTextField.delegate = self
        dobTextField.delegate = self
        phoneNumberTextField.delegate = self
        heightTextField.delegate = self
        weightTextField.delegate = self
        
        firstnameTextField.text = child?["first_name"] as? String
        
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        view.endEditing(true)
    }
    
    @IBAction func updateChild(sender: AnyObject) {
        
        RailsRequest.session().firstName = firstnameTextField.text
        RailsRequest.session().lastName = lastnameTextField.text
        RailsRequest.session().address = addressTextField.text
        RailsRequest.session().dob = dobTextField.text
        RailsRequest.session().phoneNumber = phoneNumberTextField.text
        RailsRequest.session().height = heightTextField.text.toInt() ?? 0
        RailsRequest.session().weight = weightTextField.text.toInt() ?? 0
        
        if RailsRequest.session().firstName.isEmpty || RailsRequest.session().lastName.isEmpty {
            
            let alertView = UIAlertView()
            alertView.title = "Invalid"
            alertView.message = "Please enter all required fields"
            alertView.delegate = self
            alertView.addButtonWithTitle("OK")
            alertView.show()
            
        } else {
            
             RailsRequest.session().updateChildWithCompletion(child!, completion: { () -> Void in
              
                let alertView = UIAlertView()
                alertView.title = "Success"
                alertView.message = "Child was created"
                alertView.delegate = self
                alertView.addButtonWithTitle("OK")
                alertView.show()
                
                self.presentingViewController?.presentingViewController?.presentingViewController?.dismissViewControllerAnimated(false, completion: nil)
            })
        }

    }
    
    
    @IBAction func backButton(sender: AnyObject) {
        
        //navigationController?.popViewControllerAnimated(true)
        dismissViewControllerAnimated(false, completion: nil)
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let medButton = sender as? CreateCarPoolButton,
            medicalVC = segue.destinationViewController as? MedicalViewController {
                
            medicalVC.child = child
                
        }
        
        if let contactButton = sender as? CreateCarPoolButton,
            contactVC = segue.destinationViewController as? EmergencyContactsViewController {
                
            contactVC.child = child
                
        }
        
        if let updateMedButton = sender as? CreateCarPoolButton,
            updateMedVC = segue.destinationViewController as? UpdateMedicalViewController {
                
            updateMedVC.child = child
                
        }
        
        if let eContactButton = sender as? CreateCarPoolButton,
            emergencyContactListVC = segue.destinationViewController as? EmergencyContactListViewController {
                
            emergencyContactListVC.child = child
                
        }
        
        
        
    }
    

}
