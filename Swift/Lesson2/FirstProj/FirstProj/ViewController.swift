//
//  ViewController.swift
//  FirstProj
//
//  Created by Miko Stern on 10/21/18.
//  Copyright © 2018 Miko Stern. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	
	let cardType = ["♦️","♠️","♥️","♣️"]
	let cardRank = ["2","3","4","5","6","7","8","9","10","J","Q","K","A"]
	
	override func viewDidLoad() {
		super.viewDidLoad()
		let x = add(x: 1, y: 2)
		print(x)
		sayHello(to: "Miko")
		print(randomNumber(upperBound: 10))
//		for _ in 1...50{
//			print(randomNumber(lowerBound: 10, upperBound: 20),terminator: ",")
//		}
		randomNumber(l: 3)
		print("dsg","fds")
		for _ in 1...8{
			let card = randomCard()
			print("Your cars is \(card.type) \(card.rank)")
		}
		let cardPack = getCardsArray()
		let shuffledPack = shufflePack(cardPack: cardPack)
		printCardsPack(cardPack: shuffledPack)
		example1()
		exampl2()
	}
	
	func example1(){
		let names = ["Guy","fdsf", "fds","fds","fsdfgsdg"]
		var dict = [String: Int]()
		var sumChar = 0
		var str = "";
		for name in names{
			sumChar += name.count
			str.append(contentsOf: name)
			dict[name] = name.count
		}
		print(sumChar)
		print(str)
		print(names)
		print(shuffle(array: names))
		print(names.sorted())
		print(dict)
	}
	
	func exampl2(){
//		let textToPrint = ".nwod edispu ma I"
//		var wrong = textToPrint
//		var str = ""
//		while wrong.count>0{
//			str.append(wrong.removeLast())
//		}
//		print(str)
		let numbers = [2,3,2,4]
		var palindromeMountains = [1]
		for number in numbers{
			palindromeMountains.removeLast()
			palindromeMountains.append(contentsOf: getMountaion(peak: number))
		}
		print(palindromeMountains)
	}
	
	func getMountaion(peak: Int) -> [Int]{
		var mountain = [Int]()
		for i in 1...peak{
			mountain.append(i)
		}
		var x = peak - 1
		while peak > 0 {
			mountain.append(x)
			x -= 1
		}
		return mountain
	}
	
	func shuffle(array: [String]) -> [String]{
		var arr = array
		var newArr = [String]()
		var i: Int
		while arr.count > 0 {
			i = randomNumber(upperBound: arr.count)
			newArr.append(arr[i])
			arr.remove(at: i)
		}
		return newArr
	}
	
	func shufflePack(cardPack: [(type: String, rank: String)]) -> [(type: String, rank: String)]{
		var newPack = cardPack
		var shuffuledPack = [(type: String, rank: String)]()
		var j : Int
		var countCards = ["♣️": 0, "♦️": 0, "♠️": 0, "♥️": 0]
		while newPack.count > 0 {
			j = randomNumber(upperBound: newPack.count)
			countCards[newPack[j].type]! += 1
			shuffuledPack.append(newPack[j])
			newPack.remove(at: j)
		}
		print(countCards)
		return shuffuledPack
	}
	
	func printCardsPack(cardPack: [(type: String, rank: String)]){
		for (i,card) in cardPack.enumerated(){
			print("\(i < 9 ? " " : "")\(i + 1). \(card.type) \(card.rank)")
		}
	}
	
	func getCardsArray() -> [(type: String, rank: String)]{
		var result : [(type: String, rank: String)] = []
		for i in 0 ..< cardType.count{
			for j in 0 ..< cardRank.count{
				result.append((type: cardType[i], rank: cardRank[j]))
			}
		}
		return result
	}
	
	func randomCard() -> (type: String, rank: String){
		let cT = randomNumber(upperBound: cardType.count)
		let cR = randomNumber(upperBound: cardRank.count)
		return (cardType[cT], cardRank[cR])
	}
	
	func sayHello(to name: String){
		print("Hello \(name)")
	}
	
	func randomNumber(upperBound: Int) -> Int{
		return Int(arc4random_uniform(UInt32(upperBound)))
	}
	
	func randomNumber(lowerBound: Int, upperBound: Int) -> Int{
		return randomNumber(upperBound: upperBound-lowerBound) + lowerBound
	}
	
	func randomNumber(l: Int){
		print("\nl")
	}
	
}

func add(x: Int, y: Int) -> Int{
	return x+y
}
