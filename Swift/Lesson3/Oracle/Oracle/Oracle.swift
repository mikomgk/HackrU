import Foundation

struct Oracle{
	let name: String
	var answers: Dictionary<String, String>
	
	func ask(question: String) -> String{
		return answers[question] ?? Answer(rawValue: (randomNumber(upperBound: Answer.count.rawValue)))!.toString()
	}
}
