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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
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
        let year = (Calendar.current as NSCalendar).component(NSCalendar.Unit.year, from: diary.created_at as! Date)
        
        // 生成月的整数类型
        let month = (Calendar.current as NSCalendar).component(NSCalendar.Unit.month, from: diary.created_at as! Date)
        
        // 生成日的整数类型
        let day = (Calendar.current as NSCalendar).component(NSCalendar.Unit.day, from: diary.created_at as! Date)
        
        let timeString = "\(numberToChinese(year))年 \(numberToChineseWithUnit(month))月 \(numberToChineseWithUnit(day))日"
        
        // 替换字符串
        contents = contents.replacingOccurrences(of: "#timeString#", with: timeString) as NSString
        
        //WebView method
        
        let newDiaryString = diary.content?.replacingOccurrences(of: "\n", with: "<br>", options: NSString.CompareOptions.literal, range: nil)
        
        contents = contents.replacingOccurrences(of: "#newDiaryString#", with: newDiaryString!) as NSString
        
        var title = ""
        var contentWidthOffset = 140
        var contentMargin:CGFloat = 10
        
        if let titleStr = diary?.title {
            let parsedTime = "\(numberToChineseWithUnit((Calendar.current as NSCalendar).component(NSCalendar.Unit.day, from: diary.created_at as! Date))) 日"
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
        
    }
    
}
