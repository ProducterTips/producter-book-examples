//: Playground - noun: a place where people can play

import UIKit

let labelText = "竖排文字"

let fontSize: CGFloat = 22.0

func sizeHeightWithText(labelText: NSString,
    fontSize: CGFloat,
    textAttributes: [String : AnyObject]) -> CGRect {
        
        return labelText.boundingRectWithSize(
            CGSizeMake(fontSize, 480),
            options: NSStringDrawingOptions.UsesLineFragmentOrigin,
            attributes: textAttributes, context: nil)
}

// 引用 UIKit 这样才能找得到 UILabel

var newLabel = UILabel(frame: CGRectMake(0, 0, 300, 100))

// 创建新的 UILabel，并且设置长宽为 100 和 300

newLabel.text = "HeyLabel"

// 设置 Label 的文字

newLabel.sizeToFit()

// 使 Label 的大小自动适应文字的大小

newLabel

let font = UIFont.systemFontOfSize(fontSize)

var newLabelTwo = UILabel(frame: CGRect(x: 0, y: 0, width: 20, height: 100))

newLabelTwo.text = "竖排文字"
// 设置带有字体样式的文字

newLabelTwo.lineBreakMode = NSLineBreakMode.ByCharWrapping
// 以字符为换行标准

newLabelTwo.numberOfLines = 0
//  允许多行

