import Foundation

struct Question: CustomStringConvertible{
	
	var question: String
	var answers: [String]
	var correctAnswer: Int
	var category: Category
	var correctAnsStr: String{
		return answers[correctAnswer - 1]
	}
	
	var description: String{
		var str = "\(category):\n\(question)?\n\n"
		for (i, answer) in answers.enumerated(){
			str.append("\(i+1). \(answer)\n")
		}
		return str
	}
	
	func chackAns(answer: Int) -> Bool{
		return answer == correctAnswer
	}
}
