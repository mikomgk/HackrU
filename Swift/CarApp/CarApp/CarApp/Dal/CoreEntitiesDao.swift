//
//  CoreDao.swift
//  CarApp
//
//  Created by Miko Stern on 12/26/18.
//  Copyright © 2018 Miko Stern. All rights reserved.
//

import UIKit
import CoreData
import Contacts

class CoreEntitiesDao{
	public static let shared = CoreEntitiesDao()
	private lazy var appDelegate: AppDelegate = {
		return UIApplication.shared.delegate as! AppDelegate
	}()
	private var context: NSManagedObjectContext{
		return appDelegate.context
	}
	private var saveContext: () -> (){
		return appDelegate.saveContext
	}
	
	private init() {}
	
//	func getAll(entityType: EntityType) -> [Entity] {
//		var collection = [Entity]()
//		switch entityType {
//		case .car:
//			collection = try! context.fetch(Car.fetchRequest())
//		case .refuel:
//			collection = try! context.fetch(Refuel.fetchRequest())
//		case .service:
//			collection = try! context.fetch(Service.fetchRequest())
//		case .expense:
//			collection = try! context.fetch(Expense.fetchRequest())
//		case .serviceType:
//			collection = try! context.fetch(ServiceType.fetchRequest())
//		case .garage:
//			collection = try! context.fetch(Garage.fetchRequest())
//		}
//		return collection
//	}
	
	func getAll<T: Entity>(entityType: T.Type) -> [T]{
		switch entityType {
		case is Car.Type:
			return try! context.fetch(Car.fetchRequest()) as! [T]
		case is Refuel.Type:
			return try! context.fetch(Refuel.fetchRequest()) as! [T]
		case is Service.Type:
			return try! context.fetch(Service.fetchRequest()) as! [T]
		case is Expense.Type:
			return try! context.fetch(Expense.fetchRequest()) as! [T]
		case is ServiceType.Type:
			return try! context.fetch(ServiceType.fetchRequest()) as! [T]
		case is Garage.Type:
			return try! context.fetch(Garage.fetchRequest()) as! [T]
		case is Station.Type:
			return try! context.fetch(Station.fetchRequest()) as! [T]
		case is StationCompany.Type:
			return try! context.fetch(StationCompany.fetchRequest()) as! [T]
		default:
			fatalError("Wrong class type")
		}
	}
	
	func getUnsynced<T: Entity>(entityType: T.Type) -> [T]{
		var collection = getAll(entityType: entityType)
		collection.removeAll { $0.sync_status != ServerEntitiesDao.SyncStatus.queuedToSync.rawValue }
		return collection
	}
	
	func get<T: Entity>(entityId: Int32, of type: T.Type) -> T?{
		let collection = getAll(entityType: type)
		return collection.first { $0.id == entityId }
	}
	
//	func getUnsynced(entityType: EntityType) -> [Entity]{
//		var collection = getAll(entityType: entityType)
//		collection.removeAll { $0.sync_status != ServerEntitiesDao.SyncStatus.queuedToSync.rawValue }
//		return collection
//	}
//
//	func get(entityId: Int32, of type: EntityType) -> Entity?{
//		let collection = getAll(entityType: type)
//		guard let entity = (collection.first { $0.id == entityId }) else { return nil }
//		return entity
//	}
	
	func newGarage(name: String?, x: Double, y: Double) -> Garage{
		let description = NSEntityDescription.entity(forEntityName: "Garage", in: context)!
		let garage = Garage(entity: description, insertInto: context)
		garage.id = Int32(UUID().hashValue)
		garage.sync_status = ServerEntitiesDao.SyncStatus.queuedToSync.rawValue
		garage.is_deleted = false
		garage.is_uuid = true
		garage.last_modified = NSDate()
		
		garage.name = name
		garage.x = x
		garage.y = y
		saveContext()
		return garage
	}
	
	func newRefuel(car: Car, filledLiter: Double, totalPrice: Double, miliege: Double, isFullTank: Bool, station: Station? = nil, x: Double? = nil, y: Double? = nil, date: NSDate = NSDate()) -> Refuel{
		let description = NSEntityDescription.entity(forEntityName: "Refuel", in: context)!
		let refuel = Refuel(entity: description, insertInto: context)
		refuel.id = Int32(UUID().hashValue)
		refuel.sync_status = ServerEntitiesDao.SyncStatus.queuedToSync.rawValue
		refuel.is_deleted = false
		refuel.is_uuid = true
		refuel.last_modified = date
		
		refuel.date = date
		refuel.car_id = car
		refuel.filled_liter = filledLiter
		refuel.total_price = totalPrice
		refuel.miliege = miliege
		refuel.is_full_tank = isFullTank
		refuel.station_id = station //TODO: add new station if needed
		refuel.x = station == nil && x != nil ? x! : 0
		refuel.y = station == nil && y != nil ? y! : 0
		saveContext()
		return refuel
	}
	
	func newService(car: Car, garage: Garage?, total_cost: Double, miliege: Double?, serviceType: ServiceType, notes: String?, date: NSDate = NSDate()) -> Service{
		let description = NSEntityDescription.entity(forEntityName: "Service", in: context)!
		let service = Service(entity: description, insertInto: context)
		service.id = Int32(UUID().hashValue)
		service.sync_status = ServerEntitiesDao.SyncStatus.queuedToSync.rawValue
		service.is_deleted = false
		service.is_uuid = true
		service.last_modified = date
		
		service.date = date
		service.car_id = car
		service.garage_id = garage
		service.total_cost = total_cost
		service.miliege = miliege != nil ? miliege! : 0
		service.service_type_id = serviceType
		service.notes = notes
		saveContext()
		return service
	}

	func newExpense(car: Car, total_cost: Double, notes: String?, date: NSDate = NSDate()) -> Expense{
		let description = NSEntityDescription.entity(forEntityName: "Expense", in: context)!
		let expense = Expense(entity: description, insertInto: context)
		expense.id = Int32(UUID().hashValue)
		expense.sync_status = ServerEntitiesDao.SyncStatus.queuedToSync.rawValue
		expense.is_deleted = false
		expense.is_uuid = true
		expense.last_modified = NSDate()
		
		expense.date = date
		expense.car_id = car
		expense.total_cost = total_cost
		expense.notes = notes
		saveContext()
		return expense
	}
	
	func newServiceType(serviceTypeEn: String, serviceTypeHe: String) -> ServiceType{
		let description = NSEntityDescription.entity(forEntityName: "ServiceType", in: context)!
		let serviceType = ServiceType(entity: description, insertInto: context)
		serviceType.id = Int32(UUID().hashValue)
		serviceType.sync_status = ServerEntitiesDao.SyncStatus.queuedToSync.rawValue
		serviceType.is_deleted = false
		serviceType.is_uuid = true
		serviceType.last_modified = NSDate()
		
		serviceType.service_type_en = serviceTypeEn
		serviceType.service_type_he = serviceTypeHe
		saveContext()
		return serviceType
	}
	
	func newCar(name: String, company: String?, model: String?, year: Int32?, startingMiliege: Double?, nextTest: NSDate?, nextCareDate: NSDate?, nextCareMiliege: Double?, dateAdded: NSDate = NSDate()) -> Car{
		let description = NSEntityDescription.entity(forEntityName: "Car", in: context)!
		let car = Car(entity: description, insertInto: context)
		car.id = Int32(UUID().hashValue)
		car.sync_status = ServerEntitiesDao.SyncStatus.queuedToSync.rawValue
		car.is_deleted = false
		car.is_uuid = true
		car.last_modified = dateAdded
		
		car.date_added = dateAdded
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
	
	func newStation(stationCompany: StationCompany, stationNum: Int32, telephone: String, nameEn: String, addressEn: String, cityEn: String, nameHe: String, addressHe: String, cityHe: String, x: Double, y: Double) -> Station{
		let description = NSEntityDescription.entity(forEntityName: "Station", in: context)!
		let station = Station(entity: description, insertInto: context)
		station.id = Int32(UUID().hashValue)
		station.sync_status = ServerEntitiesDao.SyncStatus.queuedToSync.rawValue
		station.is_deleted = false
		station.is_uuid = true
		station.last_modified = NSDate()
		
		station.station_company_id = stationCompany
		station.station_num = stationNum
		station.telephone = telephone
		station.name_en = nameEn
		station.address_en = addressEn
		station.city_en = cityEn
		station.name_he = nameHe
		station.address_he = addressHe
		station.city_he = cityHe
		station.x = x
		station.y = y
		saveContext()
		return station
	}
	
	func newStationCompany(nameEn: String, nameHe: String, image: String) -> StationCompany{
		let description = NSEntityDescription.entity(forEntityName: "StationCompany", in: context)!
		let stationCompany = StationCompany(entity: description, insertInto: context)
		stationCompany.id = Int32(UUID().hashValue)
		stationCompany.sync_status = ServerEntitiesDao.SyncStatus.queuedToSync.rawValue
		stationCompany.is_deleted = false
		stationCompany.is_uuid = true
		stationCompany.last_modified = NSDate()
		
		stationCompany.name_en = nameEn
		stationCompany.name_he = nameHe
		stationCompany.image = image
		saveContext()
		return stationCompany
	}
	
	func saveUpdates<T: Entity>(for entity: T, syncStatus: ServerEntitiesDao.SyncStatus = .queuedToSync, lastModified: NSDate = NSDate()){
		entity.sync_status = syncStatus.rawValue
		entity.last_modified = lastModified
		saveContext()
	}
	
	func delete(entity: Entity){
		if entity.is_deleted{
			context.delete(entity)
		}else{
			entity.is_deleted = true
			entity.sync_status = ServerEntitiesDao.SyncStatus.queuedToSync.rawValue
			entity.last_modified = NSDate()
		}
		saveContext()
	}
	
	func delete(entityId: Int32, of type: Entity.Type){
		guard let entity = get(entityId: entityId, of: type) else { return }
		delete(entity: entity)
	}
}
	
	/*
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
	
	private func getEntityByEntityOrId<T: Entity>(entity: Any, type: T.Type) -> T?{
		if let entity = entity as? Int32{
			return get(entityId: entity, of: type)
		}else{
			return entity as? T
		}
	}
	*/
