//
//  LocationManager.swift
//  CarApp
//
//  Created by Miko Stern on 12/25/18.
//  Copyright © 2018 Miko Stern. All rights reserved.
//

import UIKit
import CoreLocation

class LocationManager: NSObject{
	public static let shared = LocationManager()
	weak var delegate: LocationManagerDelegate?{
		didSet{
			lm.delegate = self
		}
	}
	let lm = CLLocationManager()
	let geoCoder = CLGeocoder()
	var isLocationEnabled: Bool{
		return CLLocationManager.locationServicesEnabled()
	}
	
	private override init() {
		super.init()
		
	}
	
	func requestLocationUpdates(){
		lm.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
		lm.startUpdatingLocation()
	}
}

extension LocationManager: CLLocationManagerDelegate{
	func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
		switch status {
		case .restricted, .denied://TODO: add a popup message
			let url = URL(string: UIApplication.openSettingsURLString)!
			UIApplication.shared.open(url, options: [:])
		case .authorizedAlways, .authorizedWhenInUse:
			if delegate?.isContinuesLocation() ?? false{
				requestLocationUpdates()
			}else{
				delegate?.locationUpdated(lm.location)
			}
		case .notDetermined:
			lm.requestWhenInUseAuthorization()
		}
	}
	
	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		print(locations[0])
		delegate?.locationUpdated(locations[0])
	}
	
	func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
		print("ERROR: \(error)")
	}
}

protocol LocationManagerDelegate: class {
	func isContinuesLocation() -> Bool
	func locationUpdated(_ location: CLLocation?)
}
