//
//  Diary+CoreDataProperties.swift
//  Diary
//
//  Created by 周楷雯 on 2016/10/16.
//  Copyright © 2016年 kevinzhow. All rights reserved.
//

import Foundation
import CoreData


extension Diary {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Diary> {
        return NSFetchRequest<Diary>(entityName: "Diary");
    }

    @NSManaged public var content: String?
    @NSManaged public var created_at: NSDate?
    @NSManaged public var location: String?
    @NSManaged public var title: String?
    @NSManaged public var month: Int32
    @NSManaged public var year: Int32
    
    func updateTimeWithDate(_ date: Date){
        self.created_at = date as NSDate?
        self.year = Int32(Calendar.current.component(Calendar.Component.year, from: date))
        self.month = Int32(Calendar.current.component(Calendar.Component.month, from: date))
    }

}
