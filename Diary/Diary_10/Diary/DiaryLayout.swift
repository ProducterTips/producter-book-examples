//
//  DiaryLayout.swift
//  Diary
//
//  Created by 周楷雯 on 2016/10/16.
//  Copyright © 2016年 kevinzhow. All rights reserved.
//

import UIKit

let screenSize = UIWindow().screen.bounds

class DiaryLayout: UICollectionViewFlowLayout {
    override func prepare() {
        super.prepare() //准备布局
        // Cell 大小
        let itemSize = CGSize(width: itemWidth,height: itemHeight)
        self.itemSize = itemSize
        // Cell 左右间距
        self.minimumInteritemSpacing = 0.0
        // Cell 行间距
        self.minimumLineSpacing = 0
        // 增加内嵌
        self.sectionInset = UIEdgeInsets(top: (screenSize.height/2.0) - (itemHeight/2.0), left: (screenSize.width/2.0) - (itemWidth/2.0), bottom: (screenSize.height/2.0) - (itemHeight/2.0), right: (screenSize.height/2.0) - (itemHeight/2.0))
        
        // 滚动方向
        scrollDirection = UICollectionView.ScrollDirection.horizontal
    }
}

