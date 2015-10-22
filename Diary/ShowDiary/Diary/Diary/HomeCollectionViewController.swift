//
//  HomeCollectionViewController.swift
//  Diary
//
//  Created by kevinzhow on 15/5/19.
//  Copyright (c) 2015年 kevinzhow. All rights reserved.
//

import UIKit
import CoreData

let itemHeight:CGFloat = 150.0 // Cell 的高度
let itemWidth:CGFloat = 60 // Cell 的宽度
let collectionViewWidth = itemWidth * 3 //同时显示三个 Cell 时候

class HomeCollectionViewController: UICollectionViewController {
    
    var diarys = [NSManagedObject]()
    
    var fetchedResultsController : NSFetchedResultsController!
    
    var yearsCount: Int = 1
    
    var sectionsCount: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            let fetchRequest = NSFetchRequest(entityName:"Diary")
            
            fetchRequest.sortDescriptors = [NSSortDescriptor(key: "created_at", ascending: true)]
            
            fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest,
                managedObjectContext: managedContext, sectionNameKeyPath: "year",
                cacheName: nil)
            
            try self.fetchedResultsController.performFetch()
            
            if (fetchedResultsController.fetchedObjects!.count == 0){
                print("Present empty year")
            }else{
                
                if let sectionsCount = fetchedResultsController.sections?.count {
                    
                    yearsCount = sectionsCount
                    diarys = fetchedResultsController.fetchedObjects as! [NSManagedObject]
                    
                }else {
                    sectionsCount = 0
                    yearsCount = 1
                }
            }
            
        } catch _ {
            
        }
        
        let yearLayout = DiaryLayout()
        
        yearLayout.scrollDirection = UICollectionViewScrollDirection.Horizontal
        self.collectionView?.setCollectionViewLayout(yearLayout, animated: false)
        
        self.collectionView!.frame = CGRect(x:0, y:0, width: collectionViewWidth, height: itemHeight)
        self.collectionView!.center = CGPoint(x: self.view.frame.size.width/2.0, y: self.view.frame.size.height/2.0)

        self.view.backgroundColor = UIColor.whiteColor()
        
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
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        //#warning Incomplete method implementation -- Return the number of sections
        return 1
    }
    
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return yearsCount
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> HomeYearCollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("HomeYearCollectionViewCell", forIndexPath: indexPath) as! HomeYearCollectionViewCell
        
        let components = NSCalendar.currentCalendar().component(NSCalendarUnit.Year, fromDate: NSDate())
        var year = components
        if sectionsCount > 0 {
            let sectionInfo = fetchedResultsController.sections![indexPath.row]
            print("Section info \(sectionInfo.name)")
            year = Int(sectionInfo.name)!
        }
        
        cell.textInt = year
        cell.labelText = "\(numberToChinese(cell.textInt)) 年"
        
        // Configure the cell
        
        return cell
    }
    

    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        let leftRightMagrin = (collectionViewWidth - itemWidth)/2
        return UIEdgeInsetsMake(0, leftRightMagrin, 0, leftRightMagrin);
    }

    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let dvc = self.storyboard?.instantiateViewControllerWithIdentifier("DiaryYearCollectionViewController") as! DiaryYearCollectionViewController
        
        
        let components = NSCalendar.currentCalendar().component(NSCalendarUnit.Year, fromDate: NSDate())
        var year = components
        if sectionsCount > 0 {
            let sectionInfo = fetchedResultsController.sections![indexPath.row]
            print("Section info \(sectionInfo.name)")
            year = Int(sectionInfo.name)!
        }
        dvc.year = year
        
        self.navigationController!.pushViewController(dvc, animated: true)
        
    }
}

extension HomeCollectionViewController: UINavigationControllerDelegate {
    func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        let animator = DiaryAnimator()
        animator.operation = operation
        return animator
        
    }
}
