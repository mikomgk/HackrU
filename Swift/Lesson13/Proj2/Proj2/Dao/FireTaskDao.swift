import UIKit
import Firebase

class FireTaskDao: TaskDao{
	static var shared: TaskDao = FireTaskDao()
	weak var delegate: TaskDaoDelegate?
	let ref: DatabaseReference!
	
	private init() {
		ref = Database.database().reference()
	}
	
	func addTask(_ task: Task) -> String {
		let key = ref.child("tasks").childByAutoId().key!
		ref.child("tasks").child(key).setValue(task.json)
		return key
	}
	
	func deleteTask(_ task: Task) {
		ref.child("tasks").child(task.id).setValue(nil)
	}
	
	func editTask(_ task: Task, withDescription description: String) {
		ref.child("tasks").child(task.id).child("description").setValue(description)
	}
	
	func toggleTask(_ task: Task) {
		ref.child("tasks").child(task.id).child("status").setValue(task.status.rawValue)
	}
	
	func getAllTasks(){
		var uncheckedTasks = [Task]()
		var checkedTasks = [Task]()
		ref.child("tasks").observeSingleEvent(of: .value, with: { snapdshot in
			let value = snapdshot.value as? NSDictionary
			guard let _ = value else { return }
			for v in value!{
				let id = v.key as! String
				let details = v.value as! NSDictionary
				let desc = details["description"] as! String
				let status = details["status"] as! String
				let s = Status(rawValue: status)!
				let orderLocation = details["orderLocation"] as! Int
				let task = Task(desc, status: s, orderLocation: orderLocation, id: id)
				if s == .checked{
					checkedTasks.append(task)
				}else{
					uncheckedTasks.append(task)
				}
				print(task)
			}
			self.delegate?.tasksArrived(tasks: (unchecked: uncheckedTasks, checked: checkedTasks))
		}) { (error) in
			print(error.localizedDescription)
		}
	}
	
	
}
