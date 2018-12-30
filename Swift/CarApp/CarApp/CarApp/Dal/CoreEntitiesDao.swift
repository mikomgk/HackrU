//
//  CoreDao.swift
//  CarApp
//
//  Created by Miko Stern on 12/26/18.
//  Copyright © 2018 Miko Stern. All rights reserved.
//

import UIKit
import CoreData

class CoreEntitiesDao{
	public static let shared = CoreEntitiesDao()
	lazy var appDelegate: AppDelegate = {
		return UIApplication.shared.delegate as! AppDelegate
	}()
	var context: NSManagedObjectContext{
		return appDelegate.context
	}
	var saveContext: () -> (){
		return appDelegate.saveContext
	}
	
	private init() {}
	
	func getAll(entityType: EntityType) -> [Entity] {
		var collection = [Entity]()
		switch entityType {
		case .car:
			collection = try! context.fetch(Car.fetchRequest())
		case .refuel:
			collection = try! context.fetch(Refuel.fetchRequest())
		case .service:
			collection = try! context.fetch(Service.fetchRequest())
		case .expense:
			collection = try! context.fetch(Expense.fetchRequest())
		case .serviceType:
			collection = try! context.fetch(ServiceType.fetchRequest())
		case .garage:
			collection = try! context.fetch(Garage.fetchRequest())
		}
		return collection
	}
	
	func get(entityId: Int32, of type: EntityType) -> Entity?{
		let collection = getAll(entityType: type)
		for entity in collection{
			if entity.id == entityId{
				return entity
			}
		}
		return nil
	}
	
	func newGarage(name: String?, x: Double, y: Double) -> Garage{
		let description = NSEntityDescription.entity(forEntityName: "Garage", in: context)!
		let garage = Garage(entity: description, insertInto: context)
		garage.id = Int32(UUID().hashValue)
		garage.sync_status = Entity.SyncStatus.queuedToSync.rawValue
		garage.is_deleted = false
		garage.is_uuid = true
		
		garage.name = name
		garage.x = x
		garage.y = y
		saveContext()
		return garage
	}
	
	func newRefuel(car: Car, filledLiter: Double, totalPrice: Double, miliege: Double, isFullTank: Bool, stationId: Int32? = nil, x: Double? = nil, y: Double? = nil) -> Refuel{
		let description = NSEntityDescription.entity(forEntityName: "Refuel", in: context)!
		let refuel = Refuel(entity: description, insertInto: context)
		refuel.id = Int32(UUID().hashValue)
		refuel.sync_status = Entity.SyncStatus.queuedToSync.rawValue
		refuel.is_deleted = false
		refuel.is_uuid = true
		
		refuel.date = NSDate()
		refuel.car_id = car
		refuel.filled_liter = filledLiter
		refuel.total_price = totalPrice
		refuel.miliege = miliege
		refuel.is_full_tank = isFullTank
		refuel.station_id = stationId != nil ? stationId! : 0
		refuel.x = stationId == nil && x != nil ? x! : 0
		refuel.y = stationId == nil && y != nil ? y! : 0
		saveContext()
		return refuel
		
	}
	
	func newService(car: Car, garage: Garage?, total_cost: Double, miliege: Double?, serviceType: ServiceType, notes: String?) -> Service{
		let description = NSEntityDescription.entity(forEntityName: "Service", in: context)!
		let service = Service(entity: description, insertInto: context)
		service.id = Int32(UUID().hashValue)
		service.sync_status = Entity.SyncStatus.queuedToSync.rawValue
		service.is_deleted = false
		service.is_uuid = true
		
		service.date = NSDate()
		service.car_id = car
		service.garage_id = garage
		service.total_cost = total_cost
		service.miliege = miliege != nil ? miliege! : 0
		service.service_type_id = serviceType
		service.notes = notes
		saveContext()
		return service
		
	}
	
	func newExpense(car: Car, total_cost: Double, notes: String?) -> Expense{
		let description = NSEntityDescription.entity(forEntityName: "Expense", in: context)!
		let expense = Expense(entity: description, insertInto: context)
		expense.id = Int32(UUID().hashValue)
		expense.sync_status = Entity.SyncStatus.queuedToSync.rawValue
		expense.is_deleted = false
		expense.is_uuid = true
		
		expense.date = NSDate()
		expense.car_id = car
		expense.total_cost = total_cost
		expense.notes = notes
		saveContext()
		return expense
		
	}
	
	func newCar(name: String, company: String?, model: String?, year: Int32?, startingMiliege: Double?, nextTest: NSDate?, nextCareDate: NSDate?, nextCareMiliege: Double?) -> Car{
		let description = NSEntityDescription.entity(forEntityName: "Car", in: context)!
		let car = Car(entity: description, insertInto: context)
		car.id = Int32(UUID().hashValue)
		car.sync_status = Entity.SyncStatus.queuedToSync.rawValue
		car.is_deleted = false
		car.is_uuid = true
		
		car.date_added = NSDate()
		car.name = name
		car.company = company
		car.model = model
		car.year = year != nil ? year! : 0
		car.starting_miliege = startingMiliege != nil ? startingMiliege! : 0
		car.next_test = nextTest
		car.next_care_date = nextCareDate
		car.next_care_miliege = nextCareMiliege != nil ? nextCareMiliege! : 0
		saveContext()
		return car
	}
	
	func edit(entity: Entity, of type: EntityType, change property: EntityProperties, to newVal: Any?) -> Bool {
		if type == .garage || type == .serviceType { return false }
		if property.entityType != type { return false }
		var result = false
		var car: Car!
		var refuel: Refuel!
		var service: Service!
		var expense: Expense!
		switch (property, type){
		case (_, .car) where entity is Car:
			car = (entity as! Car)
			fallthrough
		case (_, .refuel) where entity is Refuel:
			refuel = (entity as! Refuel)
			fallthrough
		case (_, .service) where entity is Service:
			service = (entity as! Service)
			fallthrough
		case (_, .expense) where entity is Expense:
			expense = (entity as! Expense)
			fallthrough
		case (_, .serviceType), (_, .garage):
			return false
			
		case (.car_company, _) where newVal is String:
			car.company = (newVal as! String)
			result = true
		case (.car_model, _) where newVal is String:
			car.model = (newVal as! String)
			result = true
		case (.car_year, _) where newVal is Int32:
			car.year = newVal as! Int32
			result = true
		case (.car_name, _) where newVal is String:
			car.name = (newVal as! String)
			result = true
		case (.car_date_added, _) where newVal is NSDate:
			car.date_added = (newVal as! NSDate)
			result = true
		case (.car_starting_miliege, _) where newVal is Double:
			car.starting_miliege = newVal as! Double
			result = true
		case (.car_next_test, _) where newVal is NSDate:
			car.next_test = (newVal as! NSDate)
			result = true
		case (.car_next_care_date, _) where newVal is NSDate:
			car.next_care_date = (newVal as! NSDate)
			result = true
		case (.car_next_care_miliege, _) where newVal is Double:
			car.next_care_miliege = newVal as! Double
			result = true
			
		case (.refuel_date, _) where newVal is NSDate:
			refuel.date = (newVal as! NSDate)
			result = true
		case (.refuel_total_price, _) where newVal is Double:
			refuel.total_price = newVal as! Double
			result = true
		case (.refuel_filled_liter, _) where newVal is Double:
			refuel.filled_liter = newVal as! Double
			result = true
		case (.refuel_miliege, _) where newVal is Double:
			refuel.miliege = newVal as! Double
			result = true
		case (.refuel_is_full_tank, _) where newVal is Bool:
			refuel.is_full_tank = newVal as! Bool
			result = true
		case (.refuel_x, _) where newVal is Double:
			refuel.x = newVal as! Double
			result = true
		case (.refuel_y, _) where newVal is Double:
			refuel.y = newVal as! Double
			result = true
		case (.refuel_station_id, _) where newVal is Int32:
			refuel.station_id = newVal as! Int32
			result = true
		case (.refuel_car_id, _) where newVal is Int32 || newVal is Car:
			refuel.car_id = getEntityByEntityOrId(entity: newVal!, type: Car.self)
			result = true
			
		case (.service_date, _) where newVal is NSDate:
			service.date = (newVal as! NSDate)
			result = true
		case (.service_miliege, _) where newVal is Double:
			service.miliege = newVal as! Double
			result = true
		case (.service_notes, _) where newVal is String:
			service.notes = (newVal as! String)
			result = true
		case (.service_total_cost, _) where newVal is Double:
			service.total_cost = newVal as! Double
			result = true
		case (.service_car_id, _) where newVal is Int32 || newVal is Car:
			service.car_id = getEntityByEntityOrId(entity: newVal!, type: Car.self)
			result = true
		case (.service_garage_id, _) where newVal is Int32 || newVal is Garage:
			service.garage_id = getEntityByEntityOrId(entity: newVal!, type: Garage.self)
			result = true
		case (.service_service_type_id, _) where newVal is Int32 || newVal is ServiceType:
			service.service_type_id = getEntityByEntityOrId(entity: newVal!, type: ServiceType.self)
			result = true
			
		case (.expense_date, _) where newVal is NSDate:
			expense.date = (newVal as! NSDate)
			result = true
		case (.expense_notes, _) where newVal is String:
			expense.notes = (newVal as! String)
			result = true
		case (.expense_total_cost, _) where newVal is Double:
			expense.total_cost = newVal as! Double
			result = true
		case (.expense_car_id, _) where newVal is Int32 || newVal is Car:
			expense.car_id = getEntityByEntityOrId(entity: newVal!, type: Car.self)
			result = true
		default:
			break
		}
		if result {
			saveContext()
			entity.sync_status = Entity.SyncStatus.queuedToSync.rawValue
		}
		return result
	}
	
	func edit(entityId: Int32, of type: EntityType, change property: EntityProperties, to newVal: Any?) -> Bool {
		guard let entity = get(entityId: entityId, of: type) else { return false }
		return edit(entity: entity, of: type, change: property, to: newVal)
	}
	
	private func getEntityByEntityOrId<T: Entity>(entity: Any, type: T.Type) -> T{
		if let entity = entity as? Int32{
			return get(entityId: entity, of: EntityType.getEntityTypeByClass(type: type)) as! T
		}else{
			return entity as! T
		}
	}
	
	func delete(entity: Entity) -> Bool {
		if entity.is_deleted{
			context.delete(entity)
			saveContext()
		}else{
			entity.is_deleted = true
			entity.sync_status = Entity.SyncStatus.queuedToSync.rawValue
		}
		return true
	}
	
	func delete(entityId: Int32, of type: EntityType) -> Bool {
		guard let entity = get(entityId: entityId, of: type) else { return false }
		return delete(entity: entity)
	}
}
