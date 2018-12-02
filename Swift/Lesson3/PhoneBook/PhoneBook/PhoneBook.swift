import Foundation

class PhoneBook: CustomStringConvertible{
	var contacts: [Contact]
	var description: String{
		var phoneBookDescription = ""
		for contact in self.contacts{
			phoneBookDescription += "\(contact)\n"
		}
		return phoneBookDescription
	} 
	
	init() {
		self.contacts = []
	}
	
	init(_ contacts: [Contact]) {
		self.contacts = contacts
	}
	
	func addContact(_ name: String, phoneNumber: String = "", phoneType: PhoneType = .count, email: String = "") -> PhoneBook{
		self.contacts.append(Contact(name, phoneNumber: phoneNumber, phoneType: phoneType, email: email))
		return self
	}
	
	func deleteContact(_ name: String) -> Bool{
		if let con = findContact(name){
			self.contacts.remove(at: con.index)
			return true
		}
		return false
	}
	
	func addNumber2Contact(_ number: String, to name: String, numberType: PhoneType) -> Bool{
		if let con = findContact(name){
			con.contact.addNumber(number, type: numberType)
			return true
		}
		return false
	}
	
	func getContacts() -> [Contact]{
		return self.contacts
	}
	
	func findContact(_ name: String) -> (index: Int, contact: Contact)?{
		for i in 0 ..< self.contacts.count{
			if(self.contacts[i].name == name){
				return (i, self.contacts[i])
			}
		}
		return nil
	}
}
