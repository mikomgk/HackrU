//
//  ServiceType+CoreDataProperties.swift
//  CarApp
//
//  Created by Miko Stern on 12/30/18.
//  Copyright © 2018 Miko Stern. All rights reserved.
//
//

import Foundation
import CoreData


extension ServiceType {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ServiceType> {
        return NSFetchRequest<ServiceType>(entityName: "ServiceType")
    }

    @NSManaged public var service_type_en: String?
    @NSManaged public var service_type_he: String?

}
