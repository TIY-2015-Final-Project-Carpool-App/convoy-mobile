//
//  DashboardTableViewCell.swift
//  CarPoolProject
//
//  Created by Christopher Wainwright Aaron on 7/2/15.
//  Copyright (c) 2015 Christopher Wainwright Aaron. All rights reserved.
//

import UIKit

class DashboardTableViewCell: UITableViewCell {

    @IBOutlet weak var deleteButton: UIButton!

    @IBOutlet weak var carpoolTitle: UILabel!

    @IBOutlet weak var updateButton: UIButton!

    @IBOutlet weak var detailButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        selectedBackgroundView.layer.cornerRadius = frame.height / 2
//        selectionStyle = UITableViewCellSelectionStyle.Blue
        
    }


}
