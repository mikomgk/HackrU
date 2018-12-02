import Foundation

class Task: CustomStringConvertible{
	var description: String{
		return "\(orderLocation). \(desc): \(status)"
	}
	var desc: String
	var status: Status
	var orderLocation: Int
	var id: String
	static var shared: Task = {
		let task = Task()
		Task.countTasks.unchecked -= 1
		return task
	}()
	static var countTasks: (unchecked: Int, checked: Int) = (0, 0)
	
	init(_ desc: String) {
		self.desc = desc
		self.status = .unchecked
		self.orderLocation = Task.countTasks.unchecked
		self.id = ""
		Task.countTasks.unchecked += 1
	}
	
	init(_ desc: String, status: Status, orderLocation: Int, id: String) {
		self.desc = desc
		self.status = status
		self.orderLocation = orderLocation
		self.id = id
		let isChecked = status == .checked
		if isChecked{
			Task.countTasks.checked += 1
		}else{
			Task.countTasks.unchecked += 1
		}
	}
	
	init() {
		self.desc = Date().description
		self.status = .unchecked
		self.orderLocation = Task.countTasks.unchecked
		self.id = ""
		Task.countTasks.unchecked += 1
	}
	
	func toggleStatus(){
		let wasUnchecked = self.status == .unchecked
		self.status = wasUnchecked ? .checked : .unchecked
		self.orderLocation = wasUnchecked ? Task.countTasks.checked : Task.countTasks.unchecked
		if wasUnchecked{
			Task.countTasks.unchecked -= 1
			Task.countTasks.checked += 1
		}else{
			Task.countTasks.unchecked += 1
			Task.countTasks.checked -= 1
		}
	}
}

enum Status: String{
	case checked = "checked", unchecked = "unchecked"
}
