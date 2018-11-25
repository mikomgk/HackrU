//
//  ViewController.swift
//  Proj1
//
//  Created by Miko Stern on 11/18/18.
//  Copyright © 2018 Miko Stern. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	
	
	@IBAction func tapped(_ sender: Any) {
		closeDialog()
	}
	@IBAction func loginBtn(_ sender: UIButton) {
		closeDialog()
	}
	func closeDialog(){
		UIView.animate(withDuration: 0.2, animations: {
			self.dialog.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
			self.blur.alpha = 0
		}) { comleted in
			self.dialog.removeFromSuperview()
			//self.dialog.transform = CGAffineTransform.identity
		}
	}
	@IBOutlet weak var blur: UIVisualEffectView!
	@IBOutlet var dialog: UIView!
	@IBAction func clicked(_ sender: UIButton) {
		
		self.view.addSubview(self.dialog)
		
		UIView.animate(withDuration: 0.2) {
			self.blur.alpha = 1
			self.dialog.transform = CGAffineTransform(scaleX: 1, y: 0.1)
			self.dialog.center = self.view.center
			self.dialog.alpha = 1
		}
		UIView.animate(withDuration: 0.2, delay: 0.2, options: .curveEaseIn, animations: {
			self.dialog.transform = CGAffineTransform(scaleX: 1, y: 1)
		}, completion: nil)
		
		//		for i in stride(from: 0.1, to: 0.7, by: 0.1){
		//			let x = i * 2
		//			let isHalf = Int(i * 10) % 2 == 1
		//			UIView.animate(withDuration: i, delay: i - 0.05, options: .curveEaseIn, animations: {
		//				self.blur.alpha = 1
		//				self.dialog.transform = CGAffineTransform(scaleX: CGFloat(x), y: CGFloat(x))
		//				self.dialog.transform = CGAffineTransform(rotationAngle: isHalf ? CGFloat.pi : CGFloat.pi * 2)
		//				self.dialog.center = self.view.center
		//				self.dialog.alpha = CGFloat(x)
		//			}, completion: nil)
		//		}
		
		
		//dialog.center = CGPoint(x: self.view.center.x, y: 0)
		//self.dialog.center.x = self.view.center.x
		
		//		UIView.animate(withDuration: 0.5) {
		//			self.dialog.transform = CGAffineTransform(scaleX: 1, y: 1)
		//			self.dialog.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
		//			self.dialog.center = self.view.center
		//			self.dialog.alpha = 1
		//			//			sender.backgroundColor = UIColor.red
		//			//			sender.frame.size.width = sender.frame.size.width * 2
		//			//			sender.center = self.view.center
		//		}
		
	}
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.dialog.frame.size.width = self.view.frame.size.width / 2
		self.dialog.transform = CGAffineTransform(scaleX: 0, y: 0)
		self.dialog.center = self.view.center
		self.dialog.alpha = 0
		blur.alpha = 0
	}
	
	
}

