import Foundation

enum Card: Int{
	
	case 🇨🇦, 🏳️‍🌈, 🇦🇽, 🇦🇷, 🇦🇺, 🇪🇺, 🇪🇬, 🇪🇨, 🇮🇳, 🇯🇲, 🇯🇵, 🇵🇹, 🇺🇸, 🏴󠁧󠁢󠁷󠁬󠁳󠁿, 🏴󠁧󠁢󠁥󠁮󠁧󠁿, 🇲🇰, 🇿🇦, 🇰🇷
	
	static func getOrderedCardSet(numberOfPairs: Int) -> [Card]{
		var cardsSet = [Card]()
		var numberSet = [Int]()
		for i in 0 ..< 18{
			numberSet.append(i)
		}
		for _ in 1 ... numberOfPairs{
			cardsSet.append(Card(rawValue: numberSet.remove(at: randomNumber(upperBound: numberSet.count)))!)
		}
		return cardsSet + cardsSet
	}
	
	func getCard() -> String{
		switch self{
		case .🇨🇦:
			return "🇨🇦"
		case .🏳️‍🌈:
			return "🏳️‍🌈"
		case .🇦🇽:
			return "🇦🇽"
		case .🇦🇷:
			return "🇦🇷"
		case .🇦🇺:
			return "🇦🇺"
		case .🇪🇺:
			return "🇪🇺"
		case .🇪🇬:
			return "🇪🇬"
		case .🇪🇨:
			return "🇪🇨"
		case .🇮🇳:
			return "🇮🇳"
		case .🇯🇲:
			return "🇯🇲"
		case .🇯🇵:
			return "🇯🇵"
		case .🇵🇹:
			return "🇵🇹"
		case .🇺🇸:
			return "🇺🇸"
		case .🏴󠁧󠁢󠁷󠁬󠁳󠁿:
			return "🏴󠁧󠁢󠁷󠁬󠁳󠁿"
		case .🏴󠁧󠁢󠁥󠁮󠁧󠁿:
			return "🏴󠁧󠁢󠁥󠁮󠁧󠁿"
		case .🇲🇰:
			return "🇲🇰"
		case .🇿🇦:
			return "🇿🇦"
		case .🇰🇷:
			return "🇰🇷"
		}
	}
}
