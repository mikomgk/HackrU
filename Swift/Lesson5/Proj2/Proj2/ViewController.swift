import UIKit

class ViewController: UIViewController {
	@IBOutlet weak var nameInput: UITextField!
	@IBOutlet weak var laseNameInput: UITextField!
	@IBOutlet weak var emailInput: UITextField!
	
	@IBAction func nextBtn(_ sender: UIButton) {
		if let name = nameInput.text, let lastName = laseNameInput.text, let email = emailInput.text{
			if !name.isEmpty && !lastName.isEmpty && !email.isEmpty{
				print(name, lastName, email)//, separator: ", ")
			}
			performSegue(withIdentifier: <#T##String#>, sender: <#T##Any?#>)
		}
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		let id = segue.identifier
		print(id ?? "no id")
		if let name = nameInput.text, let lastName = laseNameInput.text, let email = emailInput.text{
			if !name.isEmpty && !lastName.isEmpty && !email.isEmpty{
				let user = User(name: name, lastName: lastName, email: email)
				guard let dest = segue.destination as? MainViewController else{
					return
				}
				dest.myUser = user
			} else {
				return
			}
		}
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
	}


}

