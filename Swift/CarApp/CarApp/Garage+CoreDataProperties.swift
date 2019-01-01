//
//  Garage+CoreDataProperties.swift
//  CarApp
//
//  Created by Miko Stern on 1/1/19.
//  Copyright © 2019 Miko Stern. All rights reserved.
//
//

import Foundation
import CoreData


extension Garage {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Garage> {
        return NSFetchRequest<Garage>(entityName: "Garage")
    }

    @NSManaged public var name: String?
    @NSManaged public var x: Double
    @NSManaged public var y: Double

}
