//
//  UserAppointmentViewController.swift
//  CarPoolProject
//
//  Created by Christopher Wainwright Aaron on 7/18/15.
//  Copyright (c) 2015 Christopher Wainwright Aaron. All rights reserved.
//

import UIKit

class UserAppointmentViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var appointmentDetail: [String:AnyObject]?
    var riders: [[String:AnyObject]] = [[:]]
    var riderType: String?
    
    @IBOutlet weak var startLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var originLabel: UILabel!
    @IBOutlet weak var destinationLabel: UILabel!
    @IBOutlet weak var riderAmountLabel: UILabel!
    
    @IBOutlet weak var RidersTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        RidersTableView.delegate = self
        RidersTableView.dataSource = self
        
        if let start = appointmentDetail!["start"] as? String {
        
        let dateFormatter = NSDateFormatter()
        let dateString = start
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'.000'zzzz"
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        let date = dateFormatter.dateFromString(dateString)
        let printDate = date?.description
        startLabel.text = printDate
        }
        
        
        titleLabel.text = appointmentDetail!["title"] as? String
        originLabel.text = appointmentDetail!["origin"] as? String
        destinationLabel.text = appointmentDetail!["destination"] as? String
        
        let amount = appointmentDetail!["riders"] as? [String:AnyObject]
        let riderAmount = amount?.count
        riderAmountLabel.text = "\(riderAmount)"
        
        RidersTableView.backgroundColor = UIColor.clearColor()
        if let myRiders = appointmentDetail!["riders"] as? [[String:AnyObject]] {
            riders = myRiders
        }
        println(riders)
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("appointmentDetailCell", forIndexPath: indexPath) as! AppointmentDetailTableViewCell
        
        if let rider = riders[indexPath.row]["rider"] as? [String:AnyObject] {
            if let firstname = rider["first_name"] as? String {
               
                cell.firstnameLabel.text = firstname
            }
      
        }
        
        riderType = riders[indexPath.row]["ridable_type"] as? String
        cell.riderType.text = riders[indexPath.row]["ridable_type"] as? String
        cell.backgroundColor = UIColor.clearColor()
        cell.detailButton.tag = indexPath.row
        
        return cell
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return riders.count
    }
    
    @IBAction func backButton(sender: AnyObject) {
        
       // navigationController?.popViewControllerAnimated(true)
        
        dismissViewControllerAnimated(false, completion: nil)
    }
    
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
      
        if let cellButton = sender as? UIButton {
            
            if riders[cellButton.tag]["ridable_type"] as? String == "Child" {
                
                if let rider = riders[cellButton.tag]["rider"] as? [String:AnyObject] {
                    
                    let userAppointmentDetailVC = segue.destinationViewController as! UserAppointmentDetailViewController
                    userAppointmentDetailVC.rider = rider
                    
                    
                    let childId = rider["id"] as! Int
                    
                    RailsRequest.session().getChildMedicalInfo(childId, completion: { () -> Void in
                        
                        println("this is running")
                        userAppointmentDetailVC.conditionsLabel.text = RailsRequest.session().conditions
                        userAppointmentDetailVC.medicationsLabel.text = RailsRequest.session().medications
                        userAppointmentDetailVC.notesLabel.text = RailsRequest.session().notes
                        userAppointmentDetailVC.allergiesLabel.text = RailsRequest.session().allergies
                        userAppointmentDetailVC.insuranceLabel.text = RailsRequest.session().insurance
                        userAppointmentDetailVC.religionLabel.text = RailsRequest.session().religiousPreference
                        userAppointmentDetailVC.bloodtypeLabel.text = RailsRequest.session().bloodType
                        
                    })

                    
                }
                
                
            } else {
                
                if let rider = riders[cellButton.tag]["rider"] as? [String:AnyObject] {
                    
                    let userAppointmentDetailVC = segue.destinationViewController as! UserAppointmentDetailViewController
                    userAppointmentDetailVC.rider = rider
                    println("user is running")
                    
                }
            }
        }
        
    }
    

}
