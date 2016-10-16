//
//  DiaryMonthCollectionViewController.swift
//  Diary
//
//  Created by 周楷雯 on 2016/10/16.
//  Copyright © 2016年 kevinzhow. All rights reserved.
//

import UIKit
let DiaryRed = UIColor.init(colorLiteralRed: 192.0/255.0, green: 23/255.0, blue: 48.0/255.0, alpha: 1)

class DiaryMonthCollectionViewController: UICollectionViewController {
    var month: Int!
    var yearLabel: DiaryLabel!
    var monthLabel: DiaryLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = DiaryLayout()
        
        layout.scrollDirection = UICollectionViewScrollDirection.horizontal
        self.collectionView?.setCollectionViewLayout(layout, animated: false)
        
        yearLabel = DiaryLabel(
            fontname: "TpldKhangXiDictTrial",
            labelText: "二零一五年",
            fontSize: 16.0,
            lineHeight: 5.0,
            color: UIColor.black)

        yearLabel.frame = CGRect(x: screenSize.width - yearLabel.frame.size.width - 20, y: 20, width: yearLabel.frame.size.width, height: yearLabel.frame.size.height)
        
        self.view.addSubview(yearLabel)
        
        monthLabel = DiaryLabel(
            fontname: "Wyue-GutiFangsong-NC",
            labelText: "三月",
            fontSize: 16.0,
            lineHeight: 5.0,
            color: DiaryRed)

        monthLabel.frame = CGRect(x: screenSize.width - monthLabel.frame.size.width - 20, y: screenSize.height/2.0 - monthLabel.frame.size.height/2.0, width: monthLabel.frame.size.width, height: monthLabel.frame.size.height)
        
        self.view.addSubview(monthLabel)
        
        
        // 添加按钮
        
        let composeButton = diaryButtonWith(text: "撰",
                                            fontSize: 14.0,
                                            width: 40.0,
                                            normalImageName: "Oval",
                                            highlightedImageName: "Oval_pressed")
        
        composeButton.center = CGPoint(x: yearLabel.center.x,
                                       y: 38 + yearLabel.frame.size.height + 26.0/2.0)
        
        composeButton.addTarget(self, action: #selector(newCompose),
                                for: UIControlEvents.touchUpInside)
        
        self.view.addSubview(composeButton)
    
    }
    
    func newCompose() {
        
        let identifier = "DiaryComposeViewController"
        
        let composeViewController = self.storyboard?.instantiateViewController(withIdentifier: identifier)
            as! DiaryComposeViewController
        
        self.present(composeViewController,
                                   animated: true,
                                   completion: nil)
        
    }

    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identifier = "DiaryCell"
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! DiaryCell
        
        cell.textInt = 1
        cell.labelText = "季风气候"
        
        return cell
    }
    
}
