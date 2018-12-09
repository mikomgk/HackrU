import UIKit
import CoreLocation

class MLocationViewController: UIViewController {

	@IBOutlet weak var cordsLbl: UILabel!
	override func viewDidLoad() {
        super.viewDidLoad()

    }
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		MLocationManager.shared.delegate = self
	}
}

extension MLocationViewController: MLocationManagerDelegate{
	func location(_ location: [CLLocation]) {
		DispatchQueue.main.async {
			self.cordsLbl.text = "\(location[0].coordinate)"
			self.cordsLbl.sizeToFit()
		}
	}
}
