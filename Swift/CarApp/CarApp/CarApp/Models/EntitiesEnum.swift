//
//  EntitiesDal.swift
//  CarApp
//
//  Created by Miko Stern on 12/26/18.
//  Copyright © 2018 Miko Stern. All rights reserved.
//

import Foundation

enum EntityType: String{
	case car, refuel, service, expense, serviceType, garage
	
	static func getEntityTypeByClass<T: Entity>(type: T.Type) -> EntityType{
		switch type{
		case is Car.Type:
			return .car
		case is Refuel.Type:
			return .refuel
		case is Service.Type:
			return .service
		case is Expense.Type:
			return .expense
		case is ServiceType.Type:
			return .serviceType
		case is Garage.Type:
			return .garage
		default:
			fatalError("Wrong class type")
		}
	}
}

enum EntityProperties: String{
	case car_id, car_company, car_model, car_year, car_name, car_date_added, car_starting_miliege, car_next_test, car_next_care_date, car_next_care_miliege
	
	case refuel_id, refuel_date, refuel_total_price, refuel_filled_liter, refuel_miliege, refuel_is_full_tank, refuel_x, refuel_y, refuel_station_id, refuel_car_id
	
	case service_date, service_id, service_miliege, service_notes, service_total_cost, service_car_id, service_garage_id, service_service_type_id
	
	case expense_date, expense_id, expense_notes, expense_total_cost, expense_car_id
	
	case serviceType_id, serviceType_service_type_en, serviceType_service_type_he
	
	case garage_id, garage_name, garage_x, garage_y
	
	var entityType: EntityType{
		switch self{
		case .car_id, .car_company, .car_model, .car_year, .car_name, .car_date_added,
			 .car_starting_miliege, .car_next_test, .car_next_care_date, .car_next_care_miliege:
			return .car
			
		case .refuel_id, .refuel_date, .refuel_total_price, .refuel_filled_liter,
			 .refuel_miliege, .refuel_is_full_tank, .refuel_x, .refuel_y, .refuel_station_id, .refuel_car_id:
			return .refuel
			
		case .service_date, .service_id, .service_miliege, .service_notes,
			 .service_total_cost, .service_car_id, .service_garage_id, .service_service_type_id:
			return .service
			
			
		case .expense_date, .expense_id, .expense_notes, .expense_total_cost, .expense_car_id:
			return .expense
			
		case .serviceType_id, .serviceType_service_type_en, .serviceType_service_type_he:
			return .serviceType
			
		case .garage_id, .garage_name, .garage_x, .garage_y:
			return .garage
		}
	}
}
