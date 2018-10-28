import Foundation

enum Rank: Int{
	case Ace=1
	case Two, Three, Four, Five, Six, Seven, Eight, Nine, Ten
	case Jack, Queen, King
	case count
	
	func getRank() -> String{
		switch self {
		case .Ace:
			return "A"
		case .Jack:
			return "J"
		case .Queen:
			return "Q"
		case .King:
			return "K"
		default:
			return String(self.rawValue)
		}
	}
}



