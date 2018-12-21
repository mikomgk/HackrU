´import UIKit

class ViewController: UIViewController {

	@IBOutlet weak var userNameTxt: UITextField!
	@IBOutlet weak var passwordTxt: UITextField!
	@IBOutlet weak var loginOrRegisterSwitch: UISwitch!
	@IBOutlet weak var loginRegBtn: UIButton!
	var isLogIn: Bool{
		return loginOrRegisterSwitch.isOn
	}
	
	@IBAction func loginRegSwitched(_ sender: UISwitch) {
		let text = isLogIn ? "Login" : "Register"
		self.loginRegBtn.setTitle(text, for: .normal)
	}
	
	@IBAction func btnTapped(_ sender: UIButton) {
		if !userNameTxt.isValid || !passwordTxt.isValid{
			if !userNameTxt.isValid{
				setError(toTextField: userNameTxt)
			}
			if !passwordTxt.isValid{
				setError(toTextField: passwordTxt)
			}
			return
		}
		let userName = userNameTxt.text!
		let password = passwordTxt.text!
		isLogIn
			? login(userName: userName, password: password)
			: register(userName: userName, password: password)
	}
	
	func setError(toTextField txtField: UITextField){
		txtField.layer.borderColor = UIColor.red.cgColor
		txtField.layer.borderWidth = 3
		txtField.layer.cornerRadius = 5
		txtField.layer.masksToBounds = true
//		UIView.animateKeyframes(withDuration: 0.05, delay: 0, options: [.repeat], animations: {
//			UIView.setAnimationRepeatCount(3)
//			UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5, animations: {
//				txtField.transform = CGAffineTransform(translationX: 10, y: 0)
//			})
//			UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5, animations: {
//				txtField.transform = CGAffineTransform(translationX: -20, y: 0)
//			})
//		}) { _ in
//			txtField.transform = CGAffineTransform.identity
//		}
		UIView.animate(withDuration: 0.05, delay: 0, options: [.repeat, .autoreverse], animations: {
			UIView.setAnimationRepeatCount(3)
			txtField.transform = CGAffineTransform(translationX: 10, y: 0)
		}) { _ in
			txtField.transform = CGAffineTransform.identity
		}
	}
	
	func login(userName: String, password: String){
		let key = KeychainPasswordItem(service: "Proj1", account: userName)
		do{
			let keyChainPass = try key.readPassword()
			if keyChainPass == password{
				performSegue(withIdentifier: "login", sender: nil)
			}
		}catch{
			print("Wrong Pass")
		}
	}
	
	func register(userName: String, password: String){
		let key = KeychainPasswordItem(service: "Proj1", account: userName)
		do{
			try key.savePassword(password)
		}catch{
			fatalError("Error Saving to keychain \(error)")
		}
		performSegue(withIdentifier: "login", sender: nil)
	}
	
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
		print(mood)
	}
}

extension UITextField{
	var isValid: Bool{
		return (self.text?.count)! > 6
	}
}
