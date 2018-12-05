//
//  TodoTableViewController.swift
//  Proj2
//
//  Created by Miko Stern on 11/28/18.
//  Copyright © 2018 Miko Stern. All rights reserved.
//

import UIKit
import Firebase

class TodoTableViewController: UITableViewController {
	var dao: TaskDao?
	var tasks = [[Task](), [Task]()]
	lazy var userName: String = {
		let mail = (Auth.auth().currentUser?.email)!
		let index = mail.firstIndex(of: "@")
		return String(mail.prefix(upTo: index ?? mail.endIndex))
	}()
	var isInsertCell = false
	var editCell: Int? = nil
	var insertCell: NewTaskTableViewCell?
	var nonInsertCellTapped: UITapGestureRecognizer!
	var addBarBtn: UIBarButtonItem!
	var doneBarBtn: UIBarButtonItem!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		//todo assign dao
		// Uncomment the following line to preserve selection between presentations
		// self.clearsSelectionOnViewWillAppear = false
		nonInsertCellTapped = UITapGestureRecognizer(target: self, action: #selector(self.handleInsertion(sender:)))
		
		addBarBtn = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.insertBtnTapped(sender:)))
		doneBarBtn = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.handleInsertion(sender:)))
		self.navigationItem.rightBarButtonItem = addBarBtn
		self.navigationItem.rightBarButtonItem?.isEnabled = false
		tableView.separatorStyle = .none
	}
	
	override func viewDidAppear(_ animated: Bool) {
		let remembered = UserDefaults.standard.bool(forKey: LoginViewController.rememberDefaultsKey)
		if Auth.auth().currentUser == nil || !remembered{
			performSegue(withIdentifier: "loginSegue", sender: nil)
		}
		self.navigationItem.title = userName.capitalizingFirstLetter()
		dao = FireTaskDao.shared
		dao?.delegate = self
		dao?.getAllTasks()
		//tableView.reloadData()
	}
	
//	@objc func handleCheckedImgTapped(sender: UITapGestureRecognizer) {
//		let tapLocation = sender.location(in: tableView)
//		if let tapIndexPath = tableView.indexPathForRow(at: tapLocation){
//			//if let tappedCell = tableView.cellForRow(at: tapIndexPath){
//			let row = tapIndexPath.row
//			let task = tasks[0][row]
//
//			task.toggleStatus()
//			dao?.toggleTask(task)
//			//}
//		}
//	}
	
	@objc func insertBtnTapped(sender: Any){
		insertNewTaskCell()
	}
	
	func insertNewTaskCell(){
		tasks[0].insert(Task.shared, at: 0)
		isInsertCell = true
		self.navigationItem.setRightBarButton(doneBarBtn, animated: true)
		let index = IndexPath(row: 0, section: 0)
		tableView.insertRows(at: [index], with: .top)
		tableView.addGestureRecognizer(nonInsertCellTapped)
	}
	
	@objc func handleInsertion(sender: UITapGestureRecognizer){
		doneInsertion()
	}
	
	func doneInsertion(){
		let taskDesc = insertCell?.newDescriptionTxt.text
		if !(taskDesc?.isEmpty ?? true){
			let task = Task(taskDesc!)
			let id = dao?.addTask(task)
			task.id = id ?? ""
			tasks[0][0] = task
			tableView.reloadData()
		}else{
			tasks[0].remove(at: 0)
			let index = IndexPath(row: 0, section: 0)
			tableView.deleteRows(at: [index], with: .automatic)
		}
		disableInsertRow()
		tableView.removeGestureRecognizer(nonInsertCellTapped)
	}
	
	func disableInsertRow(){
		isInsertCell = false
		insertCell = nil
		self.navigationItem.setRightBarButton(addBarBtn, animated: true)
	}
	
	// MARK: - Table view data source
	
	override func numberOfSections(in tableView: UITableView) -> Int {
		// #warning Incomplete implementation, return the number of sections
		return tasks.count
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		// #warning Incomplete implementation, return the number of rows
		return tasks[section].count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let row = indexPath.row
		let section = indexPath.section
		if isInsertCell && row == 0{
			let cell = tableView.dequeueReusableCell(withIdentifier: "insertTask", for: indexPath) as! NewTaskTableViewCell
			cell.newDescriptionTxt.text = ""
			insertCell = cell
			cell.newDescriptionTxt.becomeFirstResponder()
			cell.newDescriptionTxt.updateFocusIfNeeded()
			tableView.bringSubviewToFront(cell)
			return cell
		}
		let cell = tableView.dequeueReusableCell(withIdentifier: "task", for: indexPath) as! taskTableViewCell
		cell.taskLabel?.text = tasks[section][row].desc
		cell.checkedImg.image = section == 0 ? UIImage(named: "unchecked") : UIImage(named: "checked")
		return cell
	}
	
	override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
		print(indexPath)
	}
	
	override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
		// Return false if you do not want the specified item to be editable.
		return true
	}
	
	
	override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
		if editingStyle == .delete {
			let sec = indexPath.section
			let row = indexPath.row
			dao?.deleteTask(tasks[sec].remove(at: row))
			tableView.deleteRows(at: [indexPath], with: .fade)
		} else if editingStyle == .insert {
			// Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
		}
	}
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let row = indexPath.row
		let section = indexPath.section
		let wasUnchecked = section == 0
		let newSection = wasUnchecked ? 1 : 0
		let task = tasks[section][row]
		task.toggleStatus()
		dao?.toggleTask(task)
		let newRow = task.orderLocation
		tasks[newSection].append(tasks[section].remove(at: row))
		let cell = tableView.cellForRow(at: indexPath) as! taskTableViewCell
		UIView.transition(with: cell.checkedImg, duration: 0.2, options: .transitionCrossDissolve, animations: {
			cell.checkedImg.image = wasUnchecked ? UIImage(named: "checked") : UIImage(named: "unchecked")
		}) { _ in
			let index = IndexPath(row: newRow, section: newSection)
			tableView.moveRow(at: indexPath, to: index)
			self.updateEmptySectionsIfNeeded()
		}
	}
	
	func updateEmptySectionsIfNeeded(){
		for i in 0 ..< tasks.count{
			if tasks[i].count == 0{
				tableView.reloadSections([i], with: .fade)
			}
		}
	}
	
	func hideSectionsHeadersIfNeeded(){
		for i in 0 ..< tasks.count{
			let sectionHeader = tableView.headerView(forSection: i)
			if tasks[i].count == 0{
				sectionHeader?.isHidden = true
			}else{
				sectionHeader?.isHidden = false
			}
		}
	}
	
	override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		if section == 0{
			return "ToDo"
		}else{
			return "Done"
		}
	}
	
	override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		if tasks[section].count == 0{
			return 0
		}
		return 30
	}
	
	/*
	// Override to support rearranging the table view.
	override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
	
	}
	*/
	
	/*
	// Override to support conditional rearranging of the table view.
	override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
	// Return false if you do not want the item to be re-orderable.
	return true
	}
	*/
	
	/*
	// MARK: - Navigation
	
	// In a storyboard-based application, you will often want to do a little preparation before navigation
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
	// Get the new view controller using segue.destination.
	// Pass the selected object to the new view controller.
	}
	*/
	
}

extension TodoTableViewController: TaskDaoDelegate{
	func tasksArrived(tasks: (unchecked: [Task], checked: [Task])) {
		self.tasks = [tasks.unchecked, tasks.checked]
		DispatchQueue.main.async {
			self.navigationItem.rightBarButtonItem?.isEnabled = true
			self.tableView.reloadData()
		}
	}
}

extension String{
	func capitalizingFirstLetter() -> String{
		return prefix(1).uppercased() + self.lowercased().dropFirst()
	}
}

extension UIView {
	var parentViewController: UIViewController? {
		var parentResponder: UIResponder? = self
		while parentResponder != nil {
			parentResponder = parentResponder!.next
			if let viewController = parentResponder as? UIViewController {
				return viewController
			}
		}
		return nil
	}
}
