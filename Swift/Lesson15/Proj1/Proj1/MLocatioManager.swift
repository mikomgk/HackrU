import UIKit
import CoreLocation
import Contacts

class MLocationManager: NSObject {
	public static let shared = MLocationManager()
	let lm = CLLocationManager()
	weak var delegate: MLocationManagerDelegate?
	let geoCoder = CLGeocoder()
	var hasAuthorization: Bool{
		var isAutorized = false
		let status = CLLocationManager.authorizationStatus()
		switch status {
		case .notDetermined, .restricted, .denied:
			isAutorized = false
		case .authorizedAlways, .authorizedWhenInUse:
			isAutorized = true
		}
		return isAutorized
	}
	var locationEnabled: Bool{
		return CLLocationManager.locationServicesEnabled()
	}
	
	private override init(){
		super.init()
		lm.delegate = self
	}
	
	func address(location: CLLocation){
		geoCoder.reverseGeocodeLocation(location) { (places, err) in
			if let err = err{
				print(err.localizedDescription)
				return
			}
			guard let place = places?.first else { return }
			let street = place.postalAddress?.street ?? "no street"
			print(street, place, separator: "\n")
		}
	}
	
	func getCoord(addressString: String){
		geoCoder.geocodeAddressString(addressString) { (places, err) in
			if let err = err{
				print(err.localizedDescription)
				return
			}
			guard let place = places?.first else { return }
			DispatchQueue.main.async {
				print(place.location?.coordinate ?? "")
				
			}
		}
	}
	
	func requestLocationUpdates(){
		lm.desiredAccuracy = kCLLocationAccuracyBest
		lm.startUpdatingLocation()
	}
}

extension MLocationManager: CLLocationManagerDelegate{
	func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
		print("ERROR: \(error)")
	}
	
	func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
		switch status {
		case .restricted, .denied:
			let url = URL(string: UIApplication.openSettingsURLString)!
			UIApplication.shared.open(url, options: [:])
		case .authorizedAlways, .authorizedWhenInUse:
			//lm.location
			requestLocationUpdates()
		case .notDetermined:
			lm.requestAlwaysAuthorization()
		}
	}
	
	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		print(locations[0])
		delegate?.location(locations)
	}
}

@objc protocol MLocationManagerDelegate: class {
	func location(_ location: [CLLocation])
	@objc optional func doWork()
}
