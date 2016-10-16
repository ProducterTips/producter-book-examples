//
//  DiaryCell.swift
//  Diary
//
//  Created by 周楷雯 on 2016/10/16.
//  Copyright © 2016年 kevinzhow. All rights reserved.
//

import UIKit

class DiaryCell: UICollectionViewCell {
    var textLabel: DiaryLabel!
    var textInt: Int = 0
    var labelText: String = "" {
        didSet {
            textLabel.updateText(labelText: labelText)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // 界面载入内存
        self.textLabel = DiaryLabel(
            fontname: "Wyue-GutiFangsong-NC",
            labelText: labelText,
            fontSize: 16.0,
            lineHeight: 5.0,
            color: UIColor.black)
        self.contentView.addSubview(textLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews() // 当对子视图进行布局时
        self.textLabel.center = CGPoint(x: itemWidth/2.0, y: 150.0/2.0)
    }
}
