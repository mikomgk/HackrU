//
//  Service+CoreDataClass.swift
//  CarApp
//
//  Created by Miko Stern on 12/28/18.
//  Copyright © 2018 Miko Stern. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Service)
public class Service: Entity {
	private enum CodingKeys: String, CodingKey {
		case date, miliege, notes, total_cost, car_id, garage_id, service_type_id
	}
	
	public override func encode(to encoder: Encoder) throws {
		try super.encode(to: encoder)
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(date?.timeIntervalSince1970, forKey: .date)
		try container.encode(miliege, forKey: .miliege)
		try container.encode(notes, forKey: .notes)
		try container.encode(total_cost, forKey: .total_cost)
		try container.encode(car_id?.id, forKey: .car_id)
		try container.encode(garage_id?.id, forKey: .garage_id)
		try container.encode(service_type_id?.id, forKey: .service_type_id)
	}
}
