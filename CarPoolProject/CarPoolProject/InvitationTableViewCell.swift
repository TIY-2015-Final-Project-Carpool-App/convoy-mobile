//
//  InvitationTableViewCell.swift
//  CarPoolProject
//
//  Created by Christopher Wainwright Aaron on 7/15/15.
//  Copyright (c) 2015 Christopher Wainwright Aaron. All rights reserved.
//

import UIKit

class InvitationTableViewCell: UITableViewCell {

    @IBOutlet weak var detailButton: UIButton!
    @IBOutlet weak var carpoolTitleLabel: UILabel!
    @IBOutlet weak var acceptInviteButton: UIButton!
    @IBOutlet weak var declineInviteButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
