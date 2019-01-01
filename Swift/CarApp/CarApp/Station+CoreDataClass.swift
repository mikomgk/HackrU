//
//  Station+CoreDataClass.swift
//  CarApp
//
//  Created by Miko Stern on 1/1/19.
//  Copyright © 2019 Miko Stern. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Station)
public class Station: Entity {
	private enum CodingKeys: String, CodingKey {
		case station_num, telephone, name_en, address_en, city_en, name_he, address_he, city_he, x, y, station_company_id
	}
	
	public override func encode(to encoder: Encoder) throws {
		try super.encode(to: encoder)
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(station_num, forKey: .station_num)
		try container.encode(telephone, forKey: .telephone)
		try container.encode(name_en, forKey: .name_en)
		try container.encode(address_en, forKey: .address_en)
		try container.encode(city_en, forKey: .city_en)
		try container.encode(name_he, forKey: .name_he)
		try container.encode(address_he, forKey: .address_he)
		try container.encode(city_he, forKey: .city_he)
		try container.encode(x, forKey: .x)
		try container.encode(y, forKey: .y)
		try container.encode(station_company_id?.id, forKey: .station_company_id)
	}
}
