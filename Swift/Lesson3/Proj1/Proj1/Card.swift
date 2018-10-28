import Foundation

struct Card: CustomDebugStringConvertible{
	let suit: Suit
	let rank: Rank
	
	var debugDescription: String{
		return "\(rank.getRank()) of \(suit.getSign())"
	}
	
	func getCard() -> String{
		return "\(rank.getRank()) of \(suit.getSign())"
	}
}
