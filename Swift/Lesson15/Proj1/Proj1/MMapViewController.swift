//
//  ViewController.swift
//  Proj1
//
//  Created by Miko Stern on 12/9/18.
//  Copyright © 2018 Miko Stern. All rights reserved.
//

import UIKit
import MapKit

class MMapViewController: UIViewController {
	
	@IBOutlet weak var mapView: MKMapView!
	@IBOutlet weak var changeMapSelector: UISegmentedControl!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		changeMapSelector.selectedSegmentIndex = 0
		changeMapType(changeMapSelector)
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		MLocationManager.shared.delegate = self
		mapView.showsUserLocation = true
		mapView.showsCompass = true
	}
	
	@IBAction func changeMapType(_ sender: UISegmentedControl) {
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
	
	override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
		if motion == .motionShake{
			guard let location = CLLocationManager().location else { return }
			let annotation = PizzaAnnotation(coordinate: location.coordinate, title: "Pizza - fdsfds", subtitle: "fdsfddfdsfs")
			mapView.addAnnotation(annotation)
		}
	}
}

extension MMapViewController: MKMapViewDelegate{
	func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
		if annotation is MKUserLocation{
			return nil
		}
		//let view = mapView.dequeueReusableAnnotationView(withIdentifier: "pizza", for: annotation) as? MKPinAnnotationView
		//if view == nil{
			let v = MKAnnotationView(annotation: annotation, reuseIdentifier: "pizza")
			v.image = UIImage(named: "pizza")
			v.backgroundColor = UIColor.clear
			v.canShowCallout = true
			//pin.pinTintColor = UIColor.purple
			return v
		//}
		//return view
	}
	
	func mapViewDidFinishLoadingMap(_ mapView: MKMapView) {
	}
	
	func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
		print("Did Update")
	}
	
	func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
		print("Selected an annotation")
	}
}

extension MMapViewController: MLocationManagerDelegate{
	func location(_ location: [CLLocation]) {
		DispatchQueue.main.async {
			for loc in location{
				let region = MKCoordinateRegion(center: loc.coordinate, latitudinalMeters: 200, longitudinalMeters: 200)
				self.mapView.setRegion(region, animated: true)
			}
		}
	}
}
