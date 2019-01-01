//
//  ServerEntitiesDao.swift
//  CarApp
//
//  Created by Miko Stern on 12/26/18.
//  Copyright © 2018 Miko Stern. All rights reserved.
//

import UIKit
import CoreData

class ServerEntitiesDao{
	public static let shared = ServerEntitiesDao()
	let coreEntitiesDao = CoreEntitiesDao.shared
	let baseEntityUrl = "https://carlogapp.herokuapp.com/entity"
	var userDefaults: UserDefaults{
		return UserDefaults.standard
	}
	lazy var appDelegate: AppDelegate = {
		return UIApplication.shared.delegate as! AppDelegate
	}()
	
	private init() {}
	
	func sync(){
		let unsyncedCars = coreEntitiesDao.getUnsynced(entityType: Car.self)
		let unsyncedRefuels = coreEntitiesDao.getUnsynced(entityType: Refuel.self)
		let unsyncedServices = coreEntitiesDao.getUnsynced(entityType: Service.self)
		let unsyncedGarages = coreEntitiesDao.getUnsynced(entityType: Garage.self)
		let unsyncedExpenses = coreEntitiesDao.getUnsynced(entityType: Expense.self)
		var unsyncEntitiesCollection: [[Entity]] = [unsyncedCars, unsyncedRefuels, unsyncedServices, unsyncedGarages, unsyncedExpenses]
		
		let unsyncedCarsJSON = try! JSONEncoder().encode(unsyncedCars)
		let unsyncedRefuelsJSON = try! JSONEncoder().encode(unsyncedRefuels)
		let unsyncedServicesJSON = try! JSONEncoder().encode(unsyncedServices)
		let unsyncedGaragesJSON = try! JSONEncoder().encode(unsyncedGarages)
		let unsyncedExpensesJSON = try! JSONEncoder().encode(unsyncedExpenses)
		let changedEntities = [unsyncedCarsJSON, unsyncedRefuelsJSON, unsyncedServicesJSON, unsyncedGaragesJSON, unsyncedExpensesJSON]
		let changedEntitiesJSON = try! JSONEncoder().encode(changedEntities)
		
		var url = URLComponents(string: baseEntityUrl)!
		let userIsParameter = URLQueryItem(name: "userId", value: userDefaults.integer(forKey: "userId").description)
		let lastSyncParameter = URLQueryItem(name: "lastSync", value: userDefaults.double(forKey: "lastSync").description)
		url.queryItems = [userIsParameter, lastSyncParameter]
		print(url.string!)
		var request = URLRequest(url: url.url!)
		request.httpMethod = "POST"
		request.setValue("application/json", forHTTPHeaderField: "Content-Type")
		request.httpBody = changedEntitiesJSON
		print("changedEntitiesJSON is going to be send")
		URLSession.shared.dataTask(with: request) { (data, res, err) in
			if let err = err { print(err) }//TODO: handle errors
			guard let data = data else { return print("no data") }
			guard let resData = try? JSONSerialization.jsonObject(with: data, options: []) as? JSONObject else { return print("data error") }
			guard var unsyncedEntities = resData?["err"] as? [[Int]] else { return print("data error") }
			guard var newIds = resData?["newIds"] as? [Int32] else { return print("data error")}
			for (i, collectionIndexes) in unsyncedEntities.enumerated(){
				for index in collectionIndexes{
					unsyncEntitiesCollection[i].remove(at: index)
				}
			}
			for (i, collection) in unsyncEntitiesCollection.enumerated(){
				for (j, entity) in collection.enumerated(){
					if j == unsyncedEntities[i].first{
						unsyncedEntities[i].removeFirst()
						continue
					}
					entity.sync_status = SyncStatus.noChanges.rawValue
					if entity.is_deleted { self.coreEntitiesDao.delete(entity: entity) }
					if entity.is_uuid {
						entity.id = newIds.removeFirst()
						entity.is_uuid = false
					}
				}
			}
			let entitiesNamesFunnctions = [
				("Car", self.modifyCar),
				("Expense", self.modifyExpense),
				("Refuel", self.modifyRefueling),
				("Garage", self.modifyGarage),
				("ServiceType", self.modifyServiceType),
				("Service", self.modifyService),
				("StationCompany", self.modifyStationCompany),
				("Station", self.modifyStation)
			]
			for (name, modifyFunc) in entitiesNamesFunnctions{
				guard let modifiedCollection = resData?["modified\(name)"] as? JSONArray else { return print("data error") }
				modifiedCollection.forEach({ modifyFunc($0) })
			}
		}.resume()
	}
	
	func modifyRefueling(_ refulJSON: JSONObject){
		let id = refulJSON["id"] as! Int32
		let refuel = coreEntitiesDao.get(entityId: id, of: Refuel.self)
		if refulJSON["is_deleted"] as! Bool{
			refuel!.is_deleted = true
			return coreEntitiesDao.delete(entity: refuel!)
		}
		let last_modified = NSDate(timeIntervalSince1970: refulJSON["last_midified"] as! Double)
		
		let carId = refulJSON["car_id"] as! Int32
		let date = NSDate(timeIntervalSince1970: refulJSON["date"] as! Double)
		let totalPrice = refulJSON["total_price"] as! Double
		let filledLiter = refulJSON["filled_liter"] as! Double
		let miliege = refulJSON["miliege"] as! Double
		let isFullTank = refulJSON["is_full_tank"] as! Bool
		let stationId = refulJSON["station_id"] as! Int32
		let x = refulJSON["x"] as! Double
		let y = refulJSON["y"] as! Double
		let car = coreEntitiesDao.get(entityId: carId, of: Car.self)!
		let station = coreEntitiesDao.get(entityId: stationId, of: Station.self)!
		
		if let refuel = refuel{
			refuel.car_id = car
			refuel.date = date
			refuel.total_price = totalPrice
			refuel.filled_liter = filledLiter
			refuel.miliege = miliege
			refuel.is_full_tank = isFullTank
			refuel.station_id = station
			refuel.x = x
			refuel.y = y
			coreEntitiesDao.saveUpdates(for: refuel, syncStatus: .noChanges, lastModified: last_modified)
		}else{
			let newRefuel = coreEntitiesDao.newRefuel(car: car, filledLiter: filledLiter, totalPrice: totalPrice, miliege: miliege, isFullTank: isFullTank, station: station, x: x, y: y, date: date)
			newRefuel.id = id
			newRefuel.is_uuid = false
			coreEntitiesDao.saveUpdates(for: newRefuel, syncStatus: .noChanges, lastModified: last_modified)
		}
	}
	
	func modifyService(_ serviceJSON: JSONObject){
		let id = serviceJSON["id"] as! Int32
		let service = coreEntitiesDao.get(entityId: id, of: Service.self)
		if serviceJSON["is_deleted"] as! Bool{
			service!.is_deleted = true
			return coreEntitiesDao.delete(entity: service!)
		}
		let last_modified = NSDate(timeIntervalSince1970: serviceJSON["last_midified"] as! Double)
		
		let carId = serviceJSON["car_id"] as! Int32
		let serviceTypeId = serviceJSON["service_type_id"] as! Int32
		let date = NSDate(timeIntervalSince1970: serviceJSON["date"] as! Double)
		let miliege = serviceJSON["miliege"] as! Double
		let garageId = serviceJSON["garage_id"] as! Int32
		let notes = serviceJSON["notes"] as! String
		let totalCost = serviceJSON["total_cost"] as! Double
		let car = coreEntitiesDao.get(entityId: carId, of: Car.self)!
		let serviceType = coreEntitiesDao.get(entityId: serviceTypeId, of: ServiceType.self)!
		let garage = coreEntitiesDao.get(entityId: garageId, of: Garage.self)!
		
		if let service = service{
			service.car_id = car
			service.service_type_id = serviceType
			service.date = date
			service.miliege = miliege
			service.garage_id = garage
			service.notes = notes
			service.total_cost = totalCost
			coreEntitiesDao.saveUpdates(for: service, syncStatus: .noChanges, lastModified: last_modified)
		}else{
			let newService = coreEntitiesDao.newService(car: car, garage: garage, total_cost: totalCost, miliege: miliege, serviceType: serviceType, notes: notes, date: date)
			newService.id = id
			newService.is_uuid = false
			coreEntitiesDao.saveUpdates(for: newService, syncStatus: .noChanges, lastModified: last_modified)
		}
	}
	
	func modifyCar(_ carJSON: JSONObject){
		let id = carJSON["id"] as! Int32
		let car = coreEntitiesDao.get(entityId: id, of: Car.self)
		if carJSON["is_deleted"] as! Bool{
			car!.is_deleted = true
			return coreEntitiesDao.delete(entity: car!)
		}
		let last_modified = NSDate(timeIntervalSince1970: carJSON["last_midified"] as! Double)
		
		let company = carJSON["company"] as! String
		let model = carJSON["model"] as! String
		let year = carJSON["year"] as! Int32
		let name = carJSON["name"] as! String
		let dateAdded = NSDate(timeIntervalSince1970: carJSON["date_added"] as! Double)
		let startingMiliege = carJSON["starting_miliege"] as! Double
		let nextTest = NSDate(timeIntervalSince1970: carJSON["next_test"] as! Double)
		let nextCareDate = NSDate(timeIntervalSince1970: carJSON["next_care_date"] as! Double)
		let nextCareMiliege = carJSON["next_care_miliege"] as! Double
		
		if let car = car{
			car.company = company
			car.model = model
			car.year = year
			car.name = name
			car.date_added = dateAdded
			car.starting_miliege = startingMiliege
			car.next_test = nextTest
			car.next_care_date = nextCareDate
			car.next_care_miliege = nextCareMiliege
			coreEntitiesDao.saveUpdates(for: car, syncStatus: .noChanges, lastModified: last_modified)
		}else{
			let newCar = coreEntitiesDao.newCar(name: name, company: company, model: model, year: year, startingMiliege: startingMiliege, nextTest: nextTest, nextCareDate: nextCareDate, nextCareMiliege: nextCareMiliege, dateAdded: dateAdded)
			newCar.id = id
			newCar.is_uuid = false
			coreEntitiesDao.saveUpdates(for: newCar, syncStatus: .noChanges, lastModified: last_modified)
		}
	}
	
	func modifyGarage(_ garageJSON: JSONObject){
		let id = garageJSON["id"] as! Int32
		let garage = coreEntitiesDao.get(entityId: id, of: Garage.self)
		if garageJSON["is_deleted"] as! Bool{
			garage!.is_deleted = true
			return coreEntitiesDao.delete(entity: garage!)
		}
		let last_modified = NSDate(timeIntervalSince1970: garageJSON["last_midified"] as! Double)
		
		let name = garageJSON["name"] as! String
		let x = garageJSON["x"] as! Double
		let y = garageJSON["y"] as! Double
		
		if let garage = garage{
			garage.name = name
			garage.x = x
			garage.y = y
			coreEntitiesDao.saveUpdates(for: garage, syncStatus: .noChanges, lastModified: last_modified)
		}else{
			let newGarage = coreEntitiesDao.newGarage(name: name, x: x, y: y)
			newGarage.id = id
			newGarage.is_uuid = false
			coreEntitiesDao.saveUpdates(for: newGarage, syncStatus: .noChanges, lastModified: last_modified)
		}
	}
	
	func modifyExpense(_ expenseJSON: JSONObject){
		let id = expenseJSON["id"] as! Int32
		let expense = coreEntitiesDao.get(entityId: id, of: Expense.self)
		if expenseJSON["is_deleted"] as! Bool{
			expense!.is_deleted = true
			return coreEntitiesDao.delete(entity: expense!)
		}
		let last_modified = NSDate(timeIntervalSince1970: expenseJSON["last_midified"] as! Double)
		
		let car_id = expenseJSON["car_id"] as! Int32
		let date = NSDate(timeIntervalSince1970: expenseJSON["date"] as! Double)
		let totalCost = expenseJSON["total_cost"] as! Double
		let notes = expenseJSON["notes"] as! String
		let car = coreEntitiesDao.get(entityId: car_id, of: Car.self)!
		
		if let expense = expense{
			expense.date = date
			expense.total_cost = totalCost
			expense.notes = notes
			expense.car_id = car
			coreEntitiesDao.saveUpdates(for: expense, syncStatus: .noChanges, lastModified: last_modified)
		}else{
			let newExpense = coreEntitiesDao.newExpense(car: car, total_cost: totalCost, notes: notes, date: date)
			newExpense.id = id
			newExpense.is_uuid = false
			coreEntitiesDao.saveUpdates(for: newExpense, syncStatus: .noChanges, lastModified: last_modified)
		}
	}
	
	func modifyServiceType(_ serviceTypeJSON: JSONObject){
		let id = serviceTypeJSON["id"] as! Int32
		let serviceType = coreEntitiesDao.get(entityId: id, of: ServiceType.self)
		if serviceTypeJSON["is_deleted"] as! Bool{
			serviceType!.is_deleted = true
			return coreEntitiesDao.delete(entity: serviceType!)
		}
		let last_modified = NSDate(timeIntervalSince1970: serviceTypeJSON["last_midified"] as! Double)
		
		let serviceTypeEn = serviceTypeJSON["service_type_en"] as! String
		let serviceTypeHe = serviceTypeJSON["service_type_he"] as! String
		
		if let serviceType = serviceType{
			serviceType.service_type_en = serviceTypeEn
			serviceType.service_type_he = serviceTypeHe
			coreEntitiesDao.saveUpdates(for: serviceType, syncStatus: .noChanges, lastModified: last_modified)
		}else{
			let newServiceType = coreEntitiesDao.newServiceType(serviceTypeEn: serviceTypeEn, serviceTypeHe: serviceTypeHe)
			newServiceType.id = id
			newServiceType.is_uuid = false
			coreEntitiesDao.saveUpdates(for: newServiceType, syncStatus: .noChanges, lastModified: last_modified)
		}
	}
	
	func modifyStation(_ stationJSON: JSONObject){
		let id = stationJSON["id"] as! Int32
		let station = coreEntitiesDao.get(entityId: id, of: Station.self)
		if stationJSON["is_deleted"] as! Bool{
			station!.is_deleted = true
			return coreEntitiesDao.delete(entity: station!)
		}
		let last_modified = NSDate(timeIntervalSince1970: stationJSON["last_midified"] as! Double)
		
		let stationCompanyId = stationJSON["station_company_id"] as! Int32
		let stationNum = stationJSON["station_num"] as! Int32
		let telephone = stationJSON["telephone"] as! String
		let nameEn = stationJSON["name_en"] as! String
		let addressEn = stationJSON["address_en"] as! String
		let cityEn = stationJSON["city_en"] as! String
		let nameHe = stationJSON["name_he"] as! String
		let addressHe = stationJSON["address_he"] as! String
		let cityHe = stationJSON["city_he"] as! String
		let x = stationJSON["x"] as! Double
		let y = stationJSON["y"] as! Double
		let stationCompany = coreEntitiesDao.get(entityId: stationCompanyId, of: StationCompany.self)!
		
		if let station = station{
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
			coreEntitiesDao.saveUpdates(for: station, syncStatus: .noChanges, lastModified: last_modified)
		}else{
			let newStation = coreEntitiesDao.newStation(stationCompany: stationCompany, stationNum: stationNum, telephone: telephone, nameEn: nameEn, addressEn: addressEn, cityEn: cityEn, nameHe: nameHe, addressHe: addressHe, cityHe: cityHe, x: x, y: y)
			newStation.id = id
			newStation.is_uuid = false
			coreEntitiesDao.saveUpdates(for: newStation, syncStatus: .noChanges, lastModified: last_modified)
		}
	}
	
	func modifyStationCompany(_ stationCompanyJSON: JSONObject){
		let id = stationCompanyJSON["id"] as! Int32
		let stationCompany = coreEntitiesDao.get(entityId: id, of: StationCompany.self)
		if stationCompanyJSON["is_deleted"] as! Bool{
			stationCompany!.is_deleted = true
			return coreEntitiesDao.delete(entity: stationCompany!)
		}
		let last_modified = NSDate(timeIntervalSince1970: stationCompanyJSON["last_midified"] as! Double)
		
		let nameEn = stationCompanyJSON["name_en"] as! String
		let nameHe = stationCompanyJSON["name_he"] as! String
		let image = stationCompanyJSON["image"] as! String
		
		if let stationCompany = stationCompany{
			stationCompany.name_en = nameEn
			stationCompany.name_he = nameHe
			stationCompany.image = image
			coreEntitiesDao.saveUpdates(for: stationCompany, syncStatus: .noChanges, lastModified: last_modified)
		}else{
			let newStationCompany = coreEntitiesDao.newStationCompany(nameEn: nameEn, nameHe: nameHe, image: image)
			newStationCompany.id = id
			newStationCompany.is_uuid = false
			coreEntitiesDao.saveUpdates(for: newStationCompany, syncStatus: .noChanges, lastModified: last_modified)
		}
	}
}

extension ServerEntitiesDao{
	enum SyncStatus: Int32{
		case noChanges, queuedToSync, ignore
	}
}

typealias JSONObject = [String: Any]
typealias JSONArray = [JSONObject]

	
//	func getAll(entityType: EntityType, callback: @escaping (JSONArray?, Error?) -> ()){
//		let params = [
//			"mode":"get",
//			"type":entityType.rawValue
//		]
//		let url = generateURL(with: params)
//		URLSession.shared.dataTask(with: url) { (data, res, err) in
//			guard let data = data else { return callback(nil, err) }
//			guard let dataJSON = try? JSONSerialization.jsonObject(with: data, options: []) as? JSONArray else{ return callback(nil, err)}
//			callback(dataJSON, err)
//		}
//	}
//
//	func get(entityId: Int, of type: EntityType, callback: @escaping (JSONObject?, Error?) -> ()){
//		let params = [
//			"mode":"get",
//			"type":type.rawValue,
//			"id":entityId.description
//		]
//		let url = generateURL(with: params)
//		URLSession.shared.dataTask(with: url) { (data, res, err) in
//			guard let data = data else { return callback(nil, err) }
//			guard let dataJSON = try? JSONSerialization.jsonObject(with: data, options: []) as? JSONArray else{ return callback(nil, err)}
//			callback(dataJSON?[0], err)
//		}
//	}
//
//	func new(entity: Entity, of type: EntityType, callback: @escaping (Int32?, Error?) -> ()){
//		var params = [
//			"mode":"new",
//			"type":type.rawValue
//		]
//		switch type {
//		case .car:
//			guard let car = entity as? Car else { break }
//			let p = [
//				"company":car.company!,
//				"dateAdded":car.date_added!.description,
//				"model":car.model ?? "",
//				"name":car.name ?? "",
//				"nextCareDate":car.next_care_date?.description ?? "",
//				"nextCareMiliege":car.next_care_miliege.description,
//				"nextTest":car.next_test?.description ?? "",
//				"startingMiliege":car.starting_miliege.description,
//				"year":car.year.description
//			]
//			params.merge(p) { (_, new) -> String in new}
//		case .refuel:
//			guard let refuel = entity as? Refuel else { break }
//			let p = [
//				"date":refuel.date?.description ?? "",
//				"filledLiter":refuel.filled_liter.description,
//				"isFullTank":refuel.is_full_tank.description,
//				"miliege":refuel.miliege.description,
//				"stationId":refuel.station_id.description,
//				"totalPrice":refuel.total_price.description,
//				"x":refuel.x.description,
//				"y":refuel.y.description,
//				"carId":refuel.car_id?.id.description ?? ""
//			]
//			params.merge(p) { (_, new) -> String in new}
//		case .service:
//			guard let service = entity as? Service else { break }
//			let p = [
//				"date":service.date?.description ?? "",
//				"miliege":service.miliege.description,
//				"notes":service.notes ?? "",
//				"totalCost":service.total_cost.description,
//				"carId":service.car_id?.id.description ?? "",
//				"garageId":service.garage_id?.id.description ?? "",
//				"serviceTypeId":service.service_type_id?.description ?? "3"
//			]
//			params.merge(p) { (_, new) -> String in new}
//		case .expense:
//			guard let expense = entity as? Expense else { break }
//			let p = [
//				"date":expense.date?.description ?? "",
//				"notes":expense.notes ?? "",
//				"totalCost":expense.total_cost.description,
//				"carId":expense.car_id?.id.description ?? ""
//			]
//			params.merge(p) { (_, new) -> String in new}
//		case .serviceType://TODO: handle error
//			return callback(nil, nil)
//		case .garage:
//			guard let garage = entity as? Garage else { break }
//			let p = [
//				"name":garage.name ?? "",
//				"x":garage.x.description,
//				"y":garage.y.description
//			]
//			params.merge(p) { (_, new) -> String in new}
//		}
//		let url = generateURL(with: params)
//		URLSession.shared.dataTask(with: url) { (data, res, err) in
//			guard let data = data else { return callback(nil, err) }
//			guard let dataJSON = try? JSONSerialization.jsonObject(with: data, options: []) as? JSONObject else { return callback(nil, err) }
//			guard let id = dataJSON?["id"] as? Int32 else { return callback(nil, err) }
//			callback(id, err)
//		}
//	}
//
//	func edit(entity: Entity, of type: EntityType, change property: EntityProperties, to newVal: String, callback: @escaping (Bool, Error?) -> ()){
//		edit(entityId: entity.id, of: type, change: property, to: newVal, callback: callback)
//	}
//
//	func edit(entityId: Int32, of type: EntityType, change property: EntityProperties, to newVal: String, callback: @escaping (Bool, Error?) -> ()){
//		if type == .garage || type == .serviceType { return callback(false, nil) }//TODO: handle error
//		let p = property.rawValue
//		let params = [
//			"mode":"edit",
//			"type":type.rawValue,
//			"id":entityId.description,
//			p.suffix(from: p.index(after: (p.firstIndex(of: "_")!))).description:newVal
//		]
//		let url = generateURL(with: params)
//		URLSession.shared.dataTask(with: url) { (data, res, err) in
//			guard let data = data else { return callback(false, err) }
//			guard let dataJSON = try? JSONSerialization.jsonObject(with: data, options: []) as? JSONObject else { return callback(false, err) }
//			guard let result = dataJSON?["result"] as? Bool else { return callback(false, err) }
//			callback(result, err)
//		}
//	}
//
//	func delete(entity: Entity, of type: EntityType, callback: @escaping (Bool, Error?) -> ()){
//		delete(entityId: entity.id, of: type, callback: callback)
//	}
//
//	func delete(entityId: Int32, of type: EntityType, callback: @escaping (Bool, Error?) -> ()){
//		if type == .garage || type == .serviceType { return callback(false, nil) }//TODO: handle error
//		let params = [
//			"mode":"delete",
//			"type":type.rawValue,
//			"id":entityId.description,
//		]
//		let url = generateURL(with: params)
//		URLSession.shared.dataTask(with: url) { (data, res, err) in
//			guard let data = data else { return callback(false, err) }
//			guard let dataJSON = try? JSONSerialization.jsonObject(with: data, options: []) as? JSONObject else { return callback(false, err) }
//			guard let result = dataJSON?["result"] as? Bool else { return callback(false, err) }
//			callback(result, err)
//		}
//	}
//
//	func generateURL(with params: [String: String]) -> URL{
//		var url = URLComponents(string: baseEntityUrl)!
//		for param in params{
//			url.queryItems?.append(URLQueryItem(name: param.key, value: param.value))
//		}
//		print(url.string!)
//		return url.url!
//	}