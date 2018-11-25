//
//  ViewController.swift
//  Proj1
//
//  Created by Miko Stern on 11/24/18.
//  Copyright © 2018 Miko Stern. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
	
	@IBOutlet weak var cowImg: UIImageView!
	@IBOutlet weak var dogImg: UIImageView!
	var cowPlayer: AVAudioPlayer?
	var dogPlayer: AVAudioPlayer?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		rotateImg(cowImg)
		rotateImg(dogImg)
		
		initPlayers()
	}
	
	@IBAction func dogClicked(_ sender: UITapGestureRecognizer) {
		animalTapped("dog", withSound: dogPlayer, atImage: sender.view as! UIImageView)
	}
	
	@IBAction func cowClicked(_ sender: UITapGestureRecognizer) {
		animalTapped("cow", withSound: cowPlayer, atImage: sender.view as! UIImageView)
	}
	
	func animalTapped(_ animalName: String, withSound sound: AVAudioPlayer?, atImage image: UIImageView){
		print(animalName)
		sound?.play()
		rotateImg(image)
	}
	
	func rotateImg(_ img: UIImageView) {
		img.transform = CGAffineTransform(translationX: 0.1, y: 0.1)
		UIView.animateKeyframes(withDuration: 0.5, delay: 0, options: [.repeat], animations: {
			UIView.setAnimationRepeatCount(3)
			UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5){
				img.transform = CGAffineTransform(rotationAngle: CGFloat(Float.pi))
			}
			UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5){
				img.transform = CGAffineTransform(rotationAngle: CGFloat(2 * Float.pi))
			}
		}, completion: nil)
	}
	
	func initPlayers() {
		let cowUrl = Bundle.main.url(forResource: "cow", withExtension: "wav")!
		let dogUrl = Bundle.main.url(forResource: "dog", withExtension: "wav")!
		do{
			cowPlayer = try AVAudioPlayer(contentsOf: cowUrl)
			dogPlayer = try AVAudioPlayer(contentsOf: dogUrl)
		}catch let e{
			print(e)
		}
	}
}

