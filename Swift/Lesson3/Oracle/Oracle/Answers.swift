import Foundation

enum Answer: Int{
	case Yes, No, DontKnow, count
	
	func toString() -> String{
		switch self{
		case .Yes:
			return "Yes"
		case .No:
			return"No"
		case .DontKnow:
			return "I Don't Know"
		case .count:
			return ""
		}
	}
}
