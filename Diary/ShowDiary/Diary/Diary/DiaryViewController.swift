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
        
        webview.alpha = 0.0
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "reloadWebView", name: "DiaryChangeFont", object: nil)
        
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        reloadWebView()
 
    }
    
    func reloadWebView() {
        let mainHTML = NSBundle.mainBundle().URLForResource("DiaryTemplate", withExtension:"html")
        var contents: NSString = ""
        
        do {
            contents = try NSString(contentsOfFile: mainHTML!.path!, encoding: NSUTF8StringEncoding)
        } catch let error as NSError {
            print(error)
        }
        
        let year = NSCalendar.currentCalendar().component(NSCalendarUnit.Year, fromDate: diary.created_at)
        let month = NSCalendar.currentCalendar().component(NSCalendarUnit.Month, fromDate: diary.created_at)
        let day = NSCalendar.currentCalendar().component(NSCalendarUnit.Day, fromDate: diary.created_at)
        
        let timeString = "\(numberToChinese(year))年 \(numberToChineseWithUnit(month))月 \(numberToChineseWithUnit(day))日"
        
        contents = contents.stringByReplacingOccurrencesOfString("#timeString#", withString: timeString)
        
        //WebView method
        
        let newDiaryString = diary.content.stringByReplacingOccurrencesOfString("\n", withString: "<br>", options: NSStringCompareOptions.LiteralSearch, range: nil)
        
        contents = contents.stringByReplacingOccurrencesOfString("#newDiaryString#", withString: newDiaryString)
        
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
        
        contents = contents.stringByReplacingOccurrencesOfString("#contentMargin#", withString: "\(contentMargin)")
        
        contents = contents.stringByReplacingOccurrencesOfString("#title#", withString: title)
        
        let minWidth = self.view.frame.size.width - CGFloat(contentWidthOffset)
        
        contents = contents.stringByReplacingOccurrencesOfString("#minWidth#", withString: "\(minWidth)")
        
        let fontStr = defaultFont
        
        contents = contents.stringByReplacingOccurrencesOfString("#fontStr#", withString: fontStr)
        
        let titleMarginRight:CGFloat = 15
        
        contents = contents.stringByReplacingOccurrencesOfString("#titleMarginRight#", withString: "\(titleMarginRight)")
        
        if let location = diary.location {
            contents = contents.stringByReplacingOccurrencesOfString("#location#", withString: location)
        } else {
            contents = contents.stringByReplacingOccurrencesOfString("#location#", withString: "")
        }
        
        
        webview.loadHTMLString(contents as String, baseURL: nil)
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
