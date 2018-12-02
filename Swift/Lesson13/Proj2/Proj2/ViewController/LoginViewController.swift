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
	@IBOutlet weak var emailTxt: UITextField!
	@IBOutlet weak var passTxt: UITextField!
	@IBOutlet weak var rememberSwitch: UISwitch!
	static let rememberDefaultsKey = "rememberUser"
	
	var email: String{
		return emailTxt.text!
	}
	var password: String{
		return passTxt.text!
	}
	var isRemember: Bool{
		return rememberSwitch.isOn
	}
	
	@IBAction func loginTapped(_ sender: UIButton) {
		Auth.auth().signIn(withEmail: email, password: password, completion: loginCallback(user:err:))
	}
	
	@IBAction func registerTapped(_ sender: UIButton) {
		Auth.auth().createUser(withEmail: email, password: password, completion: loginCallback(user:err:))
	}
	
	func loginCallback(user: AuthDataResult?, err: Error?){
		guard let user = user else{
			print(err ?? "Err")
			return
		}
		print(user)
		dismiss(animated: true)
		rememberUser()
	}
	
	func rememberUser(){
		UserDefaults.standard.set(isRemember, forKey: LoginViewController.rememberDefaultsKey)
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
	}

	
}

