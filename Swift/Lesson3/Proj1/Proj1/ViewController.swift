import UIKit

class ViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		
		let s = Suit.Hearts
		print(s.getSign())
		
		let d = Day.Friday
		print(d.getDay())
		
		let pack = Deck()
		print(pack.toString())
		let shuffled = pack.shuffle()
		print(shuffled.toString())
		
		print(pack)
		//print(pack.shuffle())
		
	}

}

func randomNumber(to upperBound: Int) -> Int{
	return Int(arc4random_uniform(UInt32(upperBound)))
}

func randomNumber(from lowerBound: Int, to upperBound: Int) -> Int{
	return randomNumber(to: upperBound-lowerBound) + lowerBound
}
