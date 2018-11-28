//
//  PersonTableViewController.swift
//  Proj2
//
//  Created by Miko Stern on 11/25/18.
//  Copyright © 2018 Miko Stern. All rights reserved.
//

import UIKit
import CoreData

class PersonTableViewController: UITableViewController {
	
	var alertDialog: UIAlertController!
	var people = [Person]()
	var blurEffectView: UIVisualEffectView?
	lazy var appDelegate: AppDelegate = {
		return UIApplication.shared.delegate as! AppDelegate
	}()

	@IBAction func add(_ sender: UIBarButtonItem) {
		alertDialog = UIAlertController(title: "New Person", message: "", preferredStyle: .alert)
		alertDialog.addTextField { txtField in
			txtField.placeholder = "First Name"
		}
		alertDialog.addTextField { txtField in
			txtField.placeholder = "Last Name"
		}
		alertDialog.addTextField { txtField in
			txtField.placeholder = "Age"
		}
		alertDialog.addAction(UIAlertAction(title: "ADD", style: .default, handler: { action in
			let textFields = self.alertDialog.textFields!
			let firstName = textFields[0].text!
			let lastName = textFields[1].text!
			let ageStr = textFields[2].text!
			let age = Int(ageStr) ?? 0
			
			UIView.animate(withDuration: 0.2) {
				self.blurEffectView?.alpha = 0
			}
			self.appDelegate.addPerson(firstName: firstName, lastName: lastName, age: age)
			self.people = self.appDelegate.fetchPeople()
			self.tableView.reloadData()
			self.tableView.scrollToRow(at: IndexPath(row: self.people.count-1, section: 0), at: .bottom, animated: true)
		}))
		self.present(alertDialog, animated: true)
		UIView.animate(withDuration: 0.2) {
			self.blurEffectView?.alpha = 1
		}
	}
	
	override func viewDidLoad() {
        super.viewDidLoad()
		
		let blurEffect = UIBlurEffect(style: .dark)
		blurEffectView = UIVisualEffectView(effect: blurEffect)
		blurEffectView?.frame = view.bounds
		blurEffectView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
		blurEffectView?.alpha = 0
		view.addSubview(blurEffectView!)
		
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
	
	override func viewWillAppear(_ animated: Bool) {
		people = appDelegate.fetchPeople()
		self.tableView.reloadData()
	}

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let row = indexPath.row
        let cell = tableView.dequeueReusableCell(withIdentifier: "PersonCell", for: indexPath)
		let person = people[row]
		//person.value(forKey: "firstName") as! String
		cell.textLabel?.text = "\(person)"

        return cell
    }
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let row = indexPath.row
		performSegue(withIdentifier: "PersonDetails", sender: people[row])
	}

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

	override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let row = indexPath.row
			appDelegate.deletePerson(people.remove(at: row))
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
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

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dest = segue.destination as? ViewController
		let person = sender as? Person
		dest?.person = person
    }
}
