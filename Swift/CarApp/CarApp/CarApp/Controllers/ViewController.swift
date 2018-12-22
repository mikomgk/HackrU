//
//  ViewController.swift
//  CarApp
//
//  Created by Miko Stern on 12/16/18.
//  Copyright © 2018 Miko Stern. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	let auth = Auth.shared
	var token: String?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		//auth.deleteToken()
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		token = auth.getToken()
		if token == nil{//TODO: check if logic
			performSegue(withIdentifier: "auth", sender: nil)
		}else{
			performSegue(withIdentifier: "app", sender: nil)
		}
	}
}

