//
//  UpdateMedicalViewController.swift
//  CarPoolProject
//
//  Created by Christopher Wainwright Aaron on 7/12/15.
//  Copyright (c) 2015 Christopher Wainwright Aaron. All rights reserved.
//

import UIKit

class UpdateMedicalViewController: UIViewController {
    
    var child: [String:AnyObject]?
    
    @IBOutlet weak var medicalField: UITextField!
    @IBOutlet weak var medicationsField: UITextField!
    @IBOutlet weak var relevantNotesField: UITextField!
    @IBOutlet weak var allergiesField: UITextField!
    @IBOutlet weak var insuranceField: UITextField!
    @IBOutlet weak var religionField: UITextField!
    @IBOutlet weak var bloodtypeField: UITextField!
    

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
    
    @IBAction func updateMedicalInfo(sender: AnyObject) {
        
        RailsRequest.session().conditions = medicalField.text
        RailsRequest.session().medications = medicationsField.text
        RailsRequest.session().notes = relevantNotesField.text
        RailsRequest.session().allergies = allergiesField.text
        RailsRequest.session().insurance = insuranceField.text
        RailsRequest.session().religiousPreference = religionField.text
        RailsRequest.session().bloodType = bloodtypeField.text
        
        RailsRequest.session().updateMedicalInfoWithCompletion(child!, completion: { () -> Void in

            let alertView = UIAlertView()
            alertView.title = "Success"
            alertView.message = "Child's medical Informated was updated"
            alertView.delegate = self
            alertView.addButtonWithTitle("OK")
            alertView.show()
            
            self.dismissViewControllerAnimated(false, completion: nil)
        })

    }
    
    @IBAction func backButton(sender: AnyObject) {
        
        dismissViewControllerAnimated(false, completion: nil)
    }
    
    
    @IBAction func deleteMedicalInfo(sender: AnyObject) {
        
        RailsRequest.session().deleteMedicalInfoWithCompletion(child!, completion: { () -> Void in
            println("The medical info is deleted")
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
