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
    
    var edgeInsets = (screenSize.width - itemWidth)/2.0
    
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
        self.sectionInset = UIEdgeInsets(top: (screenSize.height/2.0) - (itemHeight/2.0), left: edgeInsets, bottom: (screenSize.height/2.0) - (itemHeight/2.0), right: 0)
        
        // 滚动方向
        scrollDirection = UICollectionView.ScrollDirection.horizontal
    }
    
    // 每次Cell的位置发生变化的时候都会执行
    // layoutAttributesForElementsInRect询问Cell应该放在什么位置
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        let layoutAttributes = super.layoutAttributesForElements(in: rect)
        // 获取所有需要显示的Cell的位置信息
        
        let contentOffset = collectionView!.contentOffset
        // 获取collectionView的滑动情况
        
        for attributes in layoutAttributes! {
            
            let center = attributes.center
            
            let cellPositinOnScreen = (center.x - itemWidth/2.0) - contentOffset.x
            
            if cellPositinOnScreen >= (edgeInsets - itemWidth/2.0)
                && cellPositinOnScreen < (edgeInsets
                    + collectionViewWidth ) {
                
                // 计算Cell是不是在应该显示的区域
                attributes.alpha = 1
                
            } else {
                attributes.alpha = 0
            }
        }
        
        return layoutAttributes
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
}

func calInsets(numberOfCells: Int) -> UIEdgeInsets {
    
    let insetLeft = (screenSize.width - collectionViewWidth)/2.0
    
    var edgeInsets: CGFloat = 0
    
    if (numberOfCells >= 3) {
        
        edgeInsets = insetLeft
        
    } else {
        edgeInsets = insetLeft + (collectionViewWidth - (CGFloat(numberOfCells)*itemWidth))/2.0
    }
    
    return UIEdgeInsets(top: (screenSize.height/2.0) - (itemHeight/2.0), left: edgeInsets, bottom: (screenSize.height/2.0) - (itemHeight/2.0), right: 0)
}

