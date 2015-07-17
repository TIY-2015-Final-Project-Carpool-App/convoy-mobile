//
//  SignupViewController.swift
//  CarPoolProject
//
//  Created by Christopher Wainwright Aaron on 7/5/15.
//  Copyright (c) 2015 Christopher Wainwright Aaron. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController, UITextFieldDelegate, UIAlertViewDelegate {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var firstnameTextField: UITextField!
    @IBOutlet weak var lastnameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameTextField.delegate = self
        passwordTextField.delegate = self
        firstnameTextField.delegate = self
        lastnameTextField.delegate = self
        emailTextField.delegate = self

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        view.endEditing(true)
    }


    @IBAction func signUpButton(sender: AnyObject) {
       
        let username = usernameTextField.text
        let password = passwordTextField.text
        let firstname = firstnameTextField.text
        let lastname = lastnameTextField.text
        let email = emailTextField.text
        
        RailsRequest.session().username = username
        RailsRequest.session().password = password
        RailsRequest.session().firstName = firstname
        RailsRequest.session().lastName = lastname
        RailsRequest.session().email = email
        
        if username.isEmpty || password.isEmpty || firstname.isEmpty || lastname.isEmpty || email.isEmpty {
            
            let alertView = UIAlertView()
            alertView.title = "Invalid Sign Up"
            alertView.message = "Please enter all required fields"
            alertView.delegate = self
            alertView.addButtonWithTitle("OK")
            alertView.show()
        } else {
            
            RailsRequest.session().registerWithCompletion({ () -> Void in
                
                // dismisses the view controller that presented me
                self.presentingViewController?.presentingViewController?.dismissViewControllerAnimated(false, completion: nil)
                
            
            })
        }
    }
    

}
