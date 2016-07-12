//
//  FoodCell.swift
//  FoodTracker
//
//  Created by Chun Cao on 16/7/12.
//  Copyright © 2016年 idup. All rights reserved.
//

import UIKit

class FoodCell: UITableViewCell {

    @IBOutlet weak var foodName: UILabel!
    
    
    @IBOutlet weak var foodImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
