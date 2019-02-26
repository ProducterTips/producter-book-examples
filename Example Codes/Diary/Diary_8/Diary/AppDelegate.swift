//
//  AppDelegate.swift
//  Diary
//
//  Created by 周楷雯 on 2016/10/16.
//  Copyright © 2016年 kevinzhow. All rights reserved.
//

import UIKit
import CoreData

// Coredata
let appDelegate = UIApplication.shared.delegate as! AppDelegate

let managedContext = appDelegate.managedObjectContext!

let itemHeight: CGFloat = 150.0
// Cell的高度

let itemWidth: CGFloat = 60
// Cell的宽度

let collectionViewWidth = itemWidth * 3
// 同时显示3个Cell时候


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    lazy var managedObjectModel: NSManagedObjectModel = {
        // 描述数据模型描述文件存储位置
        let modelURL = Bundle.main.url(forResource: "Diary", withExtension: "momd")!
        return NSManagedObjectModel(contentsOf: modelURL)!
    }()
    
    lazy var applicationDocumentsDirectory: URL = {
        // 数据库文件的存放文件夹
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return urls[urls.count-1]
    }()

    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator? = {
            // 通过 managedObjectModel 创建持久化管理
            var coordinator: NSPersistentStoreCoordinator? =
                NSPersistentStoreCoordinator(managedObjectModel:
                    self.managedObjectModel)
            
            let url = self.applicationDocumentsDirectory.appendingPathComponent("Diary.sqlite")
            // 设定数据库存储位置
            
            var error: NSError? = nil
            var failureReason = "载入程序存储的数据出错."
            
            do {
                try coordinator!.addPersistentStore(
                    ofType: NSSQLiteStoreType, configurationName: nil,
                    at: url, options: nil)
                // 创建NSSQLiteStoreType类型持久化存储
            } catch var error1 as NSError {
                error = error1
                coordinator = nil
                // 报告错误
                var dict = [String: AnyObject]()
                dict[NSLocalizedDescriptionKey] = "无法初始化程序存储的数据" as AnyObject?
                dict[NSLocalizedFailureReasonErrorKey] = failureReason as AnyObject?
                dict[NSUnderlyingErrorKey] = error
                error = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
                NSLog("发现错误 \(error), \(error!.userInfo)")
                abort()
            } catch {
                fatalError()
            }
            
            return coordinator
    }()
    
    lazy var managedObjectContext: NSManagedObjectContext? = {
        let coordinator = self.persistentStoreCoordinator
        if coordinator == nil {
            return nil
        }
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()


}

