//
//  Helper.swift
//  Diary
//
//  Created by 周楷雯 on 2016/10/16.
//  Copyright © 2016年 kevinzhow. All rights reserved.
//

import UIKit

extension UIWebView {
    
    func captureView() -> UIImage{
        
        // 存储初始大小
        let tmpFrame = self.frame
        
        // 新的 Frame
        
        var aFrame = self.frame
        
        aFrame.size.width = self.sizeThatFits(UIScreen.main.bounds.size).width
        
        // 展开 Frame
        self.frame = aFrame
        
        // 初始化 ImageContext
        UIGraphicsBeginImageContextWithOptions(
            self.sizeThatFits(UIScreen.main.bounds.size),
            false,
            UIScreen.main.scale)
        
        // 创建新的 Context
        
        let resizedContext = UIGraphicsGetCurrentContext()
        self.layer.render(in: resizedContext!)
        
        // 重新渲染到新的 resizedContext
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        // 还原 Frame
        self.frame = tmpFrame
        return image!
    }
}


func diaryButtonWith(text: String,
                     fontSize: CGFloat,
                     width: CGFloat,
                     normalImageName: String,
                     highlightedImageName: String) -> UIButton {
    
    // 创建自定义按钮
    let button = UIButton(type: UIButtonType.custom)
    
    // 设定按钮的大小
    button.frame = CGRect(x: 0, y: 0, width: width, height: width)
    
    let font = UIFont(name: "Wyue-GutiFangsong-NC", size: fontSize) as UIFont!
    
    let textAttributes: [String : AnyObject] = [
        NSFontAttributeName: font!,
        NSForegroundColorAttributeName: UIColor.white]
    
    // 设置按钮的字体
    let attributedText = NSAttributedString(string: text, attributes: textAttributes)
    button.setAttributedTitle(attributedText, for: UIControlState.normal)
    
    // 设置默认按钮的样式
    button.setBackgroundImage(UIImage(
        named: normalImageName),
                              for: UIControlState.normal)
    
    // 设置按钮被按下时的样式
    button.setBackgroundImage(UIImage(
        named: highlightedImageName),
                              for: UIControlState.highlighted)
    
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
