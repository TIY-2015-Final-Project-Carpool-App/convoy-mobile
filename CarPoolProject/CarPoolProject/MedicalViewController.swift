//
//  MedicalViewController.swift
//  CarPoolProject
//
//  Created by Christopher Wainwright Aaron on 7/11/15.
//  Copyright (c) 2015 Christopher Wainwright Aaron. All rights reserved.
//

import UIKit

class MedicalViewController: UIViewController, UITextFieldDelegate, UIAlertViewDelegate {
    
    var child: [String:AnyObject]?
    
    @IBOutlet weak var conditionsField: UITextField!
    @IBOutlet weak var medicationsField: UITextField!
    @IBOutlet weak var notesField: UITextField!
    @IBOutlet weak var allergiesField: UITextField!
    @IBOutlet weak var insuranceField: UITextField!
    @IBOutlet weak var religionField: UITextField!
    @IBOutlet weak var bloodTypeField: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func updateMedInfo(sender: AnyObject) {
        
        RailsRequest.session().conditions = conditionsField.text
        RailsRequest.session().medications = medicationsField.text
        RailsRequest.session().notes = notesField.text
        RailsRequest.session().allergies = allergiesField.text
        RailsRequest.session().insurance = insuranceField.text
        RailsRequest.session().religiousPreference = religionField.text
        RailsRequest.session().bloodType = bloodTypeField.text
        
        RailsRequest.session().createChildMedicalInfoWithCompletin(child!, completion: { () -> Void in
            
            let alertView = UIAlertView()
            alertView.title = "Success"
            alertView.message = "Child's medical Informated was created"
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
