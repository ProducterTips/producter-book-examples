//
//  DiaryCollectionViewCell.swift
//  Diary
//
//  Created by kevinzhow on 15/5/19.
//  Copyright (c) 2015年 kevinzhow. All rights reserved.
//

import UIKit

class DiaryCollectionViewCell: UICollectionViewCell {
    var textLabel: DiaryLabel!
    
    var labelText: String = "" {
        didSet {
            self.textLabel.updateText(labelText)
            self.textLabel.center = CGPointMake(itemWidth/2.0, self.textLabel.center.y + 28)
        }
    }
    
    var textInt:Int = 0
    
    override func awakeFromNib() {
        
        let lineHeight:CGFloat = 5.0
        
        self.textLabel = DiaryLabel(fontname: "Wyue-GutiFangsong-NC", labelText: labelText, fontSize: 16.0, lineHeight: lineHeight)
        
        self.addSubview(textLabel)
    }
    

    
    
}