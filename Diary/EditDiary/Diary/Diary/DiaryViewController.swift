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
    
    var saveButton:UIButton!
    
    var deleteButton:UIButton!
    
    var editButton:UIButton!
    
    var buttonsView:UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        setupUI()
        
        showButtons()
        // Do any additional setup after loading the view.
    }
    
    func setupUI() {
        webview = UIWebView(frame: CGRect(x: 0,y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        
        webview.scrollView.bounces = true
        
        webview.delegate = self
        webview.backgroundColor = UIColor.white
        webview.scrollView.delegate = self
        
        self.view.addSubview(self.webview)
        
        let mDoubleUpRecognizer = UITapGestureRecognizer(target: self, action: #selector(DiaryViewController.hideDiary))
        mDoubleUpRecognizer.delegate = self
        mDoubleUpRecognizer.numberOfTapsRequired = 2
        self.webview.addGestureRecognizer(mDoubleUpRecognizer)
        
        let mTapUpRecognizer = UITapGestureRecognizer(target: self, action: #selector(DiaryViewController.showButtons))
        mTapUpRecognizer.numberOfTapsRequired = 1
        self.webview.addGestureRecognizer(mTapUpRecognizer)
        mTapUpRecognizer.require(toFail: mDoubleUpRecognizer)
        //Add buttons
        
        buttonsView = UIView(frame: CGRect(x: 0, y: screenRect.height, width: screenRect.width, height: 80.0))
        buttonsView.backgroundColor = UIColor.clear
        buttonsView.alpha = 0.0
        
        let buttonFontSize:CGFloat = 18.0

        
        saveButton = diaryButtonWith(text: "存",  fontSize: buttonFontSize,  width: 50.0,  normalImageName: "Oval", highlightedImageName: "Oval_pressed")
        
        saveButton.center = CGPoint(x: buttonsView.frame.width/2.0, y: buttonsView.frame.height/2.0)
        
        saveButton.addTarget(self, action: #selector(DiaryViewController.saveToRoll), for: UIControlEvents.touchUpInside)
        
        buttonsView.addSubview(saveButton)
        
        
        editButton = diaryButtonWith(text: "改",  fontSize: buttonFontSize,  width: 50.0,  normalImageName: "Oval", highlightedImageName: "Oval_pressed")
        
        editButton.center = CGPoint(x: saveButton.center.x - 56.0, y: saveButton.center.y)
        
        editButton.addTarget(self, action: #selector(DiaryViewController.editDiary), for: UIControlEvents.touchUpInside)
        
        buttonsView.addSubview(editButton)
        
        deleteButton = diaryButtonWith(text: "刪",  fontSize: buttonFontSize,  width: 50.0,  normalImageName: "Oval", highlightedImageName: "Oval_pressed")
        
        deleteButton.center = CGPoint(x: saveButton.center.x + 56.0, y: saveButton.center.y)
        
        deleteButton.addTarget(self, action: #selector(DiaryViewController.deleteThisDiary), for: UIControlEvents.touchUpInside)
        
        buttonsView.addSubview(deleteButton)
        
        self.view.addSubview(buttonsView)
        
        webview.alpha = 0.0
        
        NotificationCenter.default.addObserver(self, selector: #selector(DiaryViewController.reloadWebView), name: NSNotification.Name(rawValue: "DiaryChangeFont"), object: nil)
        

    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadWebView()
 
    }
    
    func reloadWebView() {
        let mainHTML = Bundle.main.url(forResource: "DiaryTemplate", withExtension:"html")
        var contents: NSString = ""
        
        do {
            contents = try NSString(contentsOfFile: mainHTML!.path, encoding: String.Encoding.utf8.rawValue)
        } catch let error as NSError {
            print(error)
        }
        
        let year = (Calendar.current as NSCalendar).component(NSCalendar.Unit.year, from: diary.created_at as Date)
        let month = (Calendar.current as NSCalendar).component(NSCalendar.Unit.month, from: diary.created_at as Date)
        let day = (Calendar.current as NSCalendar).component(NSCalendar.Unit.day, from: diary.created_at as Date)
        
        let timeString = "\(numberToChinese(year))年 \(numberToChineseWithUnit(month))月 \(numberToChineseWithUnit(day))日"
        
        contents = contents.replacingOccurrences(of: "#timeString#", with: timeString)
        
        //WebView method
        
        let newDiaryString = diary.content.replacingOccurrences(of: "\n", with: "<br>", options: NSString.CompareOptions.literal, range: nil)
        
        contents = contents.replacingOccurrences(of: "#newDiaryString#", with: newDiaryString) as NSString
        
        var title = ""
        var contentWidthOffset = 140
        var contentMargin:CGFloat = 10
        
        if let titleStr = diary?.title {
            let parsedTime = "\(numberToChineseWithUnit((Calendar.current as NSCalendar).component(NSCalendar.Unit.day, from: diary.created_at))) 日"
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
    
    func showButtons() {

        if(buttonsView.alpha == 0.0) {
            UIView.animate(withDuration: 0.2, delay: 0, options: UIViewAnimationOptions(), animations:
                {
                    self.buttonsView.center = CGPoint(x: self.buttonsView.center.x, y: screenRect.height - self.buttonsView.frame.size.height/2.0)
                    self.buttonsView.alpha = 1.0
                    
                }, completion: nil)
            
        }else{
            
            UIView.animate(withDuration: 0.1, delay: 0, options: UIViewAnimationOptions(), animations:
                {
                    self.buttonsView.center = CGPoint(x: self.buttonsView.center.x, y: screenRect.height + self.buttonsView.frame.size.height/2.0)
                    self.buttonsView.alpha = 0.0
                }, completion: nil)
            
        }
    }
    
    func editDiary() {
        let composeViewController = self.storyboard?.instantiateViewController(withIdentifier: "DiaryComposeViewController") as! DiaryComposeViewController
        
        if let diary = diary {
            
            print("Find \(diary.created_at)")
            
            composeViewController.diary = diary
        }
        
        self.present(composeViewController, animated: true, completion: nil)
    }
    
    func saveToRoll() {
        
        let offset = self.webview.scrollView.contentOffset.x
        
        let image =  webview.captureView()
        
        self.webview.scrollView.contentOffset.x = offset

        var sharingItems = [AnyObject]()
        sharingItems.append(image)
        print("Do Share")
        
        let activityViewController = UIActivityViewController(activityItems: sharingItems, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.saveButton
        self.present(activityViewController, animated: true, completion: nil)

    }
    
    
    func deleteThisDiary() {
        managedContext.delete(diary)
        do {
            try managedContext.save()
        } catch _ {
        }
        hideDiary()
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        UIView.animate(withDuration: 1.0, delay: 0, options: UIViewAnimationOptions(), animations:
        {
            self.webview.alpha = 1.0
        }, completion: nil)

        webview.scrollView.contentOffset = CGPoint(x: webview.scrollView.contentSize.width - webview.frame.size.width, y: 0)
    }
    
    func hideDiary() {

        self.navigationController?.popViewController(animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        
        return true
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
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
