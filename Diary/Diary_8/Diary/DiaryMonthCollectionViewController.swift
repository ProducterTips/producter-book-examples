//
//  DiaryMonthCollectionViewController.swift
//  Diary
//
//  Created by 周楷雯 on 2016/10/16.
//  Copyright © 2016年 kevinzhow. All rights reserved.
//

import UIKit
import CoreData

let DiaryRed = UIColor(red: 192.0/255.0, green: 23/255.0, blue: 48.0/255.0, alpha: 1)

class DiaryMonthCollectionViewController: UICollectionViewController {
    var year: Int!
    var month: Int!
    var yearLabel: DiaryLabel!
    var monthLabel: DiaryLabel!
    var fetchedResultsController : NSFetchedResultsController<Diary>!
    var diarys = [Diary]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = DiaryLayout()
        
        layout.scrollDirection = UICollectionView.ScrollDirection.horizontal
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
                                for: UIControl.Event.touchUpInside)
        
        self.view.addSubview(composeButton)
        
        // 查询数据
        
        do {
            // 新建查询
            let fetchRequest = NSFetchRequest<Diary>(entityName:"Diary")
            
            // 增加过滤条件
            fetchRequest.predicate = NSPredicate(format:"year = \(year!) AND month = \(month!)")
            
            // 排序方式
            fetchRequest.sortDescriptors = [NSSortDescriptor(key: "created_at", ascending: true)]
            
            fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                                  managedObjectContext: managedContext, sectionNameKeyPath: nil,
                                                                  cacheName: nil)
            
            // 尝试查询
            try self.fetchedResultsController.performFetch()
            
            if (fetchedResultsController.fetchedObjects!.count == 0){
                print("没有存储结果")
            }else{
                diarys = fetchedResultsController.fetchedObjects!
            }
            
        } catch let error as NSError {
            NSLog("发现错误 \(error.localizedDescription)")
        }
    
    }
    
    @objc func newCompose() {
        
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
        return diarys.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identifier = "DiaryCell"
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! DiaryCell
        
        let diary = diarys[indexPath.row]
        
        cell.labelText = diary.title!
        
        return cell
    }
    
}
