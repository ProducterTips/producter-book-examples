//
//  Helper.swift
//  Diary
//
//  Created by 周楷雯 on 2016/10/16.
//  Copyright © 2016年 kevinzhow. All rights reserved.
//

import UIKit

func diaryButtonWith(text: String,
                     fontSize: CGFloat,
                     width: CGFloat,
                     normalImageName: String,
                     highlightedImageName: String) -> UIButton {
    
    // 创建自定义按钮
    let button = UIButton(type: UIButton.ButtonType.custom)
    
    // 设定按钮的大小
    button.frame = CGRect(x: 0, y: 0, width: width, height: width)
    
    let font = UIFont(name: "Wyue-GutiFangsong-NC", size: fontSize)
    
    let textAttributes: [NSAttributedString.Key: AnyObject] = [
        NSAttributedString.Key.font: font!,
        NSAttributedString.Key.foregroundColor: UIColor.white]
    
    // 设置按钮的字体
    let attributedText = NSAttributedString(string: text, attributes: textAttributes)
    button.setAttributedTitle(attributedText, for: UIControl.State.normal)
    
    // 设置默认按钮的样式
    button.setBackgroundImage(UIImage(
        named: normalImageName),
                              for: UIControl.State.normal)
    
    // 设置按钮被按下时的样式
    button.setBackgroundImage(UIImage(
        named: highlightedImageName),
                              for: UIControl.State.highlighted)
    
    return button
}

