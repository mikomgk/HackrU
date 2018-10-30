import UIKit

class ViewController: UIViewController {
	
	@IBOutlet var cards: [UIButton]!
	@IBOutlet weak var ttlLbl: UILabel!
	@IBOutlet weak var movesLbl: UILabel!
	@IBOutlet weak var timeLbl: UILabel!
	@IBOutlet weak var pairsLbl: UILabel!
	
	let cardBack = "⚡︎"
	let nummberOfPairs = 18
	let normalColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
	let wonColor = UIColor(red: 1, green: 0, blue: 0, alpha: 1)
	
	var openCardsCount = 0
	var correctPairsCount = 0
	var openCardsIndex = [0, 0]
	var cardsSequence = [Card]()
	var openCards = [Int : UIButton]()
	var timeCount = 0
	var movesCount = 0
	var timer: Timer? = nil
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setGamesCards()
		startGame()
	}
	
	func setGamesCards(){
		var cardsSet = Card.getOrderedCardSet()
		while !cardsSet.isEmpty{
			cardsSequence.append(cardsSet.remove(at: randomNumber(upperBound: cardsSet.count)))
		}
	}
	
	@IBAction func turnCard(_ sender: UIButton) {
		if movesCount == 0 && timer == nil{
			startTimer()
		}
		openCardsIndex[openCardsCount] = sender.tag
		openCards[openCardsCount] = sender
		openCardsCount += 1
		toggleCard(sender, show: true)
		timer(do: {
			if self.openCardsCount == 2{
				self.openCardsCount = 0
				self.addMove()
				self.checkCards() ? self.correctPairs() : self.wrongPairs()
			}
		}, after: 0.2)
	}
	
	func startTimer(){
		timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { (_) in
			self.timeCount += 1
			let time = self.getTime()
			self.timeLbl.text = "\(time.min):\(time.sec < 10 ? "0" : "")\(time.sec):\(time.mil < 10 ? "0" : "")\(time.mil)"
		}
	}
	
	func getTime() -> (min: Int, sec: Int, mil: Int){
		let min: Int, sec: Int, mil: Int
		mil = timeCount % 100
		sec = timeCount / 100 % 60
		min = timeCount / 100 / 60
		return (min, sec, mil)
	}
	
	func stopTimer(){
		timer?.invalidate()
		timer = nil
	}
	
	func addMove(){
		movesCount += 1
		movesLbl.text = String(movesCount)
	}
	
	func gameWon(){
		stopTimer()
		changeLbl(ttlLbl, ttl: "You Won!!", color: wonColor)
		changeLbl(movesLbl, color: wonColor, size: 38)
		changeLbl(timeLbl, color: wonColor, size: 38)
		changeLbl(pairsLbl, color: wonColor, size: 38)
		timer(do: startGame, after: 3)
	}
	
	func timer(do block: @escaping () -> Void, after seconds: Double){
		DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
			block()
		}
	}
	
	func startGame(){
		changeLbl(ttlLbl, ttl: "Memory Game", color: normalColor, size: 38)
		for card in cards{
			toggleCard(card, show: false)
		}
		movesCount = 0
		timeCount = 0
		correctPairsCount = 0
		changeLbl(movesLbl, ttl: "\(movesCount)", color: normalColor, size: 21)
		changeLbl(timeLbl, ttl: "0:00:00", color: normalColor, size: 21)
		changeLbl(pairsLbl, ttl: "0/\(nummberOfPairs)", color: normalColor, size: 21)
	}
	
	func changeLbl(_ label: UILabel, ttl: String? = nil, color: UIColor? = nil, size: Int? = nil){
		label.text = ttl ?? label.text
		label.textColor = color != nil ? color : label.textColor
		label.font = label.font.withSize(size != nil ? CGFloat(size!) : label.font.pointSize)
	}
	
	func correctPairs(){
		correctPairsCount += 1
		pairsLbl.text = "\(correctPairsCount)/\(nummberOfPairs)"
		if correctPairsCount == nummberOfPairs{
			gameWon()
		}
	}
	
	func wrongPairs(){
		lockCards(lock: true)
		timer(do: {
			for card in self.openCards.values{
				self.toggleCard(card, show: false)
			}
			self.lockCards(lock: false)
		}, after: 0.4)
	}
	
	func lockCards(lock: Bool){
		for card in cards{
			toggleCard(card, lockOnly: true, lock: !lock)
		}
	}
	
	func toggleCard(_ card: UIButton, show: Bool = false, lockOnly: Bool = false, lock: Bool = false){
		if !lockOnly{
			card.setTitle(show ? cardsSequence[card.tag].getCard() : cardBack, for: .normal)
		}
		card.isEnabled = lockOnly ? lock :!show
	}
	
	func checkCards() -> Bool{
		return openCards[0]!.title(for: .normal) == openCards[1]!.title(for: .normal)
	}
	
	func randomNumber(upperBound: Int) -> Int{
		return Int(arc4random_uniform(UInt32(upperBound)))
	}
	
	func randomNumber(lowerBound: Int, upperBound: Int) -> Int{
		return randomNumber(upperBound: upperBound-lowerBound) + lowerBound
	}
	
}

