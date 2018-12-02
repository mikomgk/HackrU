//
//  TaskDao.swift
//  Proj2
//
//  Created by Miko Stern on 11/28/18.
//  Copyright © 2018 Miko Stern. All rights reserved.
//

import UIKit

protocol TaskDao{
	static var shared: TaskDao{get}
	func addTask(_ task: Task) -> String
	func deleteTask(_ task: Task)
	func editTask(_ task: Task, withDescription description: String)
	func toggleTask(_ task: Task)
	func getAllTasks() -> [[Task]]
}
