//: Playground - noun: a place where people can play

import UIKit

func getMountaion(peak: Int) -> [Int]{
	var mountain = [Int]()
	for i in 1...peak{
		mountain.append(i)
	}
	var x = peak - 1
	while x > 0 {
		mountain.append(x)
		x -= 1
	}
	return mountain
}

let numbers = [2,3,2,4]
var palindromeMountains = [1]
for number in numbers{
	palindromeMountains.removeLast()
	palindromeMountains.append(contentsOf: getMountaion(peak: number))
}
print(palindromeMountains)
