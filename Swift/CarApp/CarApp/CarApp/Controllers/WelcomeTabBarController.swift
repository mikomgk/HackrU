//
//  WelcomeTabBarController.swift
//  CarApp
//
//  Created by Miko Stern on 12/16/18.
//  Copyright © 2018 Miko Stern. All rights reserved.
//

import UIKit

class WelcomeTabBarController: UITabBarController {

	let button = UIButton(type: .custom)
	var alert: UIAlertController!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		UIView.appearance().semanticContentAttribute = .forceRightToLeft
		
		let buttonSize:CGFloat = 52
		var topSafeAreaHeight: CGFloat = 0
		if #available(iOS 11.0, *) {
			let window = UIApplication.shared.windows[0]
			topSafeAreaHeight = window.safeAreaInsets.top
		}
		let add: CGFloat = isXDevice ? 0 : 10
		let buttonY: CGFloat = view.bounds.height - topSafeAreaHeight - buttonSize + add
		button.frame = CGRect(x: tabBar.center.x - 26, y: buttonY, width: buttonSize, height: buttonSize)
		button.setTitle("+", for: .normal)
		button.setTitleColor(.white, for: .normal)
		button.titleLabel!.font = button.titleLabel!.font.withSize(35)
		button.backgroundColor = UIColor(red: 0, green: 0.48, blue: 1, alpha: 1)
		button.layer.cornerRadius = 26
		button.addTarget(self, action: #selector(addTapped), for: .touchUpInside)
		view.insertSubview(button, aboveSubview: tabBar)
	}
	
	@objc func addTapped(){
		alert = UIAlertController(title: "הוספה", message: "", preferredStyle: .actionSheet)//TODO: create add page
		let addFuel = UIAlertAction(title: "תדלוק", style: .default) { sender in
			
		}
		let addServise = UIAlertAction(title: "טיפול", style: .default) { sender in
			
		}
		let addExpense = UIAlertAction(title: "הוצאה", style: .default) { sender in
			
		}
		alert.addAction(addFuel)
		alert.addAction(addServise)
		alert.addAction(addExpense)
		present(alert, animated: true){
			self.alert.view.superview?.subviews[1].isUserInteractionEnabled = true
			let backgroundTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.hideAlert))
			self.alert.view.superview?.subviews[1].addGestureRecognizer(backgroundTapRecognizer)
		}
	}
	
	@objc func hideAlert() {
		alert.dismiss(animated: true)
	}
}
