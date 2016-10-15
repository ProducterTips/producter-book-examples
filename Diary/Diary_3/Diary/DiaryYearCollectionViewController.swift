//
//  DiaryYearCollectionViewController.swift
//  Diary
//
//  Created by 周楷雯 on 2016/10/16.
//  Copyright © 2016年 kevinzhow. All rights reserved.
//

import UIKit

class DiaryYearCollectionViewController: UICollectionViewController {
    var year: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let layout = DiaryLayout()
        
        layout.scrollDirection = UICollectionViewScrollDirection.horizontal
        self.collectionView?.setCollectionViewLayout(layout, animated: false)

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
        cell.labelText = "一月"

        return cell
    }

}
