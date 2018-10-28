import UIKit

class ViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		
		let q1 = Question(question: "What animal can fly",
						  answers: ["Dog","Cat","Eagle","Lion"],
						  correctAnswer: 3,
						  category: .Nature)
		
		print(q1)
		
		let userAnswer: String? = "3"
		if let userAnswer = userAnswer{
			print("the answer \(userAnswer) is \(q1.chackAns(answer: Int(userAnswer) ?? 0))")
		}
		
		let life = [("Who will you go with?", ["mother", "father"]),
					("Who will you marry?", ["Anna", "Elise", "Jean"]),
					("Who will you go with?", ["mother", "father"]),
					("Who will you marry?", ["Anna", "Elise", "Jean"])]
		var sum = life[life.count - 1].1.count
		for i in (0 ... life.count-2).reversed(){
			sum *= life[i].1.count
		}
		print(sum)

	}

}

