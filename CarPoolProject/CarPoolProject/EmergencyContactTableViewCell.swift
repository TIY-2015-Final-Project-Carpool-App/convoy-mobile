//
//  EmergencyContactTableViewCell.swift
//  CarPoolProject
//
//  Created by Christopher Wainwright Aaron on 7/13/15.
//  Copyright (c) 2015 Christopher Wainwright Aaron. All rights reserved.
//

import UIKit

class EmergencyContactTableViewCell: UITableViewCell {
    
    @IBOutlet weak var editContact: UIButton!
    @IBOutlet weak var deleteContact: UIButton!
    
    @IBOutlet weak var contactFName: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
