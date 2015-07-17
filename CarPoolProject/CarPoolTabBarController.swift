//
//  CarPoolTabBarController.swift
//  CarPoolProject
//
//  Created by Christopher Wainwright Aaron on 7/8/15.
//  Copyright (c) 2015 Christopher Wainwright Aaron. All rights reserved.
//

import UIKit

class CarPoolTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
         }
    
    override func viewDidAppear(animated: Bool) {
        
        if RailsRequest.session().token == nil {
            var wvc = self.storyboard?.instantiateViewControllerWithIdentifier("welcomeVC") as! WelcomeViewController
            self.presentViewController(wvc, animated: true, completion: nil)
        }
        
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
