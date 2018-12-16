//
//  WelcomeTabBarController.swift
//  Optica
//
//  Created by Miko Stern on 12/12/18.
//  Copyright © 2018 Miko Stern. All rights reserved.
//

import UIKit

class WelcomeTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		performSegue(withIdentifier: "auth", sender: nil)
	}
}
