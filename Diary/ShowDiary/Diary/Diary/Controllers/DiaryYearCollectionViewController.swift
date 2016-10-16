//
//  DiaryYearCollectionViewController.swift
//  Diary
//
//  Created by kevinzhow on 15/5/19.
//  Copyright (c) 2015年 kevinzhow. All rights reserved.
//

import UIKit
import CoreData

class DiaryYearCollectionViewController: UICollectionViewController {
    
    var year:Int!
    
    var yearLabel:UILabel!
    
    var diarys = [NSManagedObject]()
    
    var composeButton:UIButton!
    
    var fetchedResultsController : NSFetchedResultsController<AnyObject>!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        let fetchRequest = NSFetchRequest(entityName:"Diary")
        
        let year = 2015 // 可以先硬编码成当前年份
        let month = 9 // 当前月份
        
        do {
            let fetchedResults = try managedContext.fetch(fetchRequest) as! [NSManagedObject]
            
            fetchRequest.sortDescriptors = [NSSortDescriptor(key: "created_at", ascending: true)] // 排序方式
            
            fetchRequest.predicate = NSPredicate(format: "year = \(year) AND month = \(month)") // 查询条件
            
            fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest,
                managedObjectContext: managedContext, sectionNameKeyPath: "month",
                cacheName: nil) // 根据 Year 来分 Section
            
            try fetchedResultsController.performFetch()
            
            if (fetchedResultsController.fetchedObjects!.count == 0){
                print("Present empty year")
            }else{
                diarys = fetchedResults
            }
            
        } catch _ {
            print("Fetch Error")
        }
        // Register cell classes
        yearLabel = DiaryLabel(fontname: "TpldKhangXiDictTrial", labelText: "\(numberToChinese(year))年", fontSize: 20.0,lineHeight: 5.0)
        
        yearLabel.center = CGPoint(x: screenRect.width - yearLabel.frame.size.width/2.0 - 15, y: 20 + yearLabel.frame.size.height/2.0 )
        
        self.view.addSubview(yearLabel)
        
        yearLabel.isUserInteractionEnabled = true
        
        let mTapUpRecognizer = UITapGestureRecognizer(target: self, action: "backToHome")
        mTapUpRecognizer.numberOfTapsRequired = 1
        yearLabel.addGestureRecognizer(mTapUpRecognizer)
        
        //Add compose button
        
        composeButton = diaryButtonWith(text: "撰",  fontSize: 14.0,  width: 40.0,  normalImageName: "Oval", highlightedImageName: "Oval_pressed")
        
        composeButton.center = CGPoint(x: screenRect.width - yearLabel.frame.size.width/2.0 - 15, y: 38 + yearLabel.frame.size.height + 26.0/2.0)
        
        composeButton.addTarget(self, action: #selector(DiaryYearCollectionViewController.newCompose), for: UIControlEvents.touchUpInside)
        
        
        self.view.addSubview(composeButton)


        let yearLayout = DiaryLayout()
        
        yearLayout.scrollDirection = UICollectionViewScrollDirection.horizontal
        self.collectionView?.setCollectionViewLayout(yearLayout, animated: false)
        
        self.collectionView!.frame = CGRect(x:0, y:0, width: collectionViewWidth, height: itemHeight)
        self.collectionView!.center = CGPoint(x: self.view.frame.size.width/2.0, y: self.view.frame.size.height/2.0)
        
        self.view.backgroundColor = UIColor.white
        
        
        // Do any additional setup after loading the view.
    }
    
    func newCompose() {
        
        let composeViewController = self.storyboard?.instantiateViewController(withIdentifier: "DiaryComposeViewController") as! DiaryComposeViewController
        
        self.present(composeViewController, animated: true, completion: nil)
        
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let dvc = self.storyboard?.instantiateViewController(withIdentifier: "DiaryMonthDayCollectionViewController") as! DiaryMonthDayCollectionViewController
        
        if fetchedResultsController.sections?.count == 0 {
            dvc.month = (Calendar.current as NSCalendar).component(NSCalendar.Unit.month, from: Date())
        }else{
            let sectionInfo = fetchedResultsController.sections![(indexPath as NSIndexPath).row] 
            let month = Int(sectionInfo.name)
            dvc.month = month!
        }
        dvc.year = year
        
        //        dvc.collectionView?.dataSource = collectionView.dataSource
        
        self.navigationController!.pushViewController(dvc, animated: true)
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        let leftRightMagrin = (collectionViewWidth - itemWidth)/2
        return UIEdgeInsetsMake(0, leftRightMagrin, 0, leftRightMagrin);
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        //#warning Incomplete method implementation -- Return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //#warning Incomplete method implementation -- Return the number of items in the section
        if fetchedResultsController.sections!.count == 0 {
            return 1
        }else{
            return fetchedResultsController.sections!.count
        }
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DiaryCollectionViewCell", for: indexPath) as! DiaryCollectionViewCell
        if fetchedResultsController.sections?.count == 0 {
            
            cell.labelText = "\(numberToChineseWithUnit((Calendar.current as NSCalendar).component(NSCalendar.Unit.month, from: Date()))) 月"
            
        }else{
            
            let sectionInfo = fetchedResultsController.sections![(indexPath as NSIndexPath).row] 
            let month = Int(sectionInfo.name)
            cell.labelText = "\(numberToChineseWithUnit(month!)) 月"
        }
    
        return cell
    }

}

