//: Playground - noun: a place where people can play

import UIKit

let labelText = "竖排文字"

let fontSize: CGFloat = 22.0

func sizeHeightWithText(labelText: NSString,
    fontSize: CGFloat,
    textAttributes: [String : Any]) -> CGRect {
        
    return labelText.boundingRect(
        with: CGSize(width:fontSize, height:480),
            options: NSStringDrawingOptions.usesLineFragmentOrigin,
            attributes: textAttributes, context: nil)
}

// 引用 UIKit 这样才能找得到 UILabel

var newLabel = UILabel(frame: CGRect(x:0, y:0, width:300, height:100))

// 创建新的 UILabel，并且设置长宽为 100 和 300

newLabel.text = "HeyLabel"

// 设置 Label 的文字

newLabel.sizeToFit()

// 使 Label 的大小自动适应文字的大小

newLabel

let font = UIFont.systemFont(ofSize: fontSize)

var newLabelTwo = UILabel(frame: CGRect(x: 0, y: 0, width: 20, height: 200))

newLabelTwo.text = "一闪一闪亮晶晶"
// 设置带有字体样式的文字

newLabelTwo.lineBreakMode = NSLineBreakMode.byCharWrapping
// 以字符为换行标准

newLabelTwo.numberOfLines = 0
//  允许多行

