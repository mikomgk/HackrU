import UIKit

class ViewController: UIViewController {
	
	@IBOutlet weak var cText: UITextField!
	@IBOutlet weak var fText: UITextField!
	@IBOutlet weak var kText: UITextField!
	
	var cVal = 0.0
	var fVal = 0.0
	var kVal = 0.0
	
	@IBAction func cCng(_ sender: UITextField) {
		if let c = cText.text{
			if !c.isEmpty{
				cText.text = c
				fText.text = "\((Double(c) ?? 0 * 9.0 / 5.0) + 32.0)"
				kText.text = "\(Double(c) ?? -273.15 + 273.15)"
			}
		}
	}
	
	@IBAction func fCng(_ sender: UITextField) {
		if let f = fText.text{
			if !f.isEmpty{
				fVal = Double(f) ?? 0
				cVal = (Double(f) ?? 32 - 32) * 5.0 / 9.0
				kVal = (Double(f) ?? 32 - 32) * 5.0 / 9.0 + 273.15
			}
		}
	}
	
	@IBAction func kCng(_ sender: UITextField) {
		if let k = kText.text{
			if !k.isEmpty{
				kText.text = k
				cText.text = "\(Double(k) ?? 273.15 - 273.15)"
				fText.text = "\((Double(k) ?? 273.15 - 273.15) * 9.0 / 5.0 + 32)"
			}
		}
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
	}
	
	
}

