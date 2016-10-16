//
//  Diary.swift
//  Diary
//
//  Created by kevinzhow on 15/5/19.
//  Copyright (c) 2015年 kevinzhow. All rights reserved.
//

import Foundation
import CoreData

@objc(Diary)

class Diary: NSManagedObject {

    @NSManaged var content: String
    @NSManaged var created_at: Date
    @NSManaged var location: String?
    @NSManaged var month: NSNumber
    @NSManaged var title: String?
    @NSManaged var year: NSNumber

}
