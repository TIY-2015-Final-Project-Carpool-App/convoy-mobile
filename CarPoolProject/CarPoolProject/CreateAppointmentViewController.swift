//
//  CreateAppointmentViewController.swift
//  CarPoolProject
//
//  Created by Christopher Wainwright Aaron on 7/15/15.
//  Copyright (c) 2015 Christopher Wainwright Aaron. All rights reserved.
//

import UIKit

class CreateAppointmentViewController: UIViewController {
    
    var carpoolId: Int?
    
    @IBOutlet weak var startField: UITextField!
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var descriptionField: UITextField!
    @IBOutlet weak var originField: UITextField!
    @IBOutlet weak var destinationField: UITextField!
    @IBOutlet weak var filterField: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func ceateAppointment(sender: AnyObject) {
        
        RailsRequest.session().start = startField.text
        RailsRequest.session().title = titleField.text
        RailsRequest.session().descript = descriptionField.text
        RailsRequest.session().origin = originField.text
        RailsRequest.session().destination = destinationField.text
        RailsRequest.session().distanceFilter = filterField.text.toInt()!
        
        RailsRequest.session().createAppointmentWithCompletion(carpoolId!, completion: { () -> Void in
            
            println("succesfully made appointment")
            self.dismissViewControllerAnimated(false, completion: nil)
        })
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
