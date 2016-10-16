//
//  DiaryComposeViewController.swift
//  Diary
//
//  Created by 周楷雯 on 2016/10/16.
//  Copyright © 2016年 kevinzhow. All rights reserved.
//

import UIKit
import CoreData

let titleTextViewHeight:CGFloat = 30.0
let contentMargin:CGFloat = 20.0

var defaultFont = "Wyue-GutiFangsong-NC"
let DiaryFont = UIFont(name: defaultFont, size: 18) as UIFont!
let DiaryLocationFont = UIFont(name: defaultFont, size: 16) as UIFont!
let DiaryTitleFont = UIFont(name: defaultFont, size: 18) as UIFont!

class DiaryComposeViewController: UIViewController {
    var composeView:UITextView!
    var locationTextView:UITextView!
    var titleTextView:UITextView!
    var finishButton:UIButton!
    var keyboardSize:CGSize = CGSize(width: 0, height: 0)
    var locationHelper: DiaryLocationHelper = DiaryLocationHelper()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 创建正文输入框
        composeView = UITextView(frame: CGRect(x: 0, y: contentMargin + titleTextViewHeight, width: screenSize.width, height: screenSize.height))
        composeView.font = DiaryFont
        composeView.isEditable = true
        composeView.isUserInteractionEnabled = true
        composeView.textContainerInset = UIEdgeInsetsMake(contentMargin, contentMargin, contentMargin, contentMargin)
        composeView.text = "没道理，是一枚太平洋的暖湿空气，飘"
        
        // 创建地址输入框
        locationTextView = UITextView(frame: CGRect(x: 0, y: composeView.frame.size.height - 30.0, width: screenSize.width - 60.0, height: 30.0))
        locationTextView.font = DiaryLocationFont
        locationTextView.isEditable = true
        locationTextView.isUserInteractionEnabled = true
        locationTextView.bounces = false
        locationTextView.text = "于 琅邪"
        
        // 创建标题输入框
        
        titleTextView = UITextView(frame: CGRect(x: contentMargin, y: contentMargin/2, width: screenSize.width - 60.0, height: titleTextViewHeight))
        titleTextView.font = DiaryTitleFont
        titleTextView.isEditable = true
        titleTextView.isUserInteractionEnabled = true
        titleTextView.bounces = false
        titleTextView.text = "一十五日"

        self.view.addSubview(composeView)
        
        self.view.addSubview(locationTextView)
        
        self.view.addSubview(titleTextView)
        
        // 创建完成按钮
        finishButton = diaryButtonWith(text: "完",  fontSize: 18.0,  width: 50.0,  normalImageName: "Oval", highlightedImageName: "Oval_pressed")
        
        finishButton.center = CGPoint(x: screenSize.width - 20, y: screenSize.height - 30)
        
        self.view.addSubview(finishButton)
        
        
        self.finishButton.center = CGPoint(x: self.view.frame.width - self.finishButton.frame.size.height/2.0 - 10, y: self.view.frame.height  - self.finishButton.frame.size.height/2.0 - 10)
        
        self.finishButton.addTarget(self, action: #selector(finishCompose(_:)), for: UIControlEvents.touchUpInside)
        
        self.locationTextView.center = CGPoint(x: self.locationTextView.frame.size.width/2.0 + 20.0, y: self.finishButton.center.y)
        
        // 监听键盘事件
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow(_:)), name: NSNotification.Name.UIKeyboardDidShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateAddress(_:)), name: NSNotification.Name(rawValue: "DiaryLocationUpdated"), object: nil)

    }
    
    func finishCompose(_ button: UIButton) {
        
        // 取消输入框的编辑状态，收起键盘
        self.composeView.endEditing(true)
        self.locationTextView.endEditing(true)
        
        // 确保有文字内容才保存
        if (composeView.text.lengthOfBytes(using: String.Encoding.utf8) > 1){
            
            let entity =  NSEntityDescription.entity(forEntityName: "Diary", in: managedContext)
            
            let newdiary = Diary(entity: entity!,
                                 insertInto:managedContext)
            newdiary.content = composeView.text
            
            if let address  = locationHelper.address {
                newdiary.location = address
            }
            
            if let title = titleTextView.text {
                newdiary.title = title
            }
            
            
            newdiary.updateTimeWithDate(Date())
            
            var error: NSError?
            do {
                try managedContext.save()
            } catch let error1 as NSError {
                error = error1
                print("保存错误 \(error), \(error?.userInfo)")
            }
            
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func updateAddress(_ notification: Notification) {
        
        if let address = notification.object as? String {
            
            locationTextView.text = "于 \(address)"
            
            locationHelper.locationManager.stopUpdatingLocation()
        }
        
    }
    
    func keyboardDidShow(_ notification: Notification) {
        // 取出键盘的高度
        if let rectValue = (notification as NSNotification).userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue {
            keyboardSize = rectValue.cgRectValue.size
            
            //更新完成按钮和地址输入框的位置
            updateTextViewSizeForKeyboardHeight(keyboardSize.height)
        }
    }
    
    func updateTextViewSizeForKeyboardHeight(_ keyboardHeight: CGFloat) {
        
        let newKeyboardHeight = keyboardHeight
        
        UIView.animate(withDuration: 1.0, delay: 0, options: UIViewAnimationOptions(), animations:
            {
                if (self.locationTextView.text == nil) {
                    self.composeView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height - newKeyboardHeight)
                }else{
                    self.composeView.frame = CGRect(x: 0, y: contentMargin + titleTextViewHeight, width: self.composeView.frame.size.width,  height: self.view.frame.height - newKeyboardHeight - 40.0 - self.finishButton.frame.size.height/2.0 - (contentMargin + titleTextViewHeight))
                }
                
                self.finishButton.center = CGPoint(x: self.view.frame.width - self.finishButton.frame.size.height/2.0 - 10, y: self.view.frame.height - newKeyboardHeight - self.finishButton.frame.size.height/2.0 - 10)
                
                
                self.locationTextView.center = CGPoint(x: self.locationTextView.frame.size.width/2.0 + 20.0, y: self.finishButton.center.y)
                
            }, completion: nil)
    }

}
