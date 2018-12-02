import UIKit
import Firebase

class FireTaskDao: TaskDao{
	static var shared: TaskDao = FireTaskDao()
	let ref: DatabaseReference!
	
	private init() {
		ref = Database.database().reference()
	}
	
	func addTask(_ task: Task) -> String {
		let desc: Dictionary = ["description":task.desc]
		let status: Dictionary = ["status":task.status.rawValue]
		let orderLocation: Dictionary = ["orderLocation":task.orderLocation]
		let taskDict: [Dictionary<String,Any>] = [desc, status, orderLocation]
		let key = ref.child("tasks").childByAutoId().key!
		print("add")
		ref.child("tasks").child(key).setValue(taskDict)
		print("finish")
		return key
	}
	
	func deleteTask(_ task: Task) {
		return
	}
	
	func editTask(_ task: Task, withDescription description: String) {
		return
	}
	
	func toggleTask(_ task: Task) {
		return
	}
	
	func getAllTasks() -> [[Task]] {
		return [[Task](), [Task]()]
	}
	
	
}
