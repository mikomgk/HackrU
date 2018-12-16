//
//  AuthViewController.swift
//  CarApp
//
//  Created by Miko Stern on 12/16/18.
//  Copyright © 2018 Miko Stern. All rights reserved.
//

import UIKit

class AuthViewController: UIViewController {
	
	@IBOutlet weak var userNameLbl: UILabel!
	@IBOutlet weak var passwordLbl: UILabel!
	@IBOutlet weak var userNameTxt: UITextField!
	@IBOutlet weak var passwordTxt: UITextField!
	@IBOutlet weak var loginBtn: UIButton!
	@IBOutlet weak var registerBtn: UIButton!
	@IBOutlet weak var loginBtnLeftConstraint: NSLayoutConstraint!
	@IBOutlet weak var loginBtnRightConstraint: NSLayoutConstraint!
	@IBOutlet weak var loginBtnBottomConstraint: NSLayoutConstraint!
	
	@IBOutlet weak var registerBtnBottomConstraint: NSLayoutConstraint!
	
	let auth = Auth.shared
	var btnHorizontalConstraintSize: CGFloat = 32
	var loginBtnHeightFromBottom: CGFloat {
		return loginBtnBottomConstraint.constant + registerBtnBottomConstraint.constant + registerBtn.frame.size.height
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		UIView.appearance().semanticContentAttribute = .forceRightToLeft
		
		//btnWidth = loginBtn.frame.size.width
		loginBtn.layer.cornerRadius = 15
		registerBtn.layer.cornerRadius = 15
		userNameTxt.underlined(borderColor: UIColor.lightGray)
		passwordTxt.underlined(borderColor: UIColor.lightGray)
		userNameTxt.delegate = self
		passwordTxt.delegate = self
		
		NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
		
		self.hideKeyboardWhenTappedAround()
	}
	
	@IBAction func userNameStarted(_ sender: UITextField) {
		lblUp(txt: userNameTxt, lbl: userNameLbl)
		userNameTxt.underlined(borderColor: UIColor.green)
	}
	
	@IBAction func userNameEnded(_ sender: UITextField) {
		lblDown(txt: userNameTxt, lbl: userNameLbl)
		userNameTxt.underlined(borderColor: UIColor.lightGray)
	}
	
	@IBAction func passwordStarted(_ sender: UITextField) {
		lblUp(txt: passwordTxt, lbl: passwordLbl)
		passwordTxt.underlined(borderColor: UIColor.green)
	}
	
	@IBAction func passwordEnded(_ sender: UITextField) {
		lblDown(txt: passwordTxt, lbl: passwordLbl)
		passwordTxt.underlined(borderColor: UIColor.lightGray)
	}
	
	@IBAction func signupTapped(_ sender: UIButton) {
	}
	
	@IBAction func loginTapped(_ sender: UIButton) {
		auth.login()
	}
	
	@objc func keyboardWillShow(notification: NSNotification) {
		if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
			if view.frame.origin.y == 0 {
				let moveSize = UIScreen.main.bounds.height - keyboardSize.origin.y - loginBtnHeightFromBottom
				view.frame.origin.y -= moveSize
				loginBtnLeftConstraint.constant = 0
				loginBtnRightConstraint.constant = 0
				UIView.animate(withDuration: 0.5) {
					self.view.layoutIfNeeded()
					self.loginBtn.layer.cornerRadius = 0
				}
			}
		}
	}
	
	@objc func keyboardWillHide(notification: NSNotification) {
		if self.view.frame.origin.y != 0 {
			self.view.frame.origin.y = 0
			loginBtnLeftConstraint.constant = btnHorizontalConstraintSize
			loginBtnRightConstraint.constant = btnHorizontalConstraintSize
			UIView.animate(withDuration: 0.5) {
				self.view.layoutIfNeeded()
				self.loginBtn.layer.cornerRadius = 15
			}
		}
	}
	
	@objc func keyboardWillChange(notification: NSNotification) {
		UIView.animate(withDuration: 0.3) {
			self.keyboardWillHide(notification: notification)
			self.keyboardWillShow(notification: notification)
		}
	}
	
	func lblUp(txt: UITextField, lbl: UILabel){
		if txt.text?.isEmpty ?? false{
			UIView.animate(withDuration: 0.5) {
				lbl.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
				lbl.transform = CGAffineTransform(translationX: 0, y: -25)
			}
		}
	}
	
	func lblDown(txt: UITextField, lbl: UILabel){
		if txt.text?.isEmpty ?? false{
			UIView.animate(withDuration: 0.5) {
				lbl.transform = CGAffineTransform.identity
			}
		}
	}
	
	/*
	// MARK: - Navigation
	
	// In a storyboard-based application, you will often want to do a little preparation before navigation
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
	// Get the new view controller using segue.destination.
	// Pass the selected object to the new view controller.
	}
	*/
	
}

extension AuthViewController: UITextFieldDelegate{
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		if textField == userNameTxt{
			passwordTxt.becomeFirstResponder()
		}else if textField == passwordTxt{
			auth.login()
		}
		return true
	}
}

extension UITextField {
	
	func underlined(borderColor: UIColor) {
		
		self.borderStyle = .none
		self.backgroundColor = UIColor.clear
		
		let borderLine = UIView()
		let height = 1.0
		
		borderLine.frame = CGRect(x: 0, y: Double(self.frame.height) - height, width: Double(self.frame.size.width), height: height)
		//TODO: ipgone xr width: Double(self.frame.size.width) +
		
		borderLine.backgroundColor = borderColor
		borderLine.transform = CGAffineTransform(translationX: 0, y: 10)
		self.addSubview(borderLine)
	}
}

extension UIViewController {
	func hideKeyboardWhenTappedAround() {
		let backgroundTapRecognizer: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.hideKeyboard))
		backgroundTapRecognizer.cancelsTouchesInView = false
		view.addGestureRecognizer(backgroundTapRecognizer)
	}
	
	@objc func hideKeyboard() {
		view.endEditing(true)
	}
}
