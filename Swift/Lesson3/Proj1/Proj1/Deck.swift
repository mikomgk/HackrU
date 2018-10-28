import Foundation

struct Deck: CustomDebugStringConvertible{
	var cards: [Card]
	
	init() {
		cards = []
		for i in 0 ..< Suit.count.rawValue{
			for j in 1 ..< Rank.count.rawValue{
				cards.append(Card(suit: Suit(rawValue: i)!, rank: Rank(rawValue: j)!))
			}
		}
	}
	
	var debugDescription: String{
		var str = ""
		for card in cards{
			str.append("\(card), ")
		}
		return str
	}
	
	func shuffle() -> Deck{
		var newCards = self
		var shuffledDeck = Deck()
		shuffledDeck.cards = []
		while newCards.cards.count > 0 {
			shuffledDeck.cards.append(newCards.cards.remove(at: randomNumber(to: newCards.cards.count)))
		}
		return shuffledDeck
	}
	
	func toString() -> String{
		var s = ""
		for card in cards{
			s.append(card.getCard())
			s.append("\n")
		}
		return s
	}
}
