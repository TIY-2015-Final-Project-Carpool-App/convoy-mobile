//
//  UserAppointmentDetailViewController.swift
//  CarPoolProject
//
//  Created by Christopher Wainwright Aaron on 7/23/15.
//  Copyright (c) 2015 Christopher Wainwright Aaron. All rights reserved.
//

import UIKit

class UserAppointmentDetailViewController: UIViewController {
    
    var conditions = ""
    var medications = ""
    var notes = ""
    var allergies = ""
    var insurance = ""
    var religion = ""
    var bloodType = ""
    
    var rider: [String:AnyObject]?
     
    @IBOutlet weak var firstname: UILabel!
    @IBOutlet weak var lastname: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var phoneNumber: UILabel!
    @IBOutlet weak var conditionsLabel: UILabel!
    @IBOutlet weak var medicationsLabel: UILabel!
    @IBOutlet weak var notesLabel: UILabel!
    @IBOutlet weak var allergiesLabel: UILabel!
    @IBOutlet weak var insuranceLabel: UILabel!
    @IBOutlet weak var religionLabel: UILabel!
    @IBOutlet weak var bloodtypeLabel: UILabel!
    
    @IBOutlet weak var staticConditions: UILabel!
    @IBOutlet weak var staticMedications: UILabel!
    @IBOutlet weak var staticNotes: UILabel!
    @IBOutlet weak var staticAllergies: UILabel!
    @IBOutlet weak var staticInsurance: UILabel!
    @IBOutlet weak var staticReligion: UILabel!
    @IBOutlet weak var staticBloodtype: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstname.text = rider!["first_name"] as? String
        lastname.text = rider!["last_name"] as? String
        address.text = rider!["address"] as? String
        phoneNumber.text = rider!["phone_number"] as? String
        
        println("this is the condtion \(conditions)")
        
//        if conditionsLabel.text == "Conditions" {
//            staticConditions.hidden = true
//            conditionsLabel.hidden = true
//        }
//
//        if medicationsLabel.text == nil {
//            staticMedications.hidden = true
//            medicationsLabel.hidden = true
//        }
//        
//        if notesLabel.text == nil {
//            staticNotes.hidden = true
//            notesLabel.hidden = true
//        }
//        
//        if allergiesLabel.text == nil {
//            staticAllergies.hidden = true
//            allergiesLabel.hidden = true
//        }
//        
//        if insuranceLabel.text == nil {
//            staticInsurance.hidden = true
//            insuranceLabel.hidden = true
//        }
//        
//        if religionLabel.text == nil {
//            staticReligion.hidden = true
//            religionLabel.hidden = true
//        }
//        
//        if bloodtypeLabel.text == nil {
//            bloodtypeLabel.hidden = true
//            staticBloodtype.hidden = true
//        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backButton(sender: AnyObject) {
        
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
