import UIKit

struct User{
	var name, lastName, email: String
}

class MainViewController: UIViewController {
	@IBOutlet weak var ttlLbl: UILabel!
	
	var myUser: User?
	
    override func viewDidLoad() {
        super.viewDidLoad()

		if let myUser = myUser{
			print(myUser)
			ttlLbl.text = "Hi \(myUser.name)"
		}
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
