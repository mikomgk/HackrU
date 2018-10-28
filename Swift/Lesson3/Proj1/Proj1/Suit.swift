import Foundation
enum Suit: Int{//}, CustomStringConvertible{
	case Spades, Clubs, Diamonds, Hearts, count
	
//	var description: String{
//		return self.getSign()
//	}
	
	func getSign() -> String{
		switch self{
		case .Spades:
			return "♠️"
		case .Clubs:
			return "♣️"
		case .Diamonds:
			return "♦️"
		case .Hearts:
			return "♥️"
		case .count:
			return ""
		}
		
	}
}
