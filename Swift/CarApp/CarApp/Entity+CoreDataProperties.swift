//
//  Entity+CoreDataProperties.swift
//  CarApp
//
//  Created by Miko Stern on 1/1/19.
//  Copyright © 2019 Miko Stern. All rights reserved.
//
//

import Foundation
import CoreData


extension Entity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Entity> {
        return NSFetchRequest<Entity>(entityName: "Entity")
    }

    @NSManaged public var id: Int32
    @NSManaged public var is_deleted: Bool
    @NSManaged public var is_uuid: Bool
    @NSManaged public var last_modified: NSDate?
    @NSManaged public var sync_status: Int32

}
