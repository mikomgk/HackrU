//
//  AuthViewController.swift
//  CarApp
//
//  Created by Miko Stern on 12/16/18.
//  Copyright © 2018 Miko Stern. All rights reserved.
//

import UIKit

class AuthViewController: UIViewController {
	
	
	@IBOutlet weak var loginView: UIView!
	@IBOutlet weak var registerView: UIView!
	@IBOutlet var views: [UIView]!
	@IBOutlet weak var registerTitleLbl: UILabel!
	
	
	@IBOutlet var errorLbl: [UILabel]!
	@IBOutlet var actionBtn: [UIButton]!
	@IBOutlet var semiBtn: [UIButton]!
	@IBOutlet var actionBtnLeftConstraint: [NSLayoutConstraint]!
	@IBOutlet var actionBtnRightConstraint: [NSLayoutConstraint]!
	@IBOutlet var actionBtnBottomConstraint: [NSLayoutConstraint]!
	@IBOutlet var semiBtnBottomConstraint: [NSLayoutConstraint]!
	
	
	@IBOutlet weak var loginEmailTxt: UITextField!
	@IBOutlet weak var loginPasswordTxt: UITextField!
	@IBOutlet var loginTxts: [UITextField]!
	@IBOutlet var loginLbls: [UILabel]!
	
	@IBOutlet weak var registerEmailTxt: UITextField!
	@IBOutlet weak var registerPasswordTxt: UITextField!
	@IBOutlet weak var registerConfirmPasswordTxt: UITextField!
	@IBOutlet var registerTxts: [UITextField]!
	@IBOutlet var registerLbls: [UILabel]!
	
	var txts: [UITextField]!
	var lbls: [UILabel]!
	
	let emailErrorMessage = "אימייל לא תקין"
	let nameErrorMessage = "שם לא תקין"
	let passwordErrorMessage = "סיסמה צריכה להכיל אות גדולה, אות קטנה, ספרה וסימן"
	let confirmPasswordErrorMessage = "סיסמאות לא זהות"
	let loginErrorMessage = "קרתה שגיאה אנא נסה שוב מאוחר יותר"
	
	let auth = Auth.shared
	var email: String{ return isRegisterView ? registerEmailTxt.text! : loginEmailTxt.text! }
	var password: String{ return isRegisterView ? registerPasswordTxt.text! : loginPasswordTxt.text! }
	var isRegisterView = true{
		didSet{
			viewIndex = isRegisterView ? 1 : 0
		}
	}
	var viewIndex = 0
	var btnHorizontalConstraintSize: CGFloat!
	var btnBottomConstraintSize: CGFloat!
	var actionBtnHeightFromBottom: CGFloat!
	var isKeyboardOpen = false
	var isActionEnabled = false
	var isFirstNameValid: Bool = false{
		didSet{
			validationChanged()
		}
	}
	var isLastNameValid: Bool = false{
		didSet{
			validationChanged()
		}
	}
	var isEmailValid: Bool = false{
		didSet{
			validationChanged()
		}
	}
	var isPasswordValid: Bool = false{
		didSet{
			validationChanged()
		}
	}
	var isConfirmPasswordValid: Bool = false{
		didSet{
			validationChanged()
		}
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		UIView.appearance().semanticContentAttribute = .forceRightToLeft
		
		btnHorizontalConstraintSize = actionBtnLeftConstraint[viewIndex].constant
		btnBottomConstraintSize = actionBtnBottomConstraint[viewIndex].constant
		actionBtnHeightFromBottom = btnBottomConstraintSize + semiBtnBottomConstraint[viewIndex].constant + semiBtn[viewIndex].frame.size.height
		txts = loginTxts
		lbls = loginLbls
		
		setCurvedButtons()
		setTextFields(loginTxts)
		setTextFields(registerTxts)
		toogleView()
		
		NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
		
		self.hideKeyboardWhenTappedAround()
		auth.delegate = self
	}
	
	func validationChanged(){
		isActionEnabled = isFirstNameValid && isLastNameValid && isEmailValid && isPasswordValid && isConfirmPasswordValid
	}
	
	func setCurvedButtons(){
		for i in 0...1{
			actionBtn[i].layer.cornerRadius = 15
			semiBtn[i].layer.cornerRadius = 15
		}
	}
	
	func setTextFields(_ texts: [UITextField]){
		for t in texts{
			t.underlined(borderColor: UIColor.lightGray)
			t.delegate = self
		}
	}
	
	func toogleView(){
		isRegisterView = !isRegisterView
		UIView.animate(withDuration: 0.3) {
			self.loginView.alpha = abs(self.loginView.alpha - 1)
			self.registerView.alpha = abs(self.registerView.alpha - 1)
		}
		clearTexts(isRegisterView ? registerTxts : loginTxts)
		moveLblsDown(lbls)
		errorLbl[viewIndex].text = ""
		txts = isRegisterView ? registerTxts : loginTxts
		lbls = isRegisterView ? registerLbls : loginLbls
		isFirstNameValid = !isRegisterView
		isLastNameValid = !isRegisterView
		isEmailValid = false
		isPasswordValid = false
		isConfirmPasswordValid = !isRegisterView
		
	}
	
	func clearTexts(_ texts: [UITextField]){
		for t in texts{
			t.text = ""
			t.underlined(borderColor: UIColor.lightGray)
		}
	}
	
	func moveLblsDown(_ lbls: [UILabel]){
		for l in lbls{
			l.moveDown()
		}
	}
	
	func loginSignup(){
		if !isActionEnabled{ return }
		let user: LoginUser
		if isRegisterView{
			let firstName = txts[0].text!
			let lastName = txts[1].text!
			user = RegisterUser(email: email, password: password, firstName: firstName, lastName: lastName)
		}else{
			user = LoginUser(email: email, password: password)
		}
		auth.loginSignup(withUser: user)
	}
	
	@IBAction func semiBtnTapped(_ sender: UIButton) {
		toogleView()
	}
	
	@IBAction func actionBtnTapped(_ sender: UIButton) {
		view.endEditing(true)
		loginSignup()
	}
	
	@IBAction func textFieldStarted(_ sender: UITextField) {
		let lbl = lbls[txts.firstIndex(of: sender)!]
		if sender.text?.isEmpty ?? false{
			lbl.moveUp()
		}
		sender.underlined(borderColor: UIColor.green)
	}
	
	@IBAction func textFieldChanged(_ sender: UITextField) {
		errorLbl[viewIndex].text = ""
		let senderText = sender.text!
		switch (txts.firstIndex(of: sender), isRegisterView) {
		case (0, true):
			isFirstNameValid = senderText.isValidName
		case (1, true):
			isLastNameValid = senderText.isValidName
		case (2, true), (0, false):
			isEmailValid = senderText.isValidEmail
		case (3, true), (1, false):
			isPasswordValid = senderText.isValidPassword
		default:
			let password = registerPasswordTxt.text
			let passwordConfirmmed = !password!.isEmpty && password == senderText
			isConfirmPasswordValid = senderText.isValidPassword && passwordConfirmmed
		}
	}
	
	@IBAction func textFieldEnded(_ sender: UITextField) {
		let lbl = lbls[txts.firstIndex(of: sender)!]
		let errLbl = errorLbl[viewIndex]
		sender.underlined(borderColor: UIColor.lightGray)
		let text = sender.text!
		if text.isEmpty{
			lbl.moveDown()
			errLbl.text = ""
			return
		}
		let wrongEmail = sender.textContentType == .emailAddress ? !text.isValidEmail : false
		let wrongPassword = sender.textContentType == .password ? !text.isValidPassword : false
		let wrongName = sender.textContentType == .name ? !text.isValidName : false
		if wrongEmail || wrongPassword || wrongName{
			if wrongEmail{
				errLbl.text = emailErrorMessage
			}else if wrongPassword{
				errLbl.text = passwordErrorMessage
			}else if wrongName{
				errLbl.text = nameErrorMessage
			}
			sender.setAsErroor()
		}else if sender == registerPasswordTxt || sender == registerConfirmPasswordTxt{
			let pass = registerPasswordTxt.text!
			let confPass = registerConfirmPasswordTxt.text!
			if !pass.isEmpty && !confPass.isEmpty{
				if pass != confPass{
					errLbl.text = confirmPasswordErrorMessage
					registerConfirmPasswordTxt.setAsErroor()
				}
			}
		}
	}
	
	@objc func keyboardWillShow(notification: NSNotification) {
		if !isKeyboardOpen{
			errorLbl[viewIndex].text = ""
		}
		isKeyboardOpen = true
		if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
			if view.frame.origin.y == 0{
				let moveSize: CGFloat
				let btnToKeyboardSpace = UIScreen.main.bounds.height - keyboardSize.origin.y - actionBtnHeightFromBottom
				if !isRegisterView{
					moveSize = btnToKeyboardSpace
				}else{
					let spaceFromTop: CGFloat = 60
					moveSize = view.convert(txts[0].frame.origin, to: view).y - spaceFromTop
					let btnMoveSize = btnToKeyboardSpace
					actionBtnBottomConstraint[viewIndex].constant = btnMoveSize
				}
				view.frame.origin.y -= moveSize
				actionBtnLeftConstraint[viewIndex].constant = 0
				actionBtnRightConstraint[viewIndex].constant = 0
				UIView.animate(withDuration: 0.5) {
					self.view.layoutIfNeeded()
					self.actionBtn[self.viewIndex].layer.cornerRadius = 0
				}
			}
		}
	}
	
	@objc func keyboardWillHide(notification: NSNotification) {
		isKeyboardOpen = false
		if self.view.frame.origin.y != 0 {
			self.view.frame.origin.y = 0
			actionBtnLeftConstraint[viewIndex].constant = btnHorizontalConstraintSize
			actionBtnRightConstraint[viewIndex].constant = btnHorizontalConstraintSize
			actionBtnBottomConstraint[viewIndex].constant = btnBottomConstraintSize
			UIView.animate(withDuration: 0.5) {
				self.view.layoutIfNeeded()
				self.actionBtn[self.viewIndex].layer.cornerRadius = 15
			}
		}
	}
	
	@objc func keyboardWillChange(notification: NSNotification) {
		if isKeyboardOpen{
			self.keyboardWillHide(notification: notification)
			isKeyboardOpen = true
			self.keyboardWillShow(notification: notification)
		}
	}
}

extension AuthViewController: AuthDelegate{
	func onLogin(success: Bool, withError err: String?) {
		if success{
			self.dismiss(animated: true)
		}else{
			errorLbl[viewIndex].text = err ?? loginErrorMessage
		}
	}
}

extension AuthViewController: UITextFieldDelegate{
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		if textField == txts.last{
			view.endEditing(true)
			loginSignup()
		}else{
			let currentIndex = txts.firstIndex(of: textField)!
			txts[currentIndex + 1].becomeFirstResponder()
		}
		return true
	}
}

extension UILabel{
	func moveUp(){
		UIView.animate(withDuration: 0.5) {
			self.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
			self.transform = CGAffineTransform(translationX: 0, y: -25)
		}
	}
	
	func moveDown(){
		UIView.animate(withDuration: 0.5) {
			self.transform = CGAffineTransform.identity
		}
	}
}

extension UITextField {
	func setAsErroor(){
		underlined(borderColor: UIColor.red)
		shakeView()
	}
	
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

extension String{
	var isValidName: Bool{
		return !isEmpty && count >= 2
	}
	
	var isValidEmail: Bool{
		let emailRegex = "^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}$"
		return !isEmpty && matches(emailRegex)
	}
	
	var isValidPassword: Bool{
		let passwordRegex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#\\$%\\^&\\*])(?=.{8,})"
		return !isEmpty && matches(passwordRegex)
//		if isEmpty || count < 8 { return false }
//		var upper = false
//		var lower = false
//		var digit = false
//		var symbol = false
//		for c in self{
//			if c.isUppercase{
//				upper = true
//			}else if c.isLowercase{
//				lower = true
//			}else if c.isDigit{
//				digit = true
//			}else if c.isSymbol{
//				symbol = true
//			}
//		}
//		return upper && lower && digit && symbol
	}
	
	func matches(_ regex: String) -> Bool{
		return range(of: regex, options: .regularExpression) != nil
	}
}

extension Character{
	var isUppercase: Bool{
		return "A"..."Z" ~= self
	}
	
	var isLowercase: Bool{
		return "a"..."z" ~= self
	}
	
	var isDigit: Bool{
		return "0"..."9" ~= self
	}
	
	var isSymbol: Bool{
		return self == "!" || "#"..."&" ~= self || self == "@"
	}
}

extension UIView{
	func shakeView(){
		UIView.animate(withDuration: 0.2, animations: {
			UIView.setAnimationRepeatCount(3)
			self.transform = CGAffineTransform(translationX: -10, y: 0)
			self.transform = CGAffineTransform(translationX: 10, y: 0)
		}) { bool in
			self.transform = CGAffineTransform.identity
		}
	}
}
