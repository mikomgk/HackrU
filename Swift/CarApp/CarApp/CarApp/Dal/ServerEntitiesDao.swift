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
	let baseEntityUrl = "https://carlogapp.herokuapp.com/entity"
	lazy var appDelegate: AppDelegate = {
		return UIApplication.shared.delegate as! AppDelegate
	}()
	
	private init() {}
	
	func getAll(entityType: EntityType, callback: @escaping (JSONArray?, Error?) -> ()){
		let params = [
			"mode":"get",
			"type":entityType.rawValue
		]
		let url = generateURL(with: params)
		URLSession.shared.dataTask(with: url) { (data, res, err) in
			guard let data = data else { return callback(nil, err) }
			guard let dataJSON = try? JSONSerialization.jsonObject(with: data, options: []) as? JSONArray else{ return callback(nil, err)}
			callback(dataJSON, err)
		}
	}
	
	func get(entityId: Int, of type: EntityType, callback: @escaping (JSONObject?, Error?) -> ()){
		let params = [
			"mode":"get",
			"type":type.rawValue,
			"id":entityId.description
		]
		let url = generateURL(with: params)
		URLSession.shared.dataTask(with: url) { (data, res, err) in
			guard let data = data else { return callback(nil, err) }
			guard let dataJSON = try? JSONSerialization.jsonObject(with: data, options: []) as? JSONArray else{ return callback(nil, err)}
			callback(dataJSON?[0], err)
		}
	}
	
	func new(entity: Entity, of type: EntityType, callback: @escaping (Int32?, Error?) -> ()){
		var params = [
			"mode":"new",
			"type":type.rawValue
		]
		switch type {
		case .car:
			guard let car = entity as? Car else { break }
			let p = [
				"company":car.company!,
				"dateAdded":car.date_added!.description,
				"model":car.model ?? "",
				"name":car.name ?? "",
				"nextCareDate":car.next_care_date?.description ?? "",
				"nextCareMiliege":car.next_care_miliege.description,
				"nextTest":car.next_test?.description ?? "",
				"startingMiliege":car.starting_miliege.description,
				"year":car.year.description
			]
			params.merge(p) { (_, new) -> String in new}
		case .refuel:
			guard let refuel = entity as? Refuel else { break }
			let p = [
				"date":refuel.date?.description ?? "",
				"filledLiter":refuel.filled_liter.description,
				"isFullTank":refuel.is_full_tank.description,
				"miliege":refuel.miliege.description,
				"stationId":refuel.station_id.description,
				"totalPrice":refuel.total_price.description,
				"x":refuel.x.description,
				"y":refuel.y.description,
				"carId":refuel.car_id?.id.description ?? ""
			]
			params.merge(p) { (_, new) -> String in new}
		case .service:
			guard let service = entity as? Service else { break }
			let p = [
				"date":service.date?.description ?? "",
				"miliege":service.miliege.description,
				"notes":service.notes ?? "",
				"totalCost":service.total_cost.description,
				"carId":service.car_id?.id.description ?? "",
				"garageId":service.garage_id?.id.description ?? "",
				"serviceTypeId":service.service_type_id?.description ?? "3"
			]
			params.merge(p) { (_, new) -> String in new}
		case .expense:
			guard let expense = entity as? Expense else { break }
			let p = [
				"date":expense.date?.description ?? "",
				"notes":expense.notes ?? "",
				"totalCost":expense.total_cost.description,
				"carId":expense.car_id?.id.description ?? ""
			]
			params.merge(p) { (_, new) -> String in new}
		case .serviceType://TODO: handle error
			return callback(nil, nil)
		case .garage:
			guard let garage = entity as? Garage else { break }
			let p = [
				"name":garage.name ?? "",
				"x":garage.x.description,
				"y":garage.y.description
			]
			params.merge(p) { (_, new) -> String in new}
		}
		let url = generateURL(with: params)
		URLSession.shared.dataTask(with: url) { (data, res, err) in
			guard let data = data else { return callback(nil, err) }
			guard let dataJSON = try? JSONSerialization.jsonObject(with: data, options: []) as? JSONObject else { return callback(nil, err) }
			guard let id = dataJSON?["id"] as? Int32 else { return callback(nil, err) }
			callback(id, err)
		}
	}
	
	func edit(entity: Entity, of type: EntityType, change property: EntityProperties, to newVal: String, callback: @escaping (Bool, Error?) -> ()){
		edit(entityId: entity.id, of: type, change: property, to: newVal, callback: callback)
	}
	
	func edit(entityId: Int32, of type: EntityType, change property: EntityProperties, to newVal: String, callback: @escaping (Bool, Error?) -> ()){
		if type == .garage || type == .serviceType { return callback(false, nil) }//TODO: handle error
		let p = property.rawValue
		let params = [
			"mode":"edit",
			"type":type.rawValue,
			"id":entityId.description,
			p.suffix(from: p.index(after: (p.firstIndex(of: "_")!))).description:newVal
		]
		let url = generateURL(with: params)
		URLSession.shared.dataTask(with: url) { (data, res, err) in
			guard let data = data else { return callback(false, err) }
			guard let dataJSON = try? JSONSerialization.jsonObject(with: data, options: []) as? JSONObject else { return callback(false, err) }
			guard let result = dataJSON?["result"] as? Bool else { return callback(false, err) }
			callback(result, err)
		}
	}
	
	func delete(entity: Entity, of type: EntityType, callback: @escaping (Bool, Error?) -> ()){
		delete(entityId: entity.id, of: type, callback: callback)
	}
	
	func delete(entityId: Int32, of type: EntityType, callback: @escaping (Bool, Error?) -> ()){
		if type == .garage || type == .serviceType { return callback(false, nil) }//TODO: handle error
		let params = [
			"mode":"delete",
			"type":type.rawValue,
			"id":entityId.description,
		]
		let url = generateURL(with: params)
		URLSession.shared.dataTask(with: url) { (data, res, err) in
			guard let data = data else { return callback(false, err) }
			guard let dataJSON = try? JSONSerialization.jsonObject(with: data, options: []) as? JSONObject else { return callback(false, err) }
			guard let result = dataJSON?["result"] as? Bool else { return callback(false, err) }
			callback(result, err)
		}
	}
	
	func generateURL(with params: [String: String]) -> URL{
		var url = URLComponents(string: baseEntityUrl)!
		for param in params{
			url.queryItems?.append(URLQueryItem(name: param.key, value: param.value))
		}
		print(url.string!)
		return url.url!
	}
}

typealias JSONObject = [String: Any]
typealias JSONArray = [JSONObject]
