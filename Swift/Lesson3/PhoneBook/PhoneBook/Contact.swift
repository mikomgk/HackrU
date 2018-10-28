import Foundation

class Contact: CustomStringConvertible, Hashable{
	var name: String
	var phoneNumbers: [PhoneType: String]
	var email: String
	var description: String{
		var contactDescription = """
		\(self.name):
		\(self.email.isEmpty ? "" : "\(self.email)\n")
		"""
		for (phoneType, phoneNumber) in self.phoneNumbers{
			contactDescription += "\(phoneType): \(phoneNumber)\n"
		}
		return contactDescription
	}
	var hashValue: Int{
		return self.description.hashValue
	}
	
	static func == (lhs: Contact, rhs: Contact) -> Bool {
		if lhs.description == rhs.description{
			return true
		}
		return false
	}
	
	init(_ name: String, phoneNumber: String = "", phoneType: PhoneType = .count, email: String = "") {
		self.name = name
		if phoneNumber.isEmpty || phoneType == .count{
			self.phoneNumbers = [PhoneType: String]()
		} else {
			self.phoneNumbers = [phoneType: phoneNumber]
		}
		self.email = email
	}
	
	func addNumber(_ number: String, type: PhoneType) -> Contact{
		self.phoneNumbers[type] = number
		return self
	}
}
