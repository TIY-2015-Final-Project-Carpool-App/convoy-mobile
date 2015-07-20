//
//  UserAppointmentTableViewCell.swift
//  CarPoolProject
//
//  Created by Christopher Wainwright Aaron on 7/18/15.
//  Copyright (c) 2015 Christopher Wainwright Aaron. All rights reserved.
//

import UIKit

class UserAppointmentTableViewCell: UITableViewCell {

    @IBOutlet weak var setMap: UIButton!
    @IBOutlet weak var detailButton: UIButton!
    @IBOutlet weak var creatorLabel: UILabel!
    @IBOutlet weak var destinationLabel: UILabel!
    @IBOutlet weak var roleLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!

    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
