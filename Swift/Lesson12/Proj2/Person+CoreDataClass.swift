//
//  Person+CoreDataClass.swift
//  Proj2
//
//  Created by Miko Stern on 11/25/18.
//  Copyright © 2018 Miko Stern. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Person)
public class Person: NSManagedObject {
	public override var description: String{
		return "\(firstName!) \(lastName!): \(age)"
	}
	
	convenience init(firstName: String, lastName: String, age: Int16) {
		self.init()
		self.firstName = firstName
		self.lastName = lastName
		self.age = age
	}
}
