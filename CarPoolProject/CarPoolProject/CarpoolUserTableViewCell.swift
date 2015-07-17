//
//  CarpoolUserTableViewCell.swift
//  CarPoolProject
//
//  Created by Christopher Wainwright Aaron on 7/15/15.
//  Copyright (c) 2015 Christopher Wainwright Aaron. All rights reserved.
//

import UIKit

class CarpoolUserTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var deleteUser: UIButton!
    
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
