//
//  DiaryLabel.swift
//  Diary
//
//  Created by kevinzhow on 15/5/19.
//  Copyright (c) 2015年 kevinzhow. All rights reserved.
//

import UIKit

func sizeHeightWithText(_ labelText: NSString,
    fontSize: CGFloat,
    textAttributes: [String : AnyObject]) -> CGRect {
        
        return labelText.boundingRect(
            with: CGSize(width: fontSize, height: 480),
            options: NSStringDrawingOptions.usesLineFragmentOrigin,
            attributes: textAttributes, context: nil)
}

class DiaryLabel: UILabel {
    
    var textAttributes: [String : AnyObject]!
    
    convenience init(fontname:String,
        labelText:String,
        fontSize : CGFloat,
        lineHeight: CGFloat){
            
            self.init(frame: CGRect.zero)
            
            let font = UIFont(name: fontname,
                size: fontSize) as UIFont!
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = lineHeight
            
            textAttributes = [NSFontAttributeName: font!,
                NSParagraphStyleAttributeName: paragraphStyle]
            
            let labelSize = sizeHeightWithText(labelText as NSString, fontSize: fontSize ,textAttributes: textAttributes)
            
            self.frame = CGRect(x: 0, y: 0, width: labelSize.width,
                height: labelSize.height)
            
            self.attributedText = NSAttributedString(
                string: labelText,
                attributes: textAttributes)
            self.lineBreakMode = NSLineBreakMode.byCharWrapping
            self.numberOfLines = 0
    }
    
    func resizeLabelWithFontName(_ fontname:String,
        labelText:String,
        fontSize : CGFloat,
        lineHeight: CGFloat ){
            let font = UIFont(name: fontname, size: fontSize)
                as UIFont!
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = lineHeight
            
            textAttributes = [NSFontAttributeName: font!,
                NSForegroundColorAttributeName: UIColor.black,
                NSParagraphStyleAttributeName: paragraphStyle]
            
            let labelSize = sizeHeightWithText(labelText as NSString, fontSize: fontSize
                ,textAttributes: textAttributes)
            
            self.frame = CGRect(x: 0, y: 0, width: labelSize.width,
                height: labelSize.height)
            
            self.attributedText = NSAttributedString(
                string: labelText,
                attributes: textAttributes)
            
            self.lineBreakMode = NSLineBreakMode.byCharWrapping
            self.numberOfLines = 0
    }
    
    func updateText(_ labelText: String) {
        
        let labelSize = sizeHeightWithText(labelText as NSString,
            fontSize: self.font.pointSize,
            textAttributes: textAttributes)
        
        self.frame = CGRect(x: 0, y: 0, width: labelSize.width,
            height: labelSize.height)
        
        self.attributedText = NSAttributedString(
            string: labelText,
            attributes: textAttributes)
    }
    
    func updateLabelColor(_ color: UIColor) {
        
        textAttributes[NSForegroundColorAttributeName] = color
        
        self.attributedText = NSAttributedString(
            string: self.attributedText!.string,
            attributes: textAttributes)
    }
    
}
