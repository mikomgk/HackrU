//: Playground - noun: a place where people can play

import UIKit

func randomNumbers(bottomBound : UInt32, upperBound : UInt32, howManyNumbers : Int, isSet : Bool) -> Set<Int>{
	var mySet = (isSet ? Set<Int>() : Array<Int>())
	var x=0;
	while mySet.count != howManyNumbers{
		mySet.insert(Int(arc4random_uniform(upperBound - bottomBound) + bottomBound))
		x += 1
	}
	print(x)
	return mySet
}

print(randomNumbers(bottomBound: 1, upperBound: 5, howManyNumbers: 4, isSet: true))

func isPrimeNumber(num : Int) -> Bool{
	for i in 2 ..< num{
		if num % i == 0{
			return false
		}
	}
	return true
}

func firstDividedNumbers(howManyNumbers : Int, firstDivider : Int, secondDivider : Int, divideRemain : Int) -> Set<Int>{
	var mySet = Set<Int>()
	var i = firstDivider > secondDivider ? secondDivider : firstDivider
	print(i)
	while mySet.count != howManyNumbers{
		if i % firstDivider == divideRemain && i % secondDivider == divideRemain{
			mySet.insert(i)
		}
		i += 1
	}
	return mySet
}

print(firstDividedNumbers(howManyNumbers: 5, firstDivider: 2, secondDivider: 13, divideRemain: 1))

func avg(myNumbers : Array<Int>) -> Double{
	var sum=0
	for num in myNumbers{
		sum += num
	}
	return Double(sum) / Double(myNumbers.count)
}

func getHighAvg(minBound : Double, howMany : Int) -> Array<Int>{
	var myNumbers = Array<Int>()
	repeat {
		myNumbers = randomNumbers(bottomBound: 1, upperBound: 100, howManyNumbers: howMany, isSet: false)
	} while avg(myNumbers: myNumbers) < minBound
	
	return myNumbers
}

print(getHighAvg(minBound: 80, howMany: 3))

var a="asd"










