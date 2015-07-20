//
//  CarpoolUserViewController.swift
//  CarPoolProject
//
//  Created by Christopher Wainwright Aaron on 7/15/15.
//  Copyright (c) 2015 Christopher Wainwright Aaron. All rights reserved.
//

import UIKit

class CarpoolUserViewController: UIViewController {
    
    var userDetail: [String:AnyObject]?
    
    @IBOutlet weak var firstnameLabel: UILabel!
    @IBOutlet weak var lastnameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstnameLabel?.text = userDetail?["first_name"] as? String
        lastnameLabel?.text = userDetail?["last_name"] as? String
        usernameLabel?.text = userDetail?["username"] as? String
        addressLabel?.text = userDetail?["address"] as? String
        emailLabel?.text = userDetail?["email"] as? String
        phoneNumberLabel?.text = userDetail?["phone_number"] as? String
        
        
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
