//
//  LoginViewController.swift
//  CarPoolProject
//
//  Created by Christopher Wainwright Aaron on 7/5/15.
//  Copyright (c) 2015 Christopher Wainwright Aaron. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UIAlertViewDelegate, UITextFieldDelegate {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameTextField.delegate = self
        passwordTextField.delegate = self 


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        view.endEditing(true)
    }
    
    @IBAction func signInButton(sender: AnyObject) {
        
        
        let username = usernameTextField.text
        let password = passwordTextField.text
        
        RailsRequest.session().username = username
        RailsRequest.session().password = password
        
        if username.isEmpty || password.isEmpty {
           
            let alertView = UIAlertView()
            alertView.title = "Invalid Sign Up"
            alertView.message = "Please enter all required fields"
            alertView.delegate = self
            alertView.addButtonWithTitle("OK")
            alertView.show()
        } else {
            
            RailsRequest.session().loginWithCompletion({ () -> Void in
                
                // dismisses the view controller that presented me
                self.presentingViewController?.presentingViewController?.dismissViewControllerAnimated(false, completion: nil)
                
                
            })
        }
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
