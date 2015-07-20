//
//  JoinAppointmentTableViewCell.swift
//  CarPoolProject
//
//  Created by Christopher Wainwright Aaron on 7/19/15.
//  Copyright (c) 2015 Christopher Wainwright Aaron. All rights reserved.
//

import UIKit

class JoinAppointmentTableViewCell: UITableViewCell {
    
    @IBOutlet weak var joinChildButton: UIButton!
    @IBOutlet weak var childnameLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
