//
//  CarpoolAppointmentDetailViewController.swift
//  CarPoolProject
//
//  Created by Christopher Wainwright Aaron on 7/19/15.
//  Copyright (c) 2015 Christopher Wainwright Aaron. All rights reserved.
//

import UIKit

class CarpoolAppointmentDetailViewController: UIViewController {
    
    var appointmentDetail: [String:AnyObject]?
    
    @IBOutlet weak var startLabel: UILabel!
    @IBOutlet weak var destinationLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var maxPassengerLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        startLabel.text = appointmentDetail!["start"] as? String
        destinationLabel.text = appointmentDetail!["destination"] as? String
        titleLabel.text = appointmentDetail!["title"] as? String
        descriptionLabel.text = appointmentDetail!["description"] as? String
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
