import UIKit
import SQLite3

class SqliteTaskDao: TaskDao{
	static var shared: TaskDao = SqliteTaskDao()
	private let db = openDatabase()
	let isTableExistKey = "isTableExist"
	lazy var userDefaults = UserDefaults.standard
	
	private init() {
		//dropTable()
		createTable()
	}
	
	func addTask(_ task: Task) -> String{
		let addQuery = """
						INSERT INTO tasks(description, status, orderLocation)
						VALUES(?, ?, ?)
						"""
		let desc = task.desc
		let status = task.status.rawValue
		let orderLocation = task.orderLocation
		let _ = exec(addQuery, withPreparedStatement: desc, status, orderLocation)
		return getLstTaskId()
	}
	
	func deleteTask(_ task: Task) {
		let deletString = "DELETE FROM tasks WHERE id = ?"
		let _ = exec(deletString, withPreparedStatement: task.id)
	}
	
	func editTask(_ task: Task, withDescription description: String) {
		let toggleString = "UPDATE tasks SET description = ? WHERE id = ?"
		let _ = exec(toggleString, withPreparedStatement: description, task.id)
	}
	
	func toggleTask(_ task: Task) {
		let toggleString = "UPDATE tasks SET status = ? WHERE id = ?"
		let status = task.status.rawValue
		let _ = exec(toggleString, withPreparedStatement: status, task.id)
	}
	
	func getAllTasks() -> [[Task]] {
		let selectString = "SELECT * FROM tasks"
		let results = exec(selectString)
		var checkedTasks = [Task]()
		var uncheckedTasks = [Task]()
		for r in results{
			let id = r[0]
			let desc = r[1]
			let status = r[2]
			let s = Status(rawValue: status)!
			let orderLocation = Int(r[3])!
			let task = Task(desc, status: s, orderLocation: orderLocation, id: id)
			if s == .checked{
				checkedTasks.append(task)
			}else{
				uncheckedTasks.append(task)
			}
			print(task)
		}
		return [uncheckedTasks, checkedTasks]
	}
	
	private func getLstTaskId() -> String{
		let getIdString = "SELECT last_insert_rowid()"
		let r = exec(getIdString)
		return r[0][0]
	}
	
	private func createTable(){
		if userDefaults.bool(forKey: isTableExistKey){
			return
		}
		let createTableString = """
								CREATE TABLE tasks(
									id INTEGER PRIMARY KEY AUTOINCREMENT,
									description TEXT NOT NULL,
									status TEXT NOT NULL,
									orderLocation INTEGER NOT NULL
								)
								"""
		let _ = exec(createTableString)
		userDefaults.set(true, forKey: isTableExistKey)
	}
	
	private func dropTable(){
		let dropTableString = "DROP TABLE tasks"
		let _ = exec(dropTableString)
		userDefaults.set(false, forKey: isTableExistKey)
	}
	
	private func exec(_ query: String) -> [[String]]{
		return exec(query, withPreparedStatement: [])
	}
	
	private func exec(_ query: String, withPreparedStatement args: Any...) -> [[String]]{
		var results = [[String]]()
		var preparedStatement: OpaquePointer? = nil
		if sqlite3_prepare_v2(db, query, -1, &preparedStatement, nil) == SQLITE_OK{
			
			for (i, arg) in args.enumerated(){
				let index = Int32(i + 1)
				if arg is Int{
					sqlite3_bind_int(preparedStatement, index, Int32(arg as! Int))
				}else if arg is String{
					let str = NSString(string: arg as! String)
					sqlite3_bind_text(preparedStatement, index, str.utf8String, -1, nil)
				}
			}
			let status = sqlite3_step(preparedStatement)
			if status == SQLITE_ROW{
				repeat{
					var result = [String]()
					for i in 0 ..< sqlite3_column_count(preparedStatement){
						result.append(String(cString: sqlite3_column_text(preparedStatement, i)))
					}
					results.append(result)
				}while(sqlite3_step(preparedStatement) == SQLITE_ROW)
				print(results)
			}else if status != SQLITE_DONE{
				fatalError("Err: \(String(cString: sqlite3_errmsg(db)))")
			}
			print("SQLITE \(status): \(String(cString: sqlite3_expanded_sql(preparedStatement)))")
			sqlite3_finalize(preparedStatement)
		}else{
			fatalError("not prepared")
		}
		return results
	}
	
	private static func openDatabase() -> OpaquePointer?{
		let fm = FileManager.default
		let documents = fm.urls(for: .documentDirectory, in: .userDomainMask)[0]
		let dbPath = documents.absoluteString + "mydb"
		if !fm.fileExists(atPath: dbPath){
			fm.createFile(atPath: dbPath, contents: Data(), attributes: nil)
		}
		var db: OpaquePointer? = nil
		if sqlite3_open(dbPath, &db) == SQLITE_OK{
			print("db is open")
			return db
		}else{
			fatalError("cant open db")
		}
	}
}
