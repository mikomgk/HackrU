//
//  ViewController.swift
//  Proj2
//
//  Created by Miko Stern on 11/25/18.
//  Copyright © 2018 Miko Stern. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	
	var person: Person!

	@IBOutlet weak var firstNameTxt: UITextField!
	@IBOutlet weak var lastNameTxt: UITextField!
	@IBOutlet weak var ageTxt: UITextField!
	lazy var appDelegate: AppDelegate = {
		return UIApplication.shared.delegate as! AppDelegate
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		firstNameTxt.placeholder = person.firstName
		lastNameTxt.placeholder = person.lastName
		ageTxt.placeholder = String(person.age)
	}
	
	@IBAction func changeTapped(_ sender: UIButton) {
		let fN = firstNameTxt.text!
		let lN = lastNameTxt.text!
		let a = Int(ageTxt.text!) ?? 0
		appDelegate.editPerson(person, firstName: fN, lastName: lN, age: a)
		goBack()
	}
	
	@IBAction func deleteTapped(_ sender: UIBarButtonItem) {
		appDelegate.deletePerson(person)
		goBack()
	}
	
	func goBack(){
		navigationController?.popViewController(animated: true)
	}
}

