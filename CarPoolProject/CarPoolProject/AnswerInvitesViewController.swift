//
//  AnswerInvitesViewController.swift
//  CarPoolProject
//
//  Created by Christopher Wainwright Aaron on 7/15/15.
//  Copyright (c) 2015 Christopher Wainwright Aaron. All rights reserved.
//

import UIKit

class AnswerInvitesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIAlertViewDelegate {
    
    
    @IBOutlet weak var invitationsTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        invitationsTableView.delegate = self
        invitationsTableView.dataSource = self
        
        RailsRequest.session().getPendingInvitesWithCompletion { () -> Void in
            self.invitationsTableView.reloadData()
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        invitationsTableView.reloadData()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("invitationCell", forIndexPath: indexPath) as! InvitationTableViewCell
        
        if let carpool = RailsRequest.session().invites[indexPath.row]["carpool"] as? [String:AnyObject] {
            if let carpoolTitle = carpool["title"] as? String {
                cell.carpoolTitleLabel.text = carpoolTitle
                cell.detailButton.tag = indexPath.row
            }
            
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return RailsRequest.session().invites.count
    }
    var joinToken = ""
    var carpoolId = 1
    
    @IBAction func acceptInvite(sender: UIButton) {
        
        let acceptButton = sender
        
        
        
        if let theCarpool = RailsRequest.session().invites[acceptButton.tag]["carpool"] as? [String:AnyObject] {
            println("this is theCarpool info \(theCarpool)")
            if let carpoolID = theCarpool["id"] as? Int {
                println("this is the carpool ID \(carpoolID)")
                carpoolId = carpoolID

            }
            if let invitedUser = RailsRequest.session().invites[acceptButton.tag]["invited_user"] as? [String:AnyObject] {
                if let joinedToken = invitedUser["join_token"] as? String {
                    println(joinedToken)
                    joinToken = joinedToken
                
                }
            }
        
        RailsRequest.session().acceptInviteWithCompletion(carpoolId, joinToken: joinToken, completion: { () -> Void in
        
            println("\(self.carpoolId)")
            println(self.joinToken)
            
            let alertView = UIAlertView()
            alertView.title = "Success"
            alertView.message = "Invited has been accepted"
            alertView.delegate = self
            alertView.addButtonWithTitle("OK")
            alertView.show()
      
        })
        
        }
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if let cellButton = sender as? UIButton {
            
            let invite = RailsRequest.session().invites[cellButton.tag] 
                
                if let inviteDetailVC = segue.destinationViewController as? InviteDetailViewController {
                    
                    inviteDetailVC.invite = invite
                }
            
        }
    }
    

}
