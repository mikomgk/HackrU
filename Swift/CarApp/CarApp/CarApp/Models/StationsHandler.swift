//
//  StationsMap.swift
//  CarApp
//
//  Created by Miko Stern on 1/1/19.
//  Copyright © 2019 Miko Stern. All rights reserved.
//

import Foundation
import CoreLocation

class StationsHandler{
	public static let shared = StationsHandler()
	private var stationsMap = Dictionary<CLLocation, Station>()
	private var companiesMap = Dictionary<Int32, StationCompany>()
	
	private init() {
		buildStationsMap()
		buildCompaniesMap()
	}
	
	private func buildStationsMap(){
		let stations = CoreEntitiesDao.shared.getAll(entityType: Station.self)
		for station in stations{
			let coordinate = CLLocation(latitude: station.x, longitude: station.y)
			stationsMap[coordinate] = station
		}
	}
	
	private func buildCompaniesMap(){
		let companies = CoreEntitiesDao.shared.getAll(entityType: StationCompany.self)
		for company in companies { companiesMap[company.id] = company }
	}
	
	func getClosestStations(){
		
	}
}
