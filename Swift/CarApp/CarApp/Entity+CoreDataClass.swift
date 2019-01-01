//
//  Entity+CoreDataClass.swift
//  CarApp
//
//  Created by Miko Stern on 12/28/18.
//  Copyright © 2018 Miko Stern. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Entity)
public class Entity: NSManagedObject, Encodable {
	private enum CodingKeys: String, CodingKey {
		case id, sync_status, is_deleted, is_uuid, last_modified
	}

	public func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(id, forKey: .id)
		try container.encode(sync_status, forKey: .sync_status)
		try container.encode(is_deleted, forKey: .is_deleted)
		try container.encode(is_uuid, forKey: .is_uuid)
		try container.encode(last_modified?.timeIntervalSince1970, forKey: .last_modified)
	}
}
