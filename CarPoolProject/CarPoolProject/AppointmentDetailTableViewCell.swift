//
//  AppointmentDetailTableViewCell.swift
//  CarPoolProject
//
//  Created by Christopher Wainwright Aaron on 7/23/15.
//  Copyright (c) 2015 Christopher Wainwright Aaron. All rights reserved.
//

import UIKit

class AppointmentDetailTableViewCell: UITableViewCell {
    
    @IBOutlet weak var firstnameLabel: UILabel!
    @IBOutlet weak var riderType: UILabel!
    @IBOutlet weak var detailButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
