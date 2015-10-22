//
//  DiaryViewController.swift
//  Diary
//
//  Created by kevinzhow on 15/3/6.
//  Copyright (c) 2015年 kevinzhow. All rights reserved.
//

import UIKit

class DiaryViewController: UIViewController,UIGestureRecognizerDelegate, UIWebViewDelegate, UIScrollViewDelegate{
    
    var diary:Diary!
    
    var webview: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        
        setupUI()
        // Do any additional setup after loading the view.
    }
    
    func setupUI() {
        webview = UIWebView(frame: CGRectMake(0,0, self.view.frame.size.width, self.view.frame.size.height))
        
        webview.scrollView.bounces = true
        
        webview.delegate = self
        webview.backgroundColor = UIColor.whiteColor()
        webview.scrollView.delegate = self
        
        self.view.addSubview(self.webview)
        
        let mDoubleUpRecognizer = UITapGestureRecognizer(target: self, action: "hideDiary")
        mDoubleUpRecognizer.delegate = self
        mDoubleUpRecognizer.numberOfTapsRequired = 2
        self.webview.addGestureRecognizer(mDoubleUpRecognizer)
        
        let mTapUpRecognizer = UITapGestureRecognizer(target: self, action: "showButtons")
        mTapUpRecognizer.delegate = self
        mTapUpRecognizer.numberOfTapsRequired = 1
        self.webview.addGestureRecognizer(mTapUpRecognizer)
        mTapUpRecognizer.requireGestureRecognizerToFail(mDoubleUpRecognizer)
        
        webview.alpha = 0.0
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "reloadWebView", name: "DiaryChangeFont", object: nil)
        
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        reloadWebView()
 
    }
    
    func reloadWebView() {
        let timeString = "\(numberToChinese(NSCalendar.currentCalendar().component(NSCalendarUnit.Year, fromDate: diary.created_at)))年 \(numberToChineseWithUnit(NSCalendar.currentCalendar().component(NSCalendarUnit.Month, fromDate: diary.created_at)))月 \(numberToChineseWithUnit(NSCalendar.currentCalendar().component(NSCalendarUnit.Day, fromDate: diary.created_at)))日"
        
        //WebView method
        
        let newDiaryString = diary.content.stringByReplacingOccurrencesOfString("\n", withString: "<br>", options: NSStringCompareOptions.LiteralSearch, range: nil)
        
        var title = ""
        var contentWidthOffset = 140
        var contentMargin:CGFloat = 10
        
        if let titleStr = diary?.title {
            let parsedTime = "\(numberToChineseWithUnit(NSCalendar.currentCalendar().component(NSCalendarUnit.Day, fromDate: diary.created_at))) 日"
            if titleStr != parsedTime {
                title = titleStr
                contentWidthOffset = 205
                contentMargin = 10
                title = "<div class='title'>\(title)</div>"
            }
        }
        
        let minWidth = self.view.frame.size.width - CGFloat(contentWidthOffset)
        
        let fontStr = defaultFont
        
        let bodyPadding = 0
        
        let containerCSS = " padding:25px 10px 25px 25px; "

        
        let titleMarginRight:CGFloat = 15

        
        let headertags = "<!DOCTYPE html><html><meta charset='utf-8'><head><title></title><style>"
        let bodyCSS = "body{padding:\(bodyPadding)px;} "
        let allCSS = "* {-webkit-text-size-adjust: 100%; margin:0; font-family: '\(fontStr)'; -webkit-writing-mode: vertical-rl; letter-spacing: 3px;}"
        let contentCSS = ".content { min-width: \(minWidth)px; margin-right: \(contentMargin)px;} .content p{ font-size: 12pt; line-height: 24pt;}"
        let titleCSS = ".title {font-size: 12pt; font-weight:bold; line-height: 24pt; margin-right: \(titleMarginRight)px; padding-left: 20px;} "
        let extraCSS = ".extra{ font-size:12pt; line-height: 24pt; margin-right:30px; }"
        let stampCSS = ".stamp {width:24px; height:auto; position:fixed; bottom:20px;}"
        
        
        let extraHTML = "<div class='extra'>\(diary.location)<br>\(timeString) </div>"
        let contentHTML = "<div class='container'>\(title)<div class='content'><p>\(newDiaryString)</p></div>"
        
        webview.loadHTMLString("\(headertags)\(bodyCSS) \(allCSS) \(contentCSS) \(titleCSS) \(extraCSS) .container { \(containerCSS) } \(stampCSS) </style></head> <body> \(contentHTML) \(extraHTML)</body></html>", baseURL: nil)
    }
    

    func webViewDidFinishLoad(webView: UIWebView) {
        UIView.animateWithDuration(1.0, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations:
        {
            self.webview.alpha = 1.0
        }, completion: nil)

        webview.scrollView.contentOffset = CGPointMake(webview.scrollView.contentSize.width - webview.frame.size.width, 0)
    }
    
    func hideDiary() {

        self.navigationController?.popViewControllerAnimated(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailByGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        
        return true
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if (scrollView.contentOffset.y < -80){
            hideDiary()
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
