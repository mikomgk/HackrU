//
//  SongTableViewCell.swift
//  Proj1
//
//  Created by Miko Stern on 11/14/18.
//  Copyright © 2018 Miko Stern. All rights reserved.
//

import UIKit

class SongTableViewCell: UITableViewCell {
	let session = URLSession(configuration: .default)
	

    override func awakeFromNib() {
        super.awakeFromNib()
		
		
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
