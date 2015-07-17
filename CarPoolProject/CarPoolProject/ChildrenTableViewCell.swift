//
//  ChildrenTableViewCell.swift
//  CarPoolProject
//
//  Created by Christopher Wainwright Aaron on 7/10/15.
//  Copyright (c) 2015 Christopher Wainwright Aaron. All rights reserved.
//

import UIKit

class ChildrenTableViewCell: UITableViewCell {
    
    @IBOutlet weak var childFName: UILabel!
    
    @IBOutlet weak var updateButton: UIButton!
    
    @IBOutlet weak var deleteButton: UIButton!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
