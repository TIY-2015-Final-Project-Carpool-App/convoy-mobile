//
//  CarpoolAppointmentTableViewCell.swift
//  CarPoolProject
//
//  Created by Christopher Wainwright Aaron on 7/19/15.
//  Copyright (c) 2015 Christopher Wainwright Aaron. All rights reserved.
//

import UIKit

class CarpoolAppointmentTableViewCell: UITableViewCell {
    
    @IBOutlet weak var creatorLabel: UILabel!
    @IBOutlet weak var destinationLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailButton: UIButton!
    @IBOutlet weak var joinAppointment: UIButton!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
