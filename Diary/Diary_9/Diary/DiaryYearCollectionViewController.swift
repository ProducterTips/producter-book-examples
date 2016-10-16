//
//  DiaryYearCollectionViewController.swift
//  Diary
//
//  Created by 周楷雯 on 2016/10/16.
//  Copyright © 2016年 kevinzhow. All rights reserved.
//

import UIKit
import CoreData

class DiaryYearCollectionViewController: UICollectionViewController {
    var year: Int!
    var diarys = [Diary]()
    var fetchedResultsController : NSFetchedResultsController<Diary>!
    var monthCount: Int = 1
    var sectionsCount: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let layout = DiaryLayout()
        
        layout.scrollDirection = UICollectionViewScrollDirection.horizontal
        self.collectionView?.setCollectionViewLayout(layout, animated: false)
        
        do {
            // 新建查询
            let fetchRequest = NSFetchRequest<Diary>(entityName:"Diary")
            
            // 增加过滤条件
            fetchRequest.predicate = NSPredicate(format:"year = \(year!)")
            
            // 排序方式
            fetchRequest.sortDescriptors = [NSSortDescriptor(key: "created_at", ascending: true)]
            
            fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                                  managedObjectContext: managedContext, sectionNameKeyPath: "month",
                                                                  cacheName: nil)
            
            // 尝试查询
            try self.fetchedResultsController.performFetch()
            
            if (fetchedResultsController.fetchedObjects!.count == 0){
                print("没有存储结果")
            }else{
                
                if let sectionsCount = fetchedResultsController.sections?.count {
                    
                    monthCount = sectionsCount
                    diarys = fetchedResultsController.fetchedObjects!
                    
                }else {
                    sectionsCount = 0
                    monthCount = 1
                }
            }
            
        } catch let error as NSError {
            NSLog("发现错误 \(error.localizedDescription)")
        }

    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return monthCount
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identifier = "DiaryCell"
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! DiaryCell
        
        // 获取当前月份
        let components = Calendar.current.component(Calendar.Component.month, from: Date())
        var month = components
        
        if sectionsCount > 0 {
            // 如果程序内有保存的日记，就使用保存的日记的月份
            let sectionInfo = fetchedResultsController.sections![indexPath.section]
            print("分组信息 \(sectionInfo.name)")
            month = Int(sectionInfo.name)!
        }
        
        cell.textInt = month
        cell.labelText = "\(numberToChinese(cell.textInt)) 月"
        
        // Configure the cell
        
        return cell

    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //super.collectionView(collectionView, didSelectItemAt: indexPath as IndexPath)
        let identifier = "DiaryMonthCollectionViewController"
        
        let dvc = self.storyboard?.instantiateViewController(withIdentifier: identifier) as! DiaryMonthCollectionViewController // 获取 DiaryMonthCollectionViewController
        
        // 获取当前月份
        let components = Calendar.current.component(Calendar.Component.month, from: Date())
        var month = components
        
        if sectionsCount > 0 {
            // 如果程序内有保存的日记，就使用保存的日记的月份
            let sectionInfo = fetchedResultsController.sections![indexPath.section]
            print("分组信息 \(sectionInfo.name)")
            month = Int(sectionInfo.name)!
        }
        // 指定是 2015 年的 1 月份
        dvc.month = month
        dvc.year = year
        
        // 页面跳转
        self.navigationController!.pushViewController(dvc, animated: true)
    }
    
}
