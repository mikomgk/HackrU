//
//  Garage+CoreDataClass.swift
//  CarApp
//
//  Created by Miko Stern on 12/28/18.
//  Copyright © 2018 Miko Stern. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Garage)
public class Garage: Entity {
	private enum CodingKeys: String, CodingKey {
		case name, x, y
	}
	
	public override func encode(to encoder: Encoder) throws {
		try super.encode(to: encoder)
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(name, forKey: .name)
		try container.encode(x, forKey: .x)
		try container.encode(y, forKey: .y)
	}
}
