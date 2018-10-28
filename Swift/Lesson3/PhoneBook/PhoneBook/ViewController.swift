import UIKit

class ViewController: UIViewController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		let pb = PhoneBook()
		pb.addContact("miko", phoneNumber: "0574365747", phoneType: .Mobile, email: "vdvdf@vsdvds.com")
			.addContact("vvsd", phoneNumber: "034324234", phoneType: .Mobile)
			.addContact("cdcds", email: "dsvcdsv@cdscs.com")
			.addNumber2Contact("03-543-4343", to: "miko", numberType: .Home)
		pb.deleteContact("vvsd")
		//print(pb)
		let cons = [Contact("miko", phoneNumber: "0574365747", phoneType: .Mobile, email: "vdvdf@vsdvds.com")
			.addNumber("03-543-4343", type: .Home),
					Contact("vvsd", phoneNumber: "034324234", phoneType: .Mobile),
					Contact("cdcds", email: "dsvcdsv@cdscs.com")]
		let pb2 = PhoneBook(cons)
		print(pb2)
		true.hashValue
	}
}

