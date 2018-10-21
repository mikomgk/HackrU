//: Playground - noun: a place where people can play

import UIKit

func randomNumber(upperBound: Int) -> Int{
	return Int(arc4random_uniform(UInt32(upperBound)))
}

func randomNumber(lowerBound: Int, upperBound: Int) -> Int{
	return randomNumber(upperBound: upperBound-lowerBound) + lowerBound
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

var names = ["Guy","fdsf", "fds","fds","fsdfgsdg"]
var sumChar = 0
var str = "";
for name in names{
	sumChar += name.count
	str.append(contentsOf: name)
}
print(sumChar)
print(str)
print(names)
print(shuffle(array: names))







