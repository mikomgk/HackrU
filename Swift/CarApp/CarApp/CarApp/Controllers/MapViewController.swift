//
//  MapViewController.swift
//  CarApp
//
//  Created by Miko Stern on 12/22/18.
//  Copyright © 2018 Miko Stern. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

	@IBOutlet weak var mapSwitch: UISegmentedControl!
	@IBOutlet weak var mapView: MKMapView!
	@IBOutlet weak var centerUserLocationBtn: UIButton!
	
	override func viewDidLoad() {
        super.viewDidLoad()

		mapSwitch.selectedSegmentIndex = 0
		mapSwitched(mapSwitch)
		mapSwitch.layer.cornerRadius = 5
		
		centerUserLocationBtn.layer.cornerRadius = 25
		centerUserLocationBtn.addShadow()
		
		//LocationManager.shared.delegate = self
    }
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		mapView.showsUserLocation = true
		mapView.showsCompass = true
	}
    
	@IBAction func mapSwitched(_ sender: UISegmentedControl) {
		switch sender.selectedSegmentIndex {
		case 0:
			mapView.mapType = .standard
		case 1:
			mapView.mapType = .satellite
		case 2:
			mapView.mapType = .hybrid
		default:
			break
		}
	}
}

extension MapViewController: MKMapViewDelegate{
}

extension MapViewController: LocationManagerDelegate{
	func isContinuesLocation() -> Bool {
		return true
	}
	
	func locationUpdated(_ location: CLLocation?) {
//		DispatchQueue.main.async {
//			let defaultLocation = CLLocationCoordinate2D(latitude: 32.0851925, longitude: 34.7816849)
//			let region = MKCoordinateRegion(center: location?.coordinate ?? defaultLocation, latitudinalMeters: 1000, longitudinalMeters: 1000)
//			self.mapView.setRegion(region, animated: true)
//		}
		return
	}
}

extension UIButton{
	func addShadow(){
		layer.shadowColor = UIColor.gray.cgColor
		layer.shadowOffset = CGSize(width: 0, height: 0)
		layer.shadowOpacity = 1
		layer.shadowRadius = 10
		layer.masksToBounds = false
	}
}
