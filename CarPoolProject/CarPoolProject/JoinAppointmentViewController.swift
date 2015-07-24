//
//  JoinAppointmentViewController.swift
//  CarPoolProject
//
//  Created by Christopher Wainwright Aaron on 7/19/15.
//  Copyright (c) 2015 Christopher Wainwright Aaron. All rights reserved.
//

import UIKit

class JoinAppointmentViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var appointmentDetail: [String:AnyObject]?
    
    @IBOutlet weak var childTableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        childTableView.delegate = self
        childTableView.dataSource = self
        
        childTableView.backgroundColor = UIColor.clearColor()
        
        RailsRequest.session().getChildrenIndexWithCompletion { () -> Void in
            self.childTableView.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("joinChildCell", forIndexPath: indexPath) as! JoinAppointmentTableViewCell
        
        cell.childnameLabel.text = RailsRequest.session().childIds[indexPath.row]["first_name"] as? String
        cell.joinChildButton.tag = indexPath.row
        
        cell.backgroundColor = UIColor.clearColor()
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return RailsRequest.session().childIds.count
    }
    
    @IBAction func userJoinButton(sender: AnyObject) {
        
        let appointmentId = appointmentDetail!["id"] as! Int
        
        RailsRequest.session().joinAppointmentWithCompletion(appointmentId) { () -> Void in
            
            println("user have joined appointment")
        }
    }
    

    @IBAction func childJoinButton(sender: AnyObject) {
        
        if let cellButton = sender as? UIButton {
            
            let appointmentId = appointmentDetail!["id"] as! Int
            
            let childId = RailsRequest.session().childIds[cellButton.tag]["id"] as! Int
            
            RailsRequest.session().joinChildtoAppointmentWithCompletion(childId, appointmentId: appointmentId) { () -> Void in
                
                println("this child has joined the appointment")
            }
        }
    }
    
    @IBAction func backButton(sender: AnyObject) {
        
       // navigationController?.popViewControllerAnimated(true)
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
