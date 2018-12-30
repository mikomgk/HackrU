//
//  Car+CoreDataProperties.swift
//  CarApp
//
//  Created by Miko Stern on 12/30/18.
//  Copyright © 2018 Miko Stern. All rights reserved.
//
//

import Foundation
import CoreData


extension Car {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Car> {
        return NSFetchRequest<Car>(entityName: "Car")
    }

    @NSManaged public var company: String?
    @NSManaged public var date_added: NSDate?
    @NSManaged public var model: String?
    @NSManaged public var name: String?
    @NSManaged public var next_care_date: NSDate?
    @NSManaged public var next_care_miliege: Double
    @NSManaged public var next_test: NSDate?
    @NSManaged public var starting_miliege: Double
    @NSManaged public var year: Int32

}
