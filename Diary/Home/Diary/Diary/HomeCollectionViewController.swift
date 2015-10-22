//
//  HomeCollectionViewController.swift
//  Diary
//
//  Created by kevinzhow on 15/5/19.
//  Copyright (c) 2015年 kevinzhow. All rights reserved.
//

import UIKit

let itemHeight:CGFloat = 150.0 // Cell 的高度
let itemWidth:CGFloat = 60 // Cell 的宽度
let collectionViewWidth = itemWidth * 3 //同时显示三个 Cell 时候

class HomeCollectionViewController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let yearLayout = DiaryLayout()
        
        yearLayout.scrollDirection = UICollectionViewScrollDirection.Horizontal
        self.collectionView?.setCollectionViewLayout(yearLayout, animated: false)
        self.collectionView!.frame = CGRect(x:0, y:0, width: collectionViewWidth, height: itemHeight)
        self.collectionView!.center = CGPoint(x: self.view.frame.size.width/2.0, y: self.view.frame.size.height/2.0)

        self.view.backgroundColor = UIColor.whiteColor()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        //#warning Incomplete method implementation -- Return the number of sections
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //#warning Incomplete method implementation -- Return the number of items in the section
        return 1
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> HomeYearCollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("HomeYearCollectionViewCell", forIndexPath: indexPath) as! HomeYearCollectionViewCell
        
        cell.textInt = 2015
        cell.labelText = "二零一五 年"
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        let leftRightMagrin = (collectionViewWidth - itemWidth)/2
        return UIEdgeInsetsMake(0, leftRightMagrin, 0, leftRightMagrin)
    }


}
