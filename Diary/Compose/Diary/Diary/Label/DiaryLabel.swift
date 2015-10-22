//
//  DiaryLabel.swift
//  Diary
//
//  Created by kevinzhow on 15/5/19.
//  Copyright (c) 2015年 kevinzhow. All rights reserved.
//

import UIKit

func sizeHeightWithText(labelText: NSString,
    fontSize: CGFloat,
    textAttributes: [String : AnyObject]) -> CGRect {
        
        return labelText.boundingRectWithSize(
            CGSizeMake(fontSize, 480),
            options: NSStringDrawingOptions.UsesLineFragmentOrigin,
            attributes: textAttributes, context: nil)
}

class DiaryLabel: UILabel {
    
    var textAttributes: [String : AnyObject]!
    
    convenience init(fontname:String,
        labelText:String,
        fontSize : CGFloat,
        lineHeight: CGFloat){
            
            self.init(frame: CGRectZero)
            
            let font = UIFont(name: fontname,
                size: fontSize) as UIFont!
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = lineHeight
            
            textAttributes = [NSFontAttributeName: font,
                NSParagraphStyleAttributeName: paragraphStyle]
            
            let labelSize = sizeHeightWithText(labelText, fontSize: fontSize ,textAttributes: textAttributes)
            
            self.frame = CGRectMake(0, 0, labelSize.width,
                labelSize.height)
            
            self.attributedText = NSAttributedString(
                string: labelText,
                attributes: textAttributes)
            self.lineBreakMode = NSLineBreakMode.ByCharWrapping
            self.numberOfLines = 0
    }
    
    func resizeLabelWithFontName(fontname:String,
        labelText:String,
        fontSize : CGFloat,
        lineHeight: CGFloat ){
            let font = UIFont(name: fontname, size: fontSize)
                as UIFont!
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = lineHeight
            
            textAttributes = [NSFontAttributeName: font,
                NSForegroundColorAttributeName: UIColor.blackColor(),
                NSParagraphStyleAttributeName: paragraphStyle]
            
            let labelSize = sizeHeightWithText(labelText, fontSize: fontSize
                ,textAttributes: textAttributes)
            
            self.frame = CGRectMake(0, 0, labelSize.width,
                labelSize.height)
            
            self.attributedText = NSAttributedString(
                string: labelText,
                attributes: textAttributes)
            
            self.lineBreakMode = NSLineBreakMode.ByCharWrapping
            self.numberOfLines = 0
    }
    
    func updateText(labelText: String) {
        
        let labelSize = sizeHeightWithText(labelText,
            fontSize: self.font.pointSize,
            textAttributes: textAttributes)
        
        self.frame = CGRectMake(0, 0, labelSize.width,
            labelSize.height)
        
        self.attributedText = NSAttributedString(
            string: labelText,
            attributes: textAttributes)
    }
    
    func updateLabelColor(color: UIColor) {
        
        textAttributes[NSForegroundColorAttributeName] = color
        
        self.attributedText = NSAttributedString(
            string: self.attributedText!.string,
            attributes: textAttributes)
    }
    
}