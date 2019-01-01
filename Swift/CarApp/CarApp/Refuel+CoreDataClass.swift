//
//  Refuel+CoreDataClass.swift
//  CarApp
//
//  Created by Miko Stern on 12/28/18.
//  Copyright © 2018 Miko Stern. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Refuel)
public class Refuel: Entity {
	private enum CodingKeys: String, CodingKey {
		case date, filled_liter, is_full_tank, miliege, station_id, total_price, x, y, car_id
	}

	public override func encode(to encoder: Encoder) throws {
		try super.encode(to: encoder)
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(date?.timeIntervalSince1970, forKey: .date)
		try container.encode(filled_liter, forKey: .filled_liter)
		try container.encode(is_full_tank, forKey: .is_full_tank)
		try container.encode(miliege, forKey: .miliege)
		try container.encode(station_id?.id, forKey: .station_id)
		try container.encode(total_price, forKey: .total_price)
		try container.encode(x, forKey: .x)
		try container.encode(y, forKey: .y)
		try container.encode(car_id?.id, forKey: .car_id)
	}
}
