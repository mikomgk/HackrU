//
//  Expense+CoreDataProperties.swift
//  CarApp
//
//  Created by Miko Stern on 1/1/19.
//  Copyright © 2019 Miko Stern. All rights reserved.
//
//

import Foundation
import CoreData


extension Expense {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Expense> {
        return NSFetchRequest<Expense>(entityName: "Expense")
    }

    @NSManaged public var date: NSDate?
    @NSManaged public var notes: String?
    @NSManaged public var total_cost: Double
    @NSManaged public var car_id: Car?

}
