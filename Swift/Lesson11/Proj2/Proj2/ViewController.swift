//
//  ViewController.swift
//  Proj2
//
//  Created by Miko Stern on 11/24/18.
//  Copyright © 2018 Miko Stern. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	@IBOutlet weak var blurView: UIVisualEffectView!
	@IBOutlet weak var titleTxt: UITextField!
	@IBOutlet weak var taskDescTxt: UITextField!
	@IBOutlet weak var datePkr: UIDatePicker!
	@IBOutlet var dialogView: UIView!
	var defaults: UserDefaults?
	var tasks = [Task]()
	
	fileprivate func closeDialog() {
		UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 10, options: .curveEaseIn, animations: {
			self.dialogView.center.y = 0
			self.dialogView.alpha = 0
			self.blurView.alpha = 0
		}){_ in
			self.dialogView.removeFromSuperview()
		}
	}
	
	@IBAction func addTask(_ sender: UIButton) {
		let title = titleTxt.text ?? ""
		let taskDesc = taskDescTxt.text ?? ""
		let date = datePkr.date
		let task = Task(title: title, taskDesc: taskDesc, date: date)
		tasks.append(task)
		var jsonArray = [Dictionary<String, Any>]()
		for task in tasks{
			jsonArray.append(task.dict)
		}
		defaults?.set(jsonArray, forKey: "jsonArray")
		
		closeDialog()
	}
	
	@IBAction func onBlurTap(_ sender: UITapGestureRecognizer) {
		closeDialog()
	}
	
	@IBAction func plus(_ sender: UIBarButtonItem) {
		titleTxt.text = ""
		taskDescTxt.text = ""
		datePkr.date = Date()
		dialogView.center.x = self.view.center.x
		self.view.addSubview(dialogView)
		UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 10, options: .curveEaseIn, animations: {
			self.dialogView.center.y = self.view.center.y
			self.dialogView.alpha = 1
			self.blurView.alpha = 1
		}, completion: nil)
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		dialogView.layer.cornerRadius = 15
		dialogView.layer.masksToBounds = true
		let h = titleTxt.frame.size.height * 5 + datePkr.frame.size.height + 30
		dialogView.frame.size.height = h
		
		defaults = UserDefaults.standard
		//defaults?.removeObject(forKey: "jsonArray")
		guard let arr = defaults?.array(forKey: "jsonArray") as? [Dictionary<String, Any>] else { return }
		for item in arr{
			tasks.append(Task.fromJson(item))
		}
		print(tasks)
	}


}

