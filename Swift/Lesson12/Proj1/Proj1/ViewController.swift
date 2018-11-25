import UIKit

class ViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		
		let c = Contact(firstName: "Moses", lastName: "Doe")
		let cData = try? NSKeyedArchiver.archivedData(withRootObject: c, requiringSecureCoding: true)
		UserDefaults.standard.set(cData, forKey: "data")
		let readData = UserDefaults.standard.data(forKey: "data")
		let contactFromData = try! NSKeyedUnarchiver.unarchivedObject(ofClasses: [Contact.self], from: readData!)
		print(contactFromData ?? "")
		let name = UserDefaults.standard.string(forKey: "name")
		print(name ?? "")
		let mood = UserDefaults.standard.integer(forKey: "mood")
		print(mood ?? "")
	}
}

