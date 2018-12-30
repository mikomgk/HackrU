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
public class Entity: NSManagedObject {
	enum SyncStatus: Int32{
		case noChanges, queuedToSync, ignore
	}
	
	public override func willSave() {
		UserDefaults.standard.set(Date().timeIntervalSince1970, forKey: "lastModified")
	}
}
