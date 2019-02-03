//
//  DiaryLabel.swift
//  Diary
//
//  Created by 周楷雯 on 2016/10/16.
//  Copyright © 2016年 kevinzhow. All rights reserved.
//

import UIKit

func sizeHeightWithText(labelText: String,
                        fontSize: CGFloat,
                        textAttributes: [NSAttributedString.Key: AnyObject]) -> CGRect {
    
    return labelText.boundingRect(
        with: CGSize(width:fontSize, height:480),
        options: NSStringDrawingOptions.usesLineFragmentOrigin,
        attributes: textAttributes, context: nil)
}

class DiaryLabel: UILabel {
    
    var textAttributes: [NSAttributedString.Key: AnyObject]!
    
    convenience init(fontname:String,
                     labelText:String,
                     fontSize : CGFloat,
                     lineHeight: CGFloat){
        
        self.init(frame: CGRect(x:0, y:0, width:0, height:0))
        
        let font = UIFont(name: fontname,
                          size: fontSize)
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineHeight
        
        textAttributes = [NSAttributedString.Key.font: font!,
                          NSAttributedString.Key.paragraphStyle: paragraphStyle]
        
        let labelSize = sizeHeightWithText(labelText: labelText,
                                           fontSize: fontSize ,
                                           textAttributes: textAttributes)
        
        self.frame = CGRect(x: 0, y: 0, width: labelSize.width,
                            height: labelSize.height)
        
        self.attributedText = NSAttributedString(
            string: labelText,
            attributes: textAttributes)
        self.lineBreakMode = NSLineBreakMode.byCharWrapping
        self.numberOfLines = 0
    }
    
}
