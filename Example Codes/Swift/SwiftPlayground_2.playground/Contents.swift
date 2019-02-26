//: Playground - noun: a place where people can play

import UIKit

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

// 单例

class NumbersParser: NumberParser {
    
    static let sharedInstance = NumbersParser()
    
    func numberToChinese(number: Int) -> String {
        let numbers = String(number)
        var finalString = ""
        for singleNumber in numbers{
            let string = singleNumberToChinese(number: singleNumber)
            finalString = "\(finalString)\(string)"
        }
        return finalString
    }
    
}

let numbersString = NumbersParser.sharedInstance.numberToChinese(number: 2015)

print(numbersString)

// 类的重载

class YearParser: NumbersParser {
    static let sharedYearParserInstance = YearParser()
    
    override func numberToChinese(number:Int) -> String {
        let numbersString = super.numberToChinese(number: number)
        return "\(numbersString) 年"
    }
    
}

let yearString = YearParser.sharedYearParserInstance.numberToChinese(number: 2015)

print(yearString)

let numbersString2 = NumbersParser.sharedInstance.numberToChinese(number: 2015)

print(numbersString2)

