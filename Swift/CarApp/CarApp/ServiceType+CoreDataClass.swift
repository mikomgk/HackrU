//
//  ServiceType+CoreDataClass.swift
//  CarApp
//
//  Created by Miko Stern on 12/28/18.
//  Copyright © 2018 Miko Stern. All rights reserved.
//
//

import Foundation
import CoreData

@objc(ServiceType)
public class ServiceType: Entity {
	private enum CodingKeys: String, CodingKey {
		case service_type_en, service_type_he
	}
	
	public override func encode(to encoder: Encoder) throws {
		try super.encode(to: encoder)
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(service_type_en, forKey: .service_type_en)
		try container.encode(service_type_he, forKey: .service_type_he)
	}
}
