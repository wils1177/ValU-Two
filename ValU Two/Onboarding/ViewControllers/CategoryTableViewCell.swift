//
//  CategoryTableViewCell.swift
//  ValU Two
//
//  Created by Clayton Wilson on 7/12/19.
//  Copyright © 2019 Clayton Wilson. All rights reserved.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.accessoryType = selected ? .checkmark : .none

        // Configure the view for the selected state
    }

}
