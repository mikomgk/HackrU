//
//  ViewController.swift
//  Proj3
//
//  Created by Miko Stern on 10/31/18.
//  Copyright © 2018 Miko Stern. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	var number: Double?
	@IBOutlet weak var numberLbl: UILabel!
	@IBOutlet weak var segment: UISegmentedControl!
	
	@IBAction func cngNumber(_ sender: UIStepper) {
		number = sender.value
		numberLbl.text = String(Int(number!))
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		let dir = segue.destination as? MainViewController
		dir?.numberVal = number
		dir?.segmentVal = segment.selectedSegmentIndex
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
	}


}

