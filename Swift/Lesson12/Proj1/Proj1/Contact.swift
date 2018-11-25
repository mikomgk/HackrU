import Foundation

class Contact: NSObject, NSSecureCoding{
	static var supportsSecureCoding: Bool{
		return true
	}
	
	var firstName: String
	var lastName: String
	override var description: String{
		return "\(firstName) \(lastName)"
	}
	
	init(firstName: String, lastName: String) {
		self.firstName = firstName
		self.lastName = lastName
	}
	
	func encode(with aCoder: NSCoder) {
		aCoder.encode(firstName, forKey: "firstName")
		aCoder.encode(lastName, forKey: "lastName")
	}
	
	required init?(coder aDecoder: NSCoder) {
		firstName = aDecoder.decodeObject(forKey: "firstName") as! String
		lastName = aDecoder.decodeObject(forKey: "lastName") as! String
	}
}
