//
//  Service+CoreDataProperties.swift
//  CarApp
//
//  Created by Miko Stern on 1/1/19.
//  Copyright © 2019 Miko Stern. All rights reserved.
//
//

import Foundation
import CoreData


extension Service {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Service> {
        return NSFetchRequest<Service>(entityName: "Service")
    }

    @NSManaged public var date: NSDate?
    @NSManaged public var miliege: Double
    @NSManaged public var notes: String?
    @NSManaged public var total_cost: Double
    @NSManaged public var car_id: Car?
    @NSManaged public var garage_id: Garage?
    @NSManaged public var service_type_id: ServiceType?

}
