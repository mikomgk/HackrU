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
		button.backgroundColor = UIColor(red: 0, green: 0.62, blue: 0.84, alpha: 1)
		button.layer.cornerRadius = 26
		button.addTarget(self, action: #selector(addTapped), for: .touchUpInside)
		view.insertSubview(button, aboveSubview: tabBar)
		
		navigationItem.hidesBackButton = true
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		if selectedViewController is MapViewController{
			navigationController?.isNavigationBarHidden = true
		}
	}
	
	@objc func addTapped(){
		alert = UIAlertController(title: "הוספה", message: "", preferredStyle: .actionSheet)//TODO: create add page
		let addFuel = UIAlertAction(title: "תדלוק", style: .default) { sender in
			self.openAddView(of: .refuel)
		}
		let addServise = UIAlertAction(title: "טיפול", style: .default) { sender in
			self.openAddView(of: .service)
		}
		let addExpense = UIAlertAction(title: "הוצאה", style: .default) { sender in
			self.openAddView(of: .expense)
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
	
	private func openAddView(of type: AddViewController.Addable){
		performSegue(withIdentifier: "addView", sender: type)
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "addView"{
			let dest = segue.destination as! AddViewController
			dest.addType = (sender as! AddViewController.Addable)
		}
	}
	
	@objc func hideAlert() {
		alert.dismiss(animated: true)
	}
}
