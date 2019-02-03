//
//  HomeCollectionViewController.swift
//  Diary
//
//  Created by 周楷雯 on 2016/10/16.
//  Copyright © 2016年 kevinzhow. All rights reserved.
//

import UIKit

class HomeCollectionViewController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        let yearLayout = DiaryLayout()
        
        yearLayout.scrollDirection = UICollectionView.ScrollDirection.horizontal
        self.collectionView?.setCollectionViewLayout(yearLayout, animated: false)

        self.navigationController!.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */


    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identifier = "HomeYearCollectionViewCell"
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! HomeYearCollectionViewCell
        
        cell.textInt = 2015
        cell.labelText = "二零一五 年"
        
        return cell

    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //super.collectionView(collectionView, didSelectItemAt: indexPath as IndexPath)
        let identifier = "DiaryYearCollectionViewController"
        
        let dvc = self.storyboard?.instantiateViewController(withIdentifier: identifier) as! DiaryYearCollectionViewController // 获取 DiaryYearCollectionViewController
        
        // 指定是 2015 年的月份
        dvc.year = 2015
        
        // 页面跳转
        self.navigationController!.pushViewController(dvc, animated: true)
    }
    
}

extension HomeCollectionViewController: UINavigationControllerDelegate {
    func navigationController(_ navigationController:
        UINavigationController,
                              animationControllerFor operation:
        UINavigationController.Operation,
                              from fromVC: UIViewController,
                              to toVC: UIViewController) ->
        UIViewControllerAnimatedTransitioning? {
            
            let animator = DiaryAnimator()
            animator.operation = operation
            return animator
    }

}

