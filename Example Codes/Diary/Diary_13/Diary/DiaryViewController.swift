//
//  DiaryViewController.swift
//  Diary
//
//  Created by kevinzhow on 2016/10/16.
//  Copyright © 2016年 kevinzhow. All rights reserved.
//

import UIKit

class DiaryViewController: UIViewController {
    var diary:Diary!
    
    var webview: UIWebView!
    
    var saveButton:UIButton!
    
    var deleteButton:UIButton!
    
    var editButton:UIButton!
    
    var buttonsView:UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        showButtons()
        
    }
    
    func setupUI() {
        webview = UIWebView(frame: CGRect(x: 0,y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        
        webview.scrollView.bounces = true
        
        webview.backgroundColor = UIColor.white
        
        self.view.addSubview(self.webview)
        
        // 读取模板的内容
        let mainHTML = Bundle.main.url(forResource: "DiaryTemplate", withExtension:"html")
        var contents: NSString = ""
        
        do {
            contents = try NSString(contentsOfFile: mainHTML!.path, encoding: String.Encoding.utf8.rawValue)
        } catch let error as NSError {
            print(error)
        }
        
        // 生成年的整数类型
        let year = (Calendar.current as NSCalendar).component(NSCalendar.Unit.year, from: diary.created_at!)
        
        // 生成月的整数类型
        let month = (Calendar.current as NSCalendar).component(NSCalendar.Unit.month, from: diary.created_at!)
        
        // 生成日的整数类型
        let day = (Calendar.current as NSCalendar).component(NSCalendar.Unit.day, from: diary.created_at!)
        
        let timeString = "\(numberToChinese(year))年 \(numberToChineseWithUnit(month))月 \(numberToChineseWithUnit(day))日"
        
        // 替换字符串
        contents = contents.replacingOccurrences(of: "#timeString#", with: timeString) as NSString
        
        let newDiaryString = diary.content?.replacingOccurrences(of: "\n", with: "<br>", options: NSString.CompareOptions.literal, range: nil)
        
        contents = contents.replacingOccurrences(of: "#newDiaryString#", with: newDiaryString!) as NSString
        
        var title = ""
        var contentWidthOffset = 140
        var contentMargin:CGFloat = 10
        
        if let titleStr = diary?.title {
            let parsedTime = "\(numberToChineseWithUnit((Calendar.current as NSCalendar).component(NSCalendar.Unit.day, from: diary.created_at!))) 日"
            if titleStr != parsedTime {
                title = titleStr
                contentWidthOffset = 205
                contentMargin = 10
                title = "<div class='title'>\(title)</div>"
            }
        }
        
        contents = contents.replacingOccurrences(of: "#contentMargin#", with: "\(contentMargin)") as NSString
        
        contents = contents.replacingOccurrences(of: "#title#", with: title) as NSString
        
        let minWidth = self.view.frame.size.width - CGFloat(contentWidthOffset)
        
        contents = contents.replacingOccurrences(of: "#minWidth#", with: "\(minWidth)") as NSString
        
        let fontStr = defaultFont
        
        contents = contents.replacingOccurrences(of: "#fontStr#", with: fontStr) as NSString
        
        let titleMarginRight:CGFloat = 15
        
        contents = contents.replacingOccurrences(of: "#titleMarginRight#", with: "\(titleMarginRight)") as NSString
        
        if let location = diary.location {
            contents = contents.replacingOccurrences(of: "#location#", with: location) as NSString
        } else {
            contents = contents.replacingOccurrences(of: "#location#", with: "") as NSString
        }
        
        
        webview.loadHTMLString(contents as String, baseURL: nil)
        
        // 添加存改删按钮
        
        buttonsView = UIView(frame: CGRect(x: 0, y: screenSize.height, width: screenSize.width, height: 80.0))
        buttonsView.backgroundColor = UIColor.clear
        buttonsView.alpha = 0.0
        
        let buttonFontSize:CGFloat = 18.0
        
        saveButton = diaryButtonWith(text: "存",  fontSize: buttonFontSize,  width: 50.0,  normalImageName: "Oval", highlightedImageName: "Oval_pressed")
        
        saveButton.center = CGPoint(x: buttonsView.frame.width/2.0, y: buttonsView.frame.height/2.0)
        
        saveButton.addTarget(self, action: #selector(saveToRoll), for: UIControl.Event.touchUpInside)
        
        buttonsView.addSubview(saveButton)
        
        
        editButton = diaryButtonWith(text: "改",  fontSize: buttonFontSize,  width: 50.0,  normalImageName: "Oval", highlightedImageName: "Oval_pressed")
        
        editButton.center = CGPoint(x: saveButton.center.x - 56.0, y: saveButton.center.y)
        
        editButton.addTarget(self, action: #selector(editDiary), for: UIControl.Event.touchUpInside)
        
        buttonsView.addSubview(editButton)
        
        deleteButton = diaryButtonWith(text: "刪",  fontSize: buttonFontSize,  width: 50.0,  normalImageName: "Oval", highlightedImageName: "Oval_pressed")
        
        deleteButton.center = CGPoint(x: saveButton.center.x + 56.0, y: saveButton.center.y)
        
        deleteButton.addTarget(self, action: #selector(deleteThisDiary), for: UIControl.Event.touchUpInside)
        
        buttonsView.addSubview(deleteButton)
        
        self.view.addSubview(buttonsView)
        
        // 切换按钮的显示状态
        let mTapUpRecognizer = UITapGestureRecognizer(target: self, action: #selector(showButtons))
        mTapUpRecognizer.numberOfTapsRequired = 1
        mTapUpRecognizer.delegate = self
        self.webview.addGestureRecognizer(mTapUpRecognizer)
        
        
    }
    
    @objc func showButtons() {
        
        if(buttonsView.alpha == 0.0) {
            UIView.animate(withDuration: 0.2, delay: 0, options: UIView.AnimationOptions(), animations:
                {
                    self.buttonsView.center = CGPoint(x: self.buttonsView.center.x, y: screenSize.height - self.buttonsView.frame.size.height/2.0)
                    self.buttonsView.alpha = 1.0
                    
            }, completion: nil)
            
        }else{
            
            UIView.animate(withDuration: 0.1, delay: 0, options: UIView.AnimationOptions(), animations:
                {
                    self.buttonsView.center = CGPoint(x: self.buttonsView.center.x, y: screenSize.height + self.buttonsView.frame.size.height/2.0)
                    self.buttonsView.alpha = 0.0
            }, completion: nil)
            
        }
    }
    
    @objc func editDiary() {
        let composeViewController = self.storyboard?.instantiateViewController(withIdentifier: "DiaryComposeViewController") as! DiaryComposeViewController
        
        if let diary = diary {
            
            composeViewController.diary = diary
        }
        
        self.present(composeViewController, animated: true, completion: nil)
    }
    
    @objc func saveToRoll() {
        
        let offset = self.webview.scrollView.contentOffset.x
        
        // 针对 WebView 截图
        let image =  webview.captureView()
        
        self.webview.scrollView.contentOffset.x = offset
        
        // 创建分享对象
        var sharingItems = [AnyObject]()
        
        // 给分享对象插入图片
        sharingItems.append(image)
        
        // 初始化分享组件
        let activityViewController = UIActivityViewController(activityItems: sharingItems, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.saveButton
        
        // 现实分享组件
        self.present(activityViewController, animated: true, completion: nil)
        
    }
    
    
    @objc func deleteThisDiary() {
        managedContext.delete(diary)
        do {
            try managedContext.save()
        } catch _ {
        }
        hideDiary()
    }
    
    func hideDiary() {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension DiaryViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        
        return true
    }
}
