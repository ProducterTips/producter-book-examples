//
//  HomeCollectionViewController.swift
//  Diary
//
//  Created by 周楷雯 on 2016/10/16.
//  Copyright © 2016年 kevinzhow. All rights reserved.
//

import UIKit
import CoreData

class HomeCollectionViewController: UICollectionViewController {
    var diarys = [Diary]()
    var fetchedResultsController : NSFetchedResultsController<Diary>!
    var yearsCount: Int = 1
    var sectionsCount: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let yearLayout = DiaryLayout()
        
        yearLayout.scrollDirection = UICollectionView.ScrollDirection.horizontal
        self.collectionView?.setCollectionViewLayout(yearLayout, animated: false)
        
        self.navigationController!.delegate = self
        
        do {
            // 新建查询
            let fetchRequest = NSFetchRequest<Diary>(entityName:"Diary")
            
            // 排序方式
            fetchRequest.sortDescriptors = [NSSortDescriptor(key: "created_at", ascending: true)]
            
            fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                                  managedObjectContext: managedContext, sectionNameKeyPath: "year",
                                                                  cacheName: nil)
            
            // 尝试查询
            try self.fetchedResultsController.performFetch()
            
            if (fetchedResultsController.fetchedObjects!.count == 0){
                print("没有存储结果")
            }else{
                
                if let sectionsCount = fetchedResultsController.sections?.count {
                    
                    yearsCount = sectionsCount
                    diarys = fetchedResultsController.fetchedObjects!
                    
                }else {
                    sectionsCount = 0
                    yearsCount = 1
                }
            }
            
        } catch let error as NSError {
            NSLog("发现错误 \(error.localizedDescription)")
        }
    }
    
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return yearsCount
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identifier = "HomeYearCollectionViewCell"
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! HomeYearCollectionViewCell
        
        // 获取当前月份
        let components = Calendar.current.component(Calendar.Component.year, from: Date())
        var year = components
        
        if sectionsCount > 0 {
            // 如果程序内有保存的日记，就使用保存的日记的年份
            let sectionInfo = fetchedResultsController.sections![indexPath.section]
            print("分组信息 \(sectionInfo.name)")
            year = Int(sectionInfo.name)!
        }
        
        cell.textInt = year
        cell.labelText = "\(numberToChinese(cell.textInt)) 年"
        
        // Configure the cell
        
        return cell
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //super.collectionView(collectionView, didSelectItemAt: indexPath as IndexPath)
        let identifier = "DiaryYearCollectionViewController"
        
        let dvc = self.storyboard?.instantiateViewController(withIdentifier: identifier) as! DiaryYearCollectionViewController // 获取 DiaryYearCollectionViewController
        
        let components = Calendar.current.component(Calendar.Component.year, from: Date())
        var year = components
        if sectionsCount > 0 {
            let sectionInfo = fetchedResultsController.sections![(indexPath as NSIndexPath).row]
            print("Section info \(sectionInfo.name)")
            year = Int(sectionInfo.name)!
        }
        
        dvc.year = year
        
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

