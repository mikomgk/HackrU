import Foundation
enum Day{
	case Sunday, Monday, Tuseday, Wednsday, Thursday, Friday, Saturday
	
	func getDay() -> Int{
		switch self {
		case .Sunday:
			return 1
		case .Monday:
			return 2
		case .Tuseday:
			return 3
		case .Wednsday:
			return 4
		case .Thursday:
			return 5
		case .Friday:
			return 6
		case .Saturday:
			return 7
		}
	}
}
