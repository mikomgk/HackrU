//
//  ViewController.swift
//  Proj1
//
//  Created by Miko Stern on 12/5/18.
//  Copyright © 2018 Miko Stern. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		addStudent(Student(firstName: "fdsfsd",lastName: "fds",id: 3))
	}
	
	func addStudent(_ student: Student){
		let url = URL(string: "")!
		let json = try? JSONEncoder().encode(student)
		var request = URLRequest(url: url)
		request.httpMethod = "POST"
		request.setValue("application/json", forHTTPHeaderField: "Content-Type")
		request.httpBody = json
		URLSession.shared.dataTask(with: request) { (data, res, err) in
			print(data)
		}
	}

	func getStudents(){
		
	}
}

struct Student: Codable{
	var firstName: String
	var lastName: String
	var id: Int
}
