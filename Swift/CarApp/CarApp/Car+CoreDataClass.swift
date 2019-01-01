//
//  Car+CoreDataClass.swift
//  CarApp
//
//  Created by Miko Stern on 12/28/18.
//  Copyright © 2018 Miko Stern. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Car)
public class Car: Entity {
	private enum CodingKeys: String, CodingKey {
		case company, date_added, model, name, next_care_date, next_care_miliege, next_test, starting_miliege, year
	}
	
	public override func encode(to encoder: Encoder) throws {
		try super.encode(to: encoder)
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(company, forKey: .company)
		try container.encode(date_added?.timeIntervalSince1970, forKey: .date_added)
		try container.encode(model, forKey: .model)
		try container.encode(name, forKey: .name)
		try container.encode(next_care_date?.timeIntervalSince1970, forKey: .next_care_date)
		try container.encode(next_care_miliege, forKey: .next_care_miliege)
		try container.encode(next_test?.timeIntervalSince1970, forKey: .next_test)
		try container.encode(starting_miliege, forKey: .starting_miliege)
		try container.encode(year, forKey: .year)
	}
}
