//
//  BulletinTableViewCell.swift
//  CarPoolProject
//
//  Created by Christopher Wainwright Aaron on 7/4/15.
//  Copyright (c) 2015 Christopher Wainwright Aaron. All rights reserved.
//

import UIKit

class BulletinTableViewCell: UITableViewCell {
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var carpoolNameLabel: UILabel!
    @IBOutlet weak var bulletinTimeLabel: UILabel!
    @IBOutlet weak var bulletinTextView: UITextView!

    @IBOutlet weak var wrapperView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

        bulletinTextView.sizeToFit()
    
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
