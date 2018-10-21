//: Playground - noun: a place where people can play

import UIKit

var a = "fdasf"
var b = "cdsa"
let arr = [a,b]
print(arr)
a = "ttt"
print(arr)
func myFunc(a : Int) -> Int{
	return a + 2
}
print(myFunc(a: 2))

let setA: Set = [1,2,3,4,5]
let setB: Set = [3,4,5,6,7]
print("Intersection: \(Array(setA.intersection(setB)).sorted())")
print("Union: \(Array(setA.union(setB)).sorted())")
print("Substacting: \(Array(setA.subtracting(setB)).sorted())")
print("SymmetricDifference: \(Array(setA.symmetricDifference(setB)).sorted())")

let days = ["dasd":"DASDAS","Dsadas":"DSAdas"]
let keys = Array(days.keys)
print(keys)
let values = Array(days.values)
print(values)

var xa = [1,2,3,4,5]
var ya = xa
print(xa,ya,separator: "\n")
xa = [9,8,7,6,5]
print(xa,ya,separator: "\n")

