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
    
    var fetchedResultsController : NSFetchedResultsController<AnyObject>!
    
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
        var yearLayout = DiaryLayout()
        
        yearLayout.scrollDirection = UICollectionViewScrollDirection.horizontal
        self.collectionView?.setCollectionViewLayout(yearLayout, animated: false)
        
        self.collectionView!.frame = CGRect(x:0, y:0, width: collectionViewWidth, height: itemHeight)
        self.collectionView!.center = CGPoint(x: self.view.frame.size.width/2.0, y: self.view.frame.size.height/2.0)

        self.view.backgroundColor = UIColor.white
        
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
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        //#warning Incomplete method implementation -- Return the number of sections
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return yearsCount
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> HomeYearCollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeYearCollectionViewCell", for: indexPath) as! HomeYearCollectionViewCell
        
        var components = (Calendar.current as NSCalendar).component(NSCalendar.Unit.year, from: Date())
        var year = components
        if sectionsCount > 0 {
            if let sectionInfo = fetchedResultsController.sections![(indexPath as NSIndexPath).row] as? NSFetchedResultsSectionInfo {
                print("Section info \(sectionInfo.name)")
                year = Int(sectionInfo.name)!
            }
        }
        
        cell.textInt = year
        cell.labelText = "\(numberToChinese(cell.textInt)) 年"
        
        // Configure the cell
        
        return cell
    }
    

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        let leftRightMagrin = (collectionViewWidth - itemWidth)/2
        return UIEdgeInsetsMake(0, leftRightMagrin, 0, leftRightMagrin);
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        var dvc = self.storyboard?.instantiateViewController(withIdentifier: "DiaryYearCollectionViewController") as! DiaryYearCollectionViewController
        
        
        var components = (Calendar.current as NSCalendar).component(NSCalendar.Unit.year, from: Date())
        var year = components
        if sectionsCount > 0 {
            if let sectionInfo = fetchedResultsController.sections![(indexPath as NSIndexPath).row] as? NSFetchedResultsSectionInfo {
                print("Section info \(sectionInfo.name)")
                year = Int(sectionInfo.name)!
            }
        }
        dvc.year = year
        
        self.navigationController!.pushViewController(dvc, animated: true)
        
    }
}

extension HomeCollectionViewController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        let animator = DiaryAnimator()
        animator.operation = operation
        return animator
        
    }
}
