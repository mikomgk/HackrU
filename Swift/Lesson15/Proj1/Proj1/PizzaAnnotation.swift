import Foundation
import MapKit

class PizzaAnnotation: NSObject, MKAnnotation {
	var title: String?
	var subtitle: String?
	var coordinate: CLLocationCoordinate2D
	override var description: String{
		return "\(title ?? "")\n"
	}
	
	init(coordinate: CLLocationCoordinate2D, title: String?, subtitle: String?) {
		self.coordinate = coordinate
		self.title = title
		self.subtitle = subtitle
	}
}
