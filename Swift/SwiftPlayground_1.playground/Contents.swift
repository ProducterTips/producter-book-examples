//: Playground - noun: a place where people can play

import UIKit

// 类

class NumberParser {
    
    func singleNumberToChinese(number: Character) -> String {
        switch number {
        case "0":
            return "零"
        case "1":
            return "一"
        case "2":
            return "二"
        case "3":
            return "三"
        case "4":
            return "四"
        case "5":
            return "五"
        case "6":
            return "六"
        case "7":
            return "七"
        case "8":
            return "八"
        case "9":
            return "九"
        default:
            return ""
        }
    }
    
}

// 类的实例化

let convertor = NumberParser()
let zeroString = convertor.singleNumberToChinese(number: "0")
print(zeroString)

// 类的继承

class NumbersParser: NumberParser {
    
    func numberToChinese(number: Int) -> String {
        let numbers = String(number).characters
        var finalString = ""
        for singleNumber in numbers{
            let string = singleNumberToChinese(number: singleNumber)
            finalString = "\(finalString)\(string)"
        }
        return finalString
    }
    
}

let conventor = NumbersParser()
let yearString = conventor.numberToChinese(number: 2015)
print(yearString)
