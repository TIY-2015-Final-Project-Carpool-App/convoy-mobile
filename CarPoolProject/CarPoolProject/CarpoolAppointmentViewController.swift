//
//  CarpoolAppointmentViewController.swift
//  CarPoolProject
//
//  Created by Christopher Wainwright Aaron on 7/19/15.
//  Copyright (c) 2015 Christopher Wainwright Aaron. All rights reserved.
//

import UIKit

class CarpoolAppointmentViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var carpoolId: Int?
    @IBOutlet weak var carpoolAppointmentTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        carpoolAppointmentTableView.dataSource = self
        carpoolAppointmentTableView.delegate = self
        
        RailsRequest.session().carpoolAppointmentsWithCompletion(carpoolId!, completion: { () -> Void in
            
            self.carpoolAppointmentTableView.reloadData()
        })
    }
    
    override func viewWillAppear(animated: Bool) {
        carpoolAppointmentTableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return RailsRequest.session().carpoolAppointments.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("carpoolAppointmentCell", forIndexPath: indexPath) as! CarpoolAppointmentTableViewCell
        
        if let creator = RailsRequest.session().carpoolAppointments[indexPath.row]["creator"] as? [String:AnyObject] {
            
            cell.creatorLabel.text = creator["username"] as? String
        }
        
        let appointmentInfo = RailsRequest.session().carpoolAppointments[indexPath.row]
            
        cell.destinationLabel.text = appointmentInfo["destination"] as? String
        cell.titleLabel.text = appointmentInfo["title"] as? String
    
        
        cell.detailButton.tag = indexPath.row
        cell.joinAppointment.tag = indexPath.row
        
        return cell
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if let cellButton = sender as? UIButton {
            
            let appointmentDetail = RailsRequest.session().carpoolAppointments[cellButton.tag]
            
            if let carpoolAppointmentDetailVC = segue.destinationViewController as? CarpoolAppointmentDetailViewController {
                carpoolAppointmentDetailVC.appointmentDetail = appointmentDetail
            }
        }
        
        if let cellButton = sender as? UIButton {
            
            let appointmentDetail = RailsRequest.session().carpoolAppointments[cellButton.tag]
            
            if let joinAppointmentVC = segue.destinationViewController as? JoinAppointmentViewController {
                
                joinAppointmentVC.appointmentDetail = appointmentDetail
            }
        }
    }
    

}
