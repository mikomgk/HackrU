//
//  ViewController.swift
//  Proj2
//
//  Created by Miko Stern on 11/28/18.
//  Copyright © 2018 Miko Stern. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

	@IBOutlet weak var userTxt: UITextField!
	@IBOutlet weak var passTxt: UITextField!
	var email: String{
		return userTxt.text!
	}
	var password: String{
		return passTxt.text!
	}
	
	@IBAction func loginTapped(_ sender: UIButton) {
		Auth.auth().signIn(withEmail: email, password: password) {[weak self] (user, err) in
			guard let user = user else{
				print(err ?? "Err")
				return
			}
			print(user)
			self?.performSegue(withIdentifier: "afterLogIn", sender: nil)
		}
	}
	@IBAction func registerTapped(_ sender: UIButton) {
		Auth.auth().createUser(withEmail: email, password: password) {[weak self] (user, err) in
			guard let user = user else{
				print(err ?? "Err")
				return
			}
			print(user)
			self?.performSegue(withIdentifier: "afterLogIn", sender: nil)
		}
	}
	override func viewDidLoad() {
		super.viewDidLoad()
		
		
	}
	override func viewDidAppear(_ animated: Bool) {
		if Auth.auth().currentUser != nil{
			performSegue(withIdentifier: "afterLogIn", sender: nil)
		}
	}

	
}

