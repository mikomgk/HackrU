//
//  Station+CoreDataProperties.swift
//  CarApp
//
//  Created by Miko Stern on 1/1/19.
//  Copyright © 2019 Miko Stern. All rights reserved.
//
//

import Foundation
import CoreData


extension Station {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Station> {
        return NSFetchRequest<Station>(entityName: "Station")
    }

    @NSManaged public var station_num: Int32
    @NSManaged public var telephone: String?
    @NSManaged public var name_en: String?
    @NSManaged public var address_en: String?
    @NSManaged public var city_en: String?
    @NSManaged public var name_he: String?
    @NSManaged public var address_he: String?
    @NSManaged public var city_he: String?
    @NSManaged public var x: Double
    @NSManaged public var y: Double
    @NSManaged public var station_company_id: StationCompany?

}
