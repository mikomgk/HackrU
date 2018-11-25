import Foundation

class Task: CustomStringConvertible {
	var title: String
	var taskDesc: String
	var date: Date
	
	var description: String{
		return "(\(title), \(taskDesc), \(date))"
	}
	
	init(title: String, taskDesc: String, date: Date) {
		self.title = title
		self.taskDesc = taskDesc
		self.date = date
	}
	
	var dict: Dictionary<String, Any>{
		return ["title": title, "taskDesc": taskDesc, "date": date.timeIntervalSince1970]
	}
	
	static func fromJson(_ json: Dictionary<String, Any>) -> Task{
		let d = json["date"] as! TimeInterval
		let date = Date(timeIntervalSince1970: d)
		let title = json["title"] as! String
		let taskDesc = json["taskDesc"] as! String
		return Task(title: title, taskDesc: taskDesc, date: date)
	}
}
