import UIKit
import SQLite3

class CharactersDao {
	static let shared = CharactersDao()

	let dropTableString = "DROP TABLE characters"
	let selectString = "SELECT * FROM characters"
	let insertString = """
		INSERT INTO characters(firstName, lastName, serialNumber)
		VALUES(?, ?, ?)
	"""
	let createTableString = """
		CREATE TABLE characters(
									id INTEGER PRIMARY KEY AUTOINCREMENT,
									firstName TEXT NOT NULL,
									lastName TEXT NOT NULL,
									serialNumber INTEGER
								)
	"""
	
	let db = openDatabase()
	
	private init() {}
	
	func selectCharacters(){
		var preparedStatement: OpaquePointer? = nil
		if sqlite3_prepare_v2(db, selectString, -1, &preparedStatement, nil) == SQLITE_OK{
			while sqlite3_step(preparedStatement) == SQLITE_ROW{
				let id = sqlite3_column_int(preparedStatement, 0)
				let firstName = sqlite3_column_text(preparedStatement, 1)
				let lastName = sqlite3_column_text(preparedStatement, 2)
				let serialNumber = sqlite3_column_int(preparedStatement, 3)
				print("\(id) - \(String(cString: firstName!)) \(String(cString: lastName!)) - \(serialNumber)")
			}
			sqlite3_finalize(preparedStatement)
		}else{
			print("not prepared")
		}
	}
	
	func insertCharacter(withFirsName firstName: NSString, lastName: NSString, serialNumber: Int){
		var preparedStatement: OpaquePointer? = nil
		if sqlite3_prepare_v2(db, insertString, -1, &preparedStatement, nil) == SQLITE_OK{
			sqlite3_bind_int(preparedStatement, 3, Int32(serialNumber))
			sqlite3_bind_text(preparedStatement, 1, firstName.utf8String, -1, nil)
			sqlite3_bind_text(preparedStatement, 2, lastName.utf8String, -1, nil)
			
			repeat{
				
			}while(sqlite3_step(preparedStatement) == SQLITE_ROW)
			
			while sqlite3_step(preparedStatement) == SQLITE_ROW{
				let id = sqlite3_column_int(preparedStatement, 0)
				let firstName = sqlite3_column_text(preparedStatement, 1)
				let lastName = sqlite3_column_text(preparedStatement, 2)
				let serialNumber = sqlite3_column_int(preparedStatement, 3)
				print("\(id) - \(String(cString: firstName!)) \(String(cString: lastName!)) - \(serialNumber)")
			}
			
			if sqlite3_step(preparedStatement) != SQLITE_DONE{
				print("didnt insert")
				print("Err: \(String(cString: sqlite3_errmsg(db)))")
			}else{
				print("added")
			}
			sqlite3_finalize(preparedStatement)
		}
	}
	
	func exec(_ query: String, withPreparedStatement args: Any...) -> [Any]{
		var results = [Any]()
		var preparedStatement: OpaquePointer? = nil
		if sqlite3_prepare_v2(db, query, -1, &preparedStatement, nil) == SQLITE_OK{
			
			for (i, arg) in args.enumerated(){
				let index = Int32(i + 1)
				if arg is Int{
					sqlite3_bind_int(preparedStatement, index, arg as? Int32 ?? INT32_MAX)
				}else if arg is String{
					let str = NSString(string: arg as! String)
					sqlite3_bind_text(preparedStatement, index, str.utf8String, -1, nil)
				}
			}
			let status = sqlite3_step(preparedStatement)
			if status == SQLITE_ROW{
				repeat{
					for i in 0 ..< sqlite3_column_count(preparedStatement){
						results.append(sqlite3_column_text(preparedStatement, i))
					}
				}while(sqlite3_step(preparedStatement) == SQLITE_ROW)
				print(results)
			}else if status != SQLITE_DONE{
				fatalError("Err: \(String(cString: sqlite3_errmsg(db)))")
			}
			sqlite3_finalize(preparedStatement)
		}else{
			fatalError("not prepared")
		}
		return results
	}
	
	func exec(_ query: String){
		if sqlite3_exec(db, query, nil, nil, nil) != SQLITE_OK{
			fatalError("Err: \(String(cString: sqlite3_errmsg(db)))")
		}
	}
	
	private func createTable(){
		exec(createTableString)
	}
	
	private func dropTable(){
		exec(dropTableString)
	}
	
	private static func openDatabase() -> OpaquePointer?{
		let fm = FileManager.default
		let documents = fm.urls(for: .documentDirectory, in: .userDomainMask)[0]
		let dbPath = documents.absoluteString + "mydb"
		if fm.fileExists(atPath: dbPath){
			//
		}else{
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
