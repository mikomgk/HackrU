import UIKit

class ThirdViewController: UIViewController {
	@IBOutlet weak var slot: UIPickerView!
	
	let a = ["🍎","🍐","🍊","🍌","🍉","🍇","🍒","🍓","🍍","🍋"]
	var options = [[String]]()
	let numOfRows = 50
	var counter = 0
	
    override func viewDidLoad() {
        super.viewDidLoad()
		options = [a, a, a]
    }
	
	@IBAction func spinBtn(_ sender: UIButton) {
		print(counter++)
		var ans = [Int]()
		for index in 0 ..< slot.numberOfComponents{
			ans.append(Int.rand(upperBound: numOfRows))
			slot.selectRow((ans[index]), inComponent: index, animated: true)
		}
		
		for i in 0..<ans.count{
			if i == ans.count - 1{
				view.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
				break
			}
			if ans[i] % a.count != ans[i + 1] % a.count{
				view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
				break
			}
		}
	}
}

extension ThirdViewController : UIPickerViewDataSource{
	func numberOfComponents(in pickerView: UIPickerView) -> Int {
		return 3
	}
	
	func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		return numOfRows
	}
}

extension ThirdViewController : UIPickerViewDelegate{
	func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
		return options[component][row % a.count]
	}
	
//	func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
//		<#code#>
//	}
}

extension Int{
	static func rand(upperBound: Int) -> Int{
		return Int(arc4random_uniform(UInt32(upperBound)))
	}
	
	static func addOne(_ x: inout Int) -> Int{
		x += 1
		return x
	}
}

prefix operator ++
postfix operator ++

prefix operator --
postfix operator --


// Increment
prefix func ++( x: inout Int) -> Int {
	x += 1
	return x
}

postfix func ++( x: inout Int) -> Int {
	x += 1
	return (x - 1)
}

prefix func ++( x: inout UInt) -> UInt {
	x += 1
	return x
}

postfix func ++( x: inout UInt) -> UInt {
	x += 1
	return (x - 1)
}

prefix func ++( x: inout Int8) -> Int8 {
	x += 1
	return x
}

postfix func ++( x: inout Int8) -> Int8 {
	x += 1
	return (x - 1)
}

prefix func ++( x: inout UInt8) -> UInt8 {
	x += 1
	return x
}

postfix func ++( x: inout UInt8) -> UInt8 {
	x += 1
	return (x - 1)
}
prefix func ++( x: inout Int16) -> Int16 {
	x += 1
	return x
}

postfix func ++( x: inout Int16) -> Int16 {
	x += 1
	return (x - 1)
}

prefix func ++(x: inout UInt16) -> UInt16 {
	x += 1
	return x
}

postfix func ++(x: inout UInt16) -> UInt16 {
	x += 1
	return (x - 1)
}

prefix func ++(x: inout Int32) -> Int32 {
	x += 1
	return x
}

postfix func ++(x: inout Int32) -> Int32 {
	x += 1
	return (x - 1)
}

prefix func ++(x: inout UInt32) -> UInt32 {
	x += 1
	return x
}

postfix func ++(x: inout UInt32) -> UInt32 {
	x += 1
	return (x - 1)
}

prefix func ++(x: inout Int64) -> Int64 {
	x += 1
	return x
}

postfix func ++(x: inout Int64) -> Int64 {
	x += 1
	return (x - 1)
}

prefix func ++(x: inout UInt64) -> UInt64 {
	x += 1
	return x
}

postfix func ++(x: inout UInt64) -> UInt64 {
	x += 1
	return (x - 1)
}

prefix func ++(x: inout Double) -> Double {
	x += 1
	return x
}

postfix func ++(x: inout Double) -> Double {
	x += 1
	return (x - 1)
}

prefix func ++(x: inout Float) -> Float {
	x += 1
	return x
}

postfix func ++(x: inout Float) -> Float {
	x += 1
	return (x - 1)
}

prefix func ++(x: inout Float80) -> Float80 {
	x += 1
	return x
}

postfix func ++(x: inout Float80) -> Float80 {
	x += 1
	return (x - 1)
}

// Decrement
prefix func --(x: inout Int) -> Int {
	x -= 1
	return x
}

postfix func --(x: inout Int) -> Int {
	x -= 1
	return (x + 1)
}

prefix func --(x: inout UInt) -> UInt {
	x -= 1
	return x
}

postfix func --(x: inout UInt) -> UInt {
	x -= 1
	return (x + 1)
}

prefix func --(x: inout Int8) -> Int8 {
	x -= 1
	return x
}

postfix func --(x: inout Int8) -> Int8 {
	x -= 1
	return (x + 1)
}

prefix func --(x: inout UInt8) -> UInt8 {
	x -= 1
	return x
}

postfix func --(x: inout UInt8) -> UInt8 {
	x -= 1
	return (x + 1)
}
prefix func --(x: inout Int16) -> Int16 {
	x -= 1
	return x
}

postfix func --(x: inout Int16) -> Int16 {
	x -= 1
	return (x + 1)
}

prefix func --(x: inout UInt16) -> UInt16 {
	x -= 1
	return x
}

postfix func --(x: inout UInt16) -> UInt16 {
	x -= 1
	return (x + 1)
}

prefix func --(x: inout Int32) -> Int32 {
	x -= 1
	return x
}

postfix func --(x: inout Int32) -> Int32 {
	x -= 1
	return (x + 1)
}

prefix func --(x: inout UInt32) -> UInt32 {
	x -= 1
	return x
}

postfix func --(x: inout UInt32) -> UInt32 {
	x -= 1
	return (x + 1)
}

prefix func --(x: inout Int64) -> Int64 {
	x -= 1
	return x
}

postfix func --(x: inout Int64) -> Int64 {
	x -= 1
	return (x + 1)
}

prefix func --(x: inout UInt64) -> UInt64 {
	x -= 1
	return x
}

postfix func --(x: inout UInt64) -> UInt64 {
	x -= 1
	return (x + 1)
}

prefix func --(x: inout Double) -> Double {
	x -= 1
	return x
}

postfix func --(x: inout Double) -> Double {
	x -= 1
	return (x + 1)
}

prefix func --(x: inout Float) -> Float {
	x -= 1
	return x
}

postfix func --(x: inout Float) -> Float {
	x -= 1
	return (x + 1)
}

prefix func --(x: inout Float80) -> Float80 {
	x -= 1
	return x
}

postfix func --(x: inout Float80) -> Float80 {
	x -= 1
	return (x + 1)
}
