import UIKit

var str = "Hello, playground"

let bill : Double = 121
let billPrecent = 0.15
let tip = bill*billPrecent
print("your bill is \(bill) the tip will be \(tip) total: \(bill+tip)")


let a : Character = "s"
let yes:Bool=true

var y:Int

var x:Int?=5
if let x=x{
	print(x)
}

var userName : String?
userName = "boo"
print("Hello", terminator: "")
if let userName=userName{
	print(" \(userName)")
} else {
	print(", There...")
}
print(1...5)
let g=5
print(g)

var gh : Int
gh = 55

print(gh)

switch gh/10{
case 0,1,2,3,4,5:
	print("E")
	fallthrough
case 6:
	print("D")
case 7:
	print("C")
case 8:
	print("B")
case 9,10:
	print("A")
default:
	print("WRONG")
}

switch gh {
case 90..<1000:
	print("A")
	fallthrough
case 90...98:
	print("AA")
default:
	print("NOT")
}

var c : Character = "d"
switch c {
case "A"..."Z":
	print("UPPER")
case "a"..."z":
	print("lower")
default:
	print("not letter")
}

let arr = [1,2,3,4,6]
var sum = 0
for item in arr{
	sum += item
}
print(sum)
var avg = Double(sum)/Double(arr.count)
print(avg)

var numbers = [1,1,2,3,5,8,13]
for _ in 1...10{
	numbers.append(numbers[numbers.count - 1] + numbers[numbers.count - 2])
}
print(numbers)

var names = [String]()
names.append("bar")
names.append("dsa")
names.append("das")
for i in 0..<names.count{
	print("(\(i + 1)) \(names[i])")
}
print()
for (index,name) in names.enumerated(){
	print("(\(index + 1)) \(name)")
}


var dict1 = [String: String]()
dict1["cow"]="grass"
dict1["lion"]="antilope"
dict1["dog"]="cat"

print(dict1)

for (a,f) in dict1{
	print("\(a) eats \(f)")
}

let q = arc4random_uniform(10)
print(q)
print(type(of: q))









