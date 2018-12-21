//
//  WelcomeTabBarController.swift
//  CarApp
//
//  Created by Miko Stern on 12/16/18.
//  Copyright © 2018 Miko Stern. All rights reserved.
//

import UIKit

class WelcomeTabBarController: UITabBarController {

	let auth = Auth.shared
	var token: String?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		token = auth.getToken()
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		if true{//token == nil{
			performSegue(withIdentifier: "auth", sender: nil)
		}
	}
}
