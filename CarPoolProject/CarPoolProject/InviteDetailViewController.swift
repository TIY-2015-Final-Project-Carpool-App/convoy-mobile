//
//  InviteDetailViewController.swift
//  CarPoolProject
//
//  Created by Christopher Wainwright Aaron on 7/15/15.
//  Copyright (c) 2015 Christopher Wainwright Aaron. All rights reserved.
//

import UIKit

class InviteDetailViewController: UIViewController {
    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var firstnameLabel: UILabel!
    @IBOutlet weak var lastnameLabel: UILabel!
    
    var invite: [String:AnyObject]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let carpool = invite!["carpool"] as? [String:AnyObject]
        
        titleLabel.text = carpool!["title"] as? String
        descriptionLabel.text = carpool!["description"] as? String
        var creator = carpool!["creator"] as? [String:AnyObject]
        firstnameLabel.text = creator!["first_name"] as? String
        lastnameLabel.text = creator!["last_name"] as? String
  
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
