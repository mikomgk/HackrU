//
//  ViewController.swift
//  Proj2
//
//  Created by Miko Stern on 11/14/18.
//  Copyright © 2018 Miko Stern. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	
	//let w = self.view.frame.size.width
	//dialogView.frame.size = CGSize(w,h)
	//dialofView.center = self.view.center
	//self.view.addSubview(dialogView)
	//dialogView.removeFromSuperview()
	
	var alert: UIAlertController!
	
	@IBOutlet weak var titleLbl: UILabel!
	@IBOutlet weak var usernameTxt: UITextField!
	@IBOutlet weak var passwordTxt: UITextField!
	@IBOutlet weak var cancelBtn: UIButton!
	@IBOutlet weak var loginBtn: UIButton!
	
	
	@IBOutlet weak var dialog: UIVisualEffectView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		let w = self.view.frame.size.width / 2
		let h = titleLbl.frame.size.height + usernameTxt.frame.size.height + passwordTxt.frame.size.height + loginBtn.frame.size.height
		dialog.contentView.frame.size = CGSize(width: w, height: h)
		dialog.contentView.center = self.view.center
		dialog.contentView.layer.cornerRadius = 15
		dialog.contentView.layer.masksToBounds = true
		print(self.view.frame.size.width,w,titleLbl.frame.size.height,usernameTxt.frame.size.height,passwordTxt.frame.size.height,loginBtn.frame.size.height,h,self.view.center,dialog.contentView.center, separator: "\n")
	}
	
	@objc func textChanged(sender: UITextField){
		if(sender.text!.count < 6){
			alert.actions[0].isEnabled = false
		} else {
			alert.actions[0].isEnabled = true
		}
	}
	
	@objc func togglePassword(sender: UIImageView){
		
	}
	
	@IBAction func showDialog(_ sender: Any) {
		dialog.isHidden = false
	}
	
	@IBAction func showSheet(_ sender: UIButton) {
		let sheet = UIAlertController(title: "Share", message: "Message", preferredStyle: .actionSheet)
		sheet.addAction(UIAlertAction(title: "default", style: .default) {action in
			
		})
		sheet.addAction(UIAlertAction(title: "cancel", style: .cancel) {action in
			
		})
		sheet.addAction(UIAlertAction(title: "destructive", style: .destructive) {action in
			
		})
		present(sheet, animated: true)
	}
	
	@IBAction func showAlert(_ sender: UIButton) {
		alert  = UIAlertController(title: "Login", message: "", preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: "YES", style: .default){ (UIAlertAction) in
			print("YES")
		})
		alert.addAction(UIAlertAction(title: "NO", style: .cancel){ (UIAlertAction) in
			print("NO")
		})
		alert.addTextField { (textField) in
			textField.placeholder = "User Name"
			textField.addTarget(self, action: #selector(self.textChanged(sender:)), for: .editingChanged)
		}
		alert.addTextField { (textField) in
			textField.placeholder = "Password"
			textField.isSecureTextEntry = true
			let eyeImage = UIImage(named: "eye")
			let eyeIV = UIImageView(image: eyeImage)
			//eyeIV.addTarget
			textField.rightViewMode = .always
			textField.rightView = eyeIV
		}
		present(alert, animated: true)
	}


}

