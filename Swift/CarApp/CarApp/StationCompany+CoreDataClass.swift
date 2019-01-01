//
//  StationCompany+CoreDataClass.swift
//  CarApp
//
//  Created by Miko Stern on 1/1/19.
//  Copyright © 2019 Miko Stern. All rights reserved.
//
//

import Foundation
import CoreData

@objc(StationCompany)
public class StationCompany: Entity {
	private enum CodingKeys: String, CodingKey {
		case name_en, name_he, image
	}
	
	public override func encode(to encoder: Encoder) throws {
		try super.encode(to: encoder)
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(name_en, forKey: .name_en)
		try container.encode(name_he, forKey: .name_he)
		try container.encode(image, forKey: .image)
	}
}
