//
//  ViewController.swift
//  Proj3
//
//  Created by Miko Stern on 10/28/18.
//  Copyright © 2018 Miko Stern. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	@IBOutlet weak var lbl: UILabel!
	@IBAction func fontSizeCng(_ sender: UISlider) {
		let size = Int(sender.value)
		lbl.text = String(size)
		//lbl.font = lbl.font.withSize(CGFloat(size))
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
	}


}

