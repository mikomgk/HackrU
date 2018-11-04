//
//  WonViewController.swift
//  MemoryGame
//
//  Created by Miko Stern on 10/31/18.
//  Copyright © 2018 Miko Stern. All rights reserved.
//

import UIKit

class WonViewController: UIViewController {
	@IBOutlet weak var movesLbl: UILabel!
	@IBOutlet weak var timeLbl: UILabel!
	@IBOutlet weak var ttlLbl: UILabel!
	@IBOutlet weak var nextBtn: UIButton!
	
	var finishedLevel: Int?
	var moves: Int?
	var time: String?
	var maxLevel: Int?
	var gameFinished = false
	
	override func viewDidLoad() {
		super.viewDidLoad()
		if let finishedLevel = finishedLevel{
			if let maxLevel = maxLevel{
				if finishedLevel == maxLevel{
					ttlLbl.text = "You finished the game"
					nextBtn.isHidden = true
					self.nextBtn.setTitle("Start Again", for: .normal)
					setTimeOutTimer(do: {
						self.nextBtn.isHidden = false
						self.gameFinished = true
					}, after: 2)
				} else {
					ttlLbl.text = "You finished level \(finishedLevel)"
				}
			} else {
				ttlLbl.text = "You finished level \(finishedLevel)"
			}
		}
		movesLbl.text = "\(moves ?? 0)"
		timeLbl.text = time ?? "0:00"
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let dest = segue.destination as? ViewController{
			dest.level = gameFinished ? 1 : finishedLevel! + 1
		}
	}
}
