//
//  CreatePostViewController.swift
//  CarPoolProject
//
//  Created by Christopher Wainwright Aaron on 7/19/15.
//  Copyright (c) 2015 Christopher Wainwright Aaron. All rights reserved.
//

import UIKit

class CreatePostViewController: UIViewController {
    
    var carpoolId: Int?
    
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var postBody: UITextView!
    @IBOutlet weak var urgencyField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func createPost(sender: AnyObject) {
        
        RailsRequest.session().title = titleField.text
        RailsRequest.session().body = postBody.text
        RailsRequest.session().urgency = urgencyField.text
        
        RailsRequest.session().createPostWithCompletion(carpoolId!) { () -> Void in
            
            self.dismissViewControllerAnimated(false, completion: nil)
        }
        
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
