//
//  Refuel+CoreDataProperties.swift
//  CarApp
//
//  Created by Miko Stern on 12/30/18.
//  Copyright © 2018 Miko Stern. All rights reserved.
//
//

import Foundation
import CoreData


extension Refuel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Refuel> {
        return NSFetchRequest<Refuel>(entityName: "Refuel")
    }

    @NSManaged public var date: NSDate?
    @NSManaged public var filled_liter: Double
    @NSManaged public var is_full_tank: Bool
    @NSManaged public var miliege: Double
    @NSManaged public var station_id: Int32
    @NSManaged public var total_price: Double
    @NSManaged public var x: Double
    @NSManaged public var y: Double
    @NSManaged public var car_id: Car?

}
