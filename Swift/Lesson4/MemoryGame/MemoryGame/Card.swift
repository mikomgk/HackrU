import Foundation

enum Card: Int{
	
	case 🇨🇦, 🏳️‍🌈, 🇦🇽, 🇦🇷, 🇦🇺, 🇪🇺, 🇪🇬, 🇪🇨, 🇮🇳, 🇯🇲, 🇯🇵, 🇵🇹, 🇺🇸, 🏴󠁧󠁢󠁷󠁬󠁳󠁿, 🏴󠁧󠁢󠁥󠁮󠁧󠁿, 🇬🇧, 🇿🇦, 🇰🇷
	
	static func getOrderedCardSet() -> [Card]{
		var cardsSet = [Card]()
		for i in 0..<18{
			cardsSet.append(Card(rawValue: i)!)
			cardsSet.append(Card(rawValue: i)!)
		}
		return cardsSet
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
		case .🇬🇧:
			return "🇬🇧"
		case .🇿🇦:
			return "🇿🇦"
		case .🇰🇷:
			return "🇰🇷"
		}
	}
}
