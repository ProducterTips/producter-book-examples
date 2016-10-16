//
//  DiaryLayout.swift
//  Diary
//
//  Created by kevinzhow on 15/5/19.
//  Copyright (c) 2015年 kevinzhow. All rights reserved.
//

import UIKit

class DiaryLayout: UICollectionViewFlowLayout {
    override func prepare() {
        super.prepare()
        let itemSize = CGSize(width: itemWidth,height: itemHeight)
        self.itemSize = itemSize
        self.minimumInteritemSpacing = 0.0
        self.minimumLineSpacing = 0
        scrollDirection = UICollectionViewScrollDirection.horizontal
    }
}
