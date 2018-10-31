import UIKit

class MainViewController: UIViewController {
	@IBOutlet weak var number: UILabel!
	@IBOutlet weak var segment: UISegmentedControl!
	
	var numberVal: Double?
	var segmentVal: Int?
	
    override func viewDidLoad() {
        super.viewDidLoad()

		number.text = String(numberVal ?? 0)
		segment.selectedSegmentIndex = segmentVal!
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
