import UIKit

class ViewController: UIViewController {
	
	@IBOutlet weak var question: UITextField!
	@IBOutlet weak var answer: UILabel!
	let oracle = Oracle(name: "myOracle", answers: ["how are you":"fine thanks","whats your name":"myOracle","my":"my"])
	override func viewDidLoad() {
		super.viewDidLoad()
		
		
		//		print(oracle.ask(question: "who am i"))
		//		print(oracle.ask(question: "who am i"))
		//		print(oracle.ask(question: "who am i"))
		//		print(oracle.ask(question: "who am i"))
		//		print(oracle.ask(question: "who am i"))
		//		print(oracle.ask(question: "who am i"))
		//		print(oracle.ask(question: "what's your name"))
		//		print(oracle.ask(question: "how are you"))
	}
	
	@IBAction func askQuestion(_ sender: Any) {
		var answerStr = answer.text
		if let questionStr = question.text{
			if !questionStr.isEmpty{
				answerStr?.append("\(questionStr): \(oracle.ask(question: questionStr))\n")
			}
		}
		answer.text = answerStr
		question.text = nil
	}
}

func randomNumber(upperBound: Int) -> Int{
	return Int(arc4random_uniform(UInt32(upperBound)))
}

func randomNumber(lowerBound: Int, upperBound: Int) -> Int{
	return randomNumber(upperBound: upperBound-lowerBound) + lowerBound
}
