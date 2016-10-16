//
//  DiaryHelper.swift
//  Diary
//
//  Created by kevinzhow on 15/5/19.
//  Copyright (c) 2015年 kevinzhow. All rights reserved.
//

import UIKit

var defaultFont = "Wyue-GutiFangsong-NC"

let screenRect = UIScreen.main.bounds
let DiaryRed = UIColor(red: 192.0/255.0, green: 23.0/255.0, blue: 48.0/255.0, alpha: 1.0)
let DiaryFont = UIFont(name: defaultFont, size: 18) as UIFont!
let DiaryLocationFont = UIFont(name: defaultFont, size: 16) as UIFont!
let DiaryTitleFont = UIFont(name: defaultFont, size: 18) as UIFont!

//Coredata
let appDelegate =
UIApplication.shared.delegate as! AppDelegate

let managedContext = appDelegate.managedObjectContext!

extension Diary {
    func updateTimeWithDate(_ date: Date){
        self.created_at = date
        self.year = NSNumber((Calendar.current as NSCalendar).component(NSCalendar.Unit.year, from: date))
        self.month = NSNumber((Calendar.current as NSCalendar).component(NSCalendar.Unit.month, from: date))
    }
}

func diaryButtonWith(text: String, fontSize: CGFloat, width: CGFloat, normalImageName: String, highlightedImageName: String) -> UIButton {
    
    let button = UIButton(type: UIButtonType.custom) //创建自定义 Button
    button.frame = CGRect(x: 0, y: 0, width: width, height: width) //设定 Button 的大小
    
    let font = UIFont(name: "Wyue-GutiFangsong-NC", size: fontSize) as UIFont!
    let textAttributes: [String : AnyObject] = [NSFontAttributeName: font!, NSForegroundColorAttributeName: UIColor.white]
    let attributedText = NSAttributedString(string: text, attributes: textAttributes)
    button.setAttributedTitle(attributedText, for: UIControlState()) //设置 Button 字体
    
    button.setBackgroundImage(UIImage(named: normalImageName), for: UIControlState()) //设置默认 Button 样式
    button.setBackgroundImage(UIImage(named: highlightedImageName), for: UIControlState.highlighted) // 设置 Button 被按下时候的样式
    
    return button
    
}

func diaryButtonWith(text: String, fontSize: CGFloat, width: CGFloat, normalImageName: String, highlightedImageName: String, color: UIColor) -> UIButton {
    
    let button = UIButton(type: UIButtonType.custom)
    button.frame = CGRect(x: 0, y: 0, width: width, height: width)
    
    let font = UIFont(name: defaultFont, size: fontSize) as UIFont!
    let textAttributes: [String : AnyObject] = [NSFontAttributeName: font!, NSForegroundColorAttributeName: color]
    let attributedText = NSAttributedString(string: text, attributes: textAttributes)
    button.setAttributedTitle(attributedText, for: UIControlState())
    
    button.setBackgroundImage(UIImage(named: normalImageName), for: UIControlState())
    button.setBackgroundImage(UIImage(named: highlightedImageName), for: UIControlState.highlighted)
    
    return button
}




func numberToChinese(_ number:Int) -> String {
    let numbers = Array(String(number).characters)
    var finalString = ""
    for singleNumber in numbers {
        let string = singleNumberToChinese(singleNumber)
        finalString = "\(finalString)\(string)"
    }
    return finalString
}

func numberToChineseWithUnit(_ number:Int) -> String {
    let numbers = Array(String(number).characters)
    var units = unitParser(numbers.count)
    var finalString = ""
    
    for (index, singleNumber) in numbers.enumerated() {
        let string = singleNumberToChinese(singleNumber)
        if (!(string == "零" && (index+1) == numbers.count)){
            finalString = "\(finalString)\(string)\(units[index])"
        }
    }
    
    return finalString
}

func unitParser(_ unit:Int) -> [String] {
    
    var units = Array(["万","千","百","十",""].reversed())
    let parsedUnits = units[0..<(unit)].reversed()
    let slicedUnits: ArraySlice<String> = ArraySlice(parsedUnits)
    let final: [String] = Array(slicedUnits)
    return final
}


func singleNumberToChinese(_ number:Character) -> String {
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

