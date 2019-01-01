//
//  StationCompany+CoreDataProperties.swift
//  CarApp
//
//  Created by Miko Stern on 1/1/19.
//  Copyright © 2019 Miko Stern. All rights reserved.
//
//

import Foundation
import CoreData


extension StationCompany {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<StationCompany> {
        return NSFetchRequest<StationCompany>(entityName: "StationCompany")
    }

    @NSManaged public var name_en: String?
    @NSManaged public var name_he: String?
    @NSManaged public var image: String?

}
