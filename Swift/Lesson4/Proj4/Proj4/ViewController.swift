import UIKit

class ViewController: UIViewController {

	@IBOutlet weak var rLbl: UILabel!
	@IBOutlet weak var gLbl: UILabel!
	@IBOutlet weak var bLbl: UILabel!
	@IBOutlet weak var hexLbl: UILabel!
	@IBOutlet weak var mainView: UIView!
	@IBOutlet weak var red: UISlider!
	@IBOutlet weak var green: UISlider!
	@IBOutlet weak var blue: UISlider!
	
	var r = CGFloat(0.5)
	var g = CGFloat(0.5)
	var b = CGFloat(0.5)
	
	@IBAction func change(_ sender: UISlider) {
		switch sender.tag{
		case 1:
			r = CGFloat(red.value)
		case 2:
			g = CGFloat(green.value)
		case 3:
			b = CGFloat(blue.value)
		default:
			break
		}
		mainView.backgroundColor = UIColor(displayP3Red: r, green: g, blue: b, alpha: 1)
		rLbl.text = "red: \(Int(r * 255))"
		gLbl.text = "green: \(Int(g * 255))"
		bLbl.text = "blue: \(Int(b * 255))"
		hexLbl.text = toHex(r: Int(r * 255), g: Int(g * 255), b: Int(b * 255))
		let opColor = UIColor(displayP3Red: (1 - r), green: (1 - g), blue: (1 - b), alpha: 1)
		rLbl.textColor = opColor
		gLbl.textColor = opColor
		bLbl.textColor = opColor
		hexLbl.textColor = opColor
	}
	
	func toHex(r: Int, g: Int, b: Int) -> String{
		return "#\(String(r, radix: 16))\(String(g, radix: 16))\(String(b, radix: 16))"
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
	}


}

