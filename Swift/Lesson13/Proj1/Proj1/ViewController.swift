//
//  ViewController.swift
//  Proj1
//
//  Created by Miko Stern on 11/28/18.
//  Copyright © 2018 Miko Stern. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		
		let db = CharactersDao.shared
		let results = db.exec("select * from characters", withPreparedStatement: [])
		print(results[0],results[1])
	}


}

