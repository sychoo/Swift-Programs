//: Playground - noun: a place where people can play

import UIKit
import Darwin

var str = "Hello, playground"
print(str)
print(str, terminator:"")


let maxInt: UInt64 = UInt64.max

let myAge = "2.25"
// let myAgeInt: Int? = myAge.toInt()
let myAgeFloat = (myAge as NSString).floatValue
let myAgeInt: Int! = Int(myAge)
print(myAgeFloat, myAgeInt)

var num: Int = 1
num += 1
print("num ++ \(num)")

let numberOfOranges = 5
let appleSummary = "I have \(numberOfOranges) apples."
print(appleSummary)

let age = 19
var isLegal: Bool = (age > 18) ? true : false
print (isLegal)


var groceries = [String]()

groceries.append("Tomato")
groceries.append("Beans")
groceries.append("Potatoes")
groceries.append("Beans")

print(groceries)


//let match = groceries.indexOf("Beans")
//print("\(match)")


print(groceries)

// enumeration
var numbers = [1,3,5,7]
for (index, value) in numbers.enumerated()
{
    print("\(index) \(value)")
}

// Optional
let userEnteredText = "3"
let userEnteredInteger = Int(userEnteredText)

if let catAge = userEnteredInteger {
    print(catAge * 7)
} else{
    print("Error")
}

