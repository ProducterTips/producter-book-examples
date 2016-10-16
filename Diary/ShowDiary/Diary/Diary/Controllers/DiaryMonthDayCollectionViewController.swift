//
//  DiaryMonthDayCollectionViewController.swift
//  Diary
//
//  Created by kevinzhow on 15/5/19.
//  Copyright (c) 2015年 kevinzhow. All rights reserved.
//

import UIKit
import CoreData

class DiaryMonthDayCollectionViewController: UICollectionViewController {
    
    var diarys = [NSManagedObject]()
    
    var month:Int!
    
    var year:Int!
    
    var yearLabel:UILabel!
    
    var composeButton:UIButton!
    
    var monthLabel:DiaryLabel!
    
    var fetchedResultsController : NSFetchedResultsController<AnyObject>!

    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        
        do {
            let fetchRequest = NSFetchRequest(entityName:"Diary")
            
            print("year = \(year) AND month = \(month)")
            
            fetchRequest.predicate = NSPredicate(format: "year = \(year) AND month = \(month)")
            fetchRequest.sortDescriptors = [NSSortDescriptor(key: "created_at", ascending: true)]
            
            fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest,
                managedObjectContext: managedContext, sectionNameKeyPath: "year",
                cacheName: nil)
            
            fetchedResultsController.delegate = self
            try fetchedResultsController.performFetch()
            
            diarys = fetchedResultsController.fetchedObjects as! [NSManagedObject]
        } catch _ {
            
        }

        print("This month have \(diarys.count) \n", terminator: "")
        
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
        
        composeButton.addTarget(self, action: #selector(DiaryMonthDayCollectionViewController.newCompose), for: UIControlEvents.touchUpInside)
        
        
        self.view.addSubview(composeButton)
        
        //
        monthLabel = DiaryLabel(fontname: "Wyue-GutiFangsong-NC", labelText: "\(numberToChineseWithUnit(month)) 月", fontSize: 16.0,lineHeight: 5.0)
        monthLabel.frame = CGRect(x: screenRect.width - 15.0 - monthLabel.frame.size.width, y: (screenRect.height - 150)/2.0, width: monthLabel.frame.size.width, height: monthLabel.frame.size.height)
        
        monthLabel.center = CGPoint(x: composeButton.center.x, y: monthLabel.center.y + 28)
        
        monthLabel.updateLabelColor(DiaryRed)
        monthLabel.isUserInteractionEnabled = true
        
        
        self.view.addSubview(monthLabel)
        
        
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let leftRightMagrin = (collectionViewWidth - itemWidth)/2
        return UIEdgeInsetsMake(0, leftRightMagrin, 0, leftRightMagrin);
    }

}

extension DiaryMonthDayCollectionViewController: UICollectionViewDelegateFlowLayout , NSFetchedResultsControllerDelegate {
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        //#warning Incomplete method implementation -- Return the number of sections
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //#warning Incomplete method implementation -- Return the number of items in the section
        return diarys.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // Configure the cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DiaryCollectionViewCell", for: indexPath) as! DiaryCollectionViewCell
        let diary = fetchedResultsController.object(at: indexPath) as! Diary
        // Configure the cell
        
        if let title = diary.title {
            cell.labelText = title
        }else{
            cell.labelText = "\(numberToChineseWithUnit((Calendar.current as NSCalendar).component(NSCalendar.Unit.day, from: diary.created_at))) 日"
        }
        
        return cell
    }

    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let dvc = self.storyboard?.instantiateViewController(withIdentifier: "DiaryViewController") as! DiaryViewController
        
        let diary = fetchedResultsController.object(at: indexPath) as! Diary
        
        dvc.diary = diary
        
        self.navigationController!.pushViewController(dvc, animated: true)
        
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        diarys = fetchedResultsController.fetchedObjects as! [NSManagedObject]
        collectionView?.collectionViewLayout.invalidateLayout()
        collectionView?.reloadData()
    }

}
