//
//  taskTableViewCell.swift
//  Proj2
//
//  Created by Miko Stern on 11/30/18.
//  Copyright © 2018 Miko Stern. All rights reserved.
//

import UIKit

class taskTableViewCell: UITableViewCell {
	@IBOutlet weak var taskLabel: UILabel!
	@IBOutlet weak var checkedImg: UIImageView!
	
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
