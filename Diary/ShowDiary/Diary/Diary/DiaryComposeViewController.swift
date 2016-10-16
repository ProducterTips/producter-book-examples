//
//  DiaryComposeViewController.swift
//  Diary
//
//  Created by kevinzhow on 15/3/4.
//  Copyright (c) 2015年 kevinzhow. All rights reserved.
//

import UIKit
import CoreData

let titleTextViewHeight:CGFloat = 30.0
let contentMargin:CGFloat = 20.0

class DiaryComposeViewController: UIViewController{

    var composeView:UITextView!
    var locationTextView:UITextView!
    var titleTextView:UITextView!

    var keyboardSize:CGSize = CGSize(width: 0, height: 0)
    var finishButton:UIButton!
    var diary:Diary?
    
    var locationHelper: DiaryLocationHelper = DiaryLocationHelper()
    
    var changeText = false
    
    var changeTextCount = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        let containerSize = CGSize(width: screenRect.width, height: CGFloat.max)
        let container = NSTextContainer(size: containerSize)

        container.widthTracksTextView = true
        let layoutManager = NSLayoutManager()

        composeView = UITextView(frame: CGRect(x: 0, y: contentMargin + titleTextViewHeight, width: screenRect.width, height: screenRect.height))
        composeView.font = DiaryFont
        composeView.isEditable = true
        composeView.isUserInteractionEnabled = true
        composeView.textContainerInset = UIEdgeInsetsMake(contentMargin, contentMargin, contentMargin, contentMargin)

        //Add LocationTextView
        locationTextView = UITextView(frame: CGRect(x: 0, y: composeView.frame.size.height - 30.0, width: screenRect.width - 60.0, height: 30.0))
        locationTextView.font = DiaryLocationFont
        locationTextView.isEditable = true
        locationTextView.isUserInteractionEnabled = true
        locationTextView.alpha = 0.0
        locationTextView.bounces = false

        //Add titleView

        titleTextView = UITextView(frame: CGRect(x: contentMargin, y: contentMargin/2, width: screenRect.width - 60.0, height: titleTextViewHeight))
        titleTextView.font = DiaryTitleFont
        titleTextView.isEditable = true
        titleTextView.isUserInteractionEnabled = true
        titleTextView.bounces = false

        if let diary = diary {
            composeView.text = diary.content
            self.composeView.contentOffset = CGPoint(x: 0, y: self.composeView.contentSize.height)
            locationTextView.text = diary.location
            locationTextView.alpha = 1.0
            if let title = diary.title {
                titleTextView.text = title
            }else{
                titleTextView.text = "\(numberToChineseWithUnit((Calendar.current as NSCalendar).component(NSCalendar.Unit.day, from: diary.created_at))) 日"
            }
        }else{
            let date = Date()
            titleTextView.text = "\(numberToChineseWithUnit((Calendar.current as NSCalendar).component(NSCalendar.Unit.day, from: date))) 日"
        }

        composeView.becomeFirstResponder()

        self.view.addSubview(composeView)

        self.view.addSubview(locationTextView)

        self.view.addSubview(titleTextView)

        //Add finish button

        finishButton = diaryButtonWith(text: "完",  fontSize: 18.0,  width: 50.0,  normalImageName: "Oval", highlightedImageName: "Oval_pressed")

        finishButton.center = CGPoint(x: screenRect.width - 20, y: screenRect.height - 30)

        finishButton.addTarget(self, action: #selector(DiaryComposeViewController.finishCompose(_:)), for: UIControlEvents.touchUpInside)
        

        self.view.addSubview(finishButton)
        

        self.finishButton.center = CGPoint(x: self.view.frame.width - self.finishButton.frame.size.height/2.0 - 10, y: self.view.frame.height  - self.finishButton.frame.size.height/2.0 - 10)

        self.locationTextView.center = CGPoint(x: self.locationTextView.frame.size.width/2.0 + 20.0, y: self.finishButton.center.y)

        NotificationCenter.default.addObserver(self, selector: #selector(DiaryComposeViewController.keyboardDidShow(_:)), name: NSNotification.Name.UIKeyboardDidShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(DiaryComposeViewController.keyboardDidShow(_:)), name:NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(DiaryComposeViewController.keyboardDidHide(_:)), name: NSNotification.Name.UIKeyboardDidHide, object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(DiaryComposeViewController.updateAddress(_:)), name: NSNotification.Name(rawValue: "DiaryLocationUpdated"), object: nil)

        // Do any additional setup after loading the view.
    }

    func updateAddress(_ notification: Notification) {

        if let address = notification.object as? String {

            print("Author at \(address)")

            if let lastLocation = diary?.location {
                locationTextView.text = diary?.location
            }else {
                locationTextView.text = "于 \(address)"
            }


            UIView.animate(withDuration: 0.5, delay: 0, options: UIViewAnimationOptions(), animations:
                {
                    self.locationTextView.alpha = 1.0

                }, completion: nil)

            locationHelper.locationManager.stopUpdatingLocation()
        }


    }

    func finishCompose(_ button: UIButton) {
        print("Finish compose \n", terminator: "")

        self.composeView.endEditing(true)
        self.locationTextView.endEditing(true)

        if (composeView.text.lengthOfBytes(using: String.Encoding.utf8) > 1){

            if let diary = diary {

                diary.content = composeView.text
                diary.location = locationTextView.text
                diary.title = titleTextView.text
                

            }else{

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
            }

            var error: NSError?
            do {
                try managedContext.save()
            } catch let error1 as NSError {
                error = error1
                print("Could not save \(error), \(error?.userInfo)")
            }

        }

        self.dismiss(animated: true, completion: nil)
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

    func keyboardDidShow(_ notification: Notification) {

        if let rectValue = (notification as NSNotification).userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue {
            keyboardSize = rectValue.cgRectValue.size
            updateTextViewSizeForKeyboardHeight(keyboardSize.height)
        }
    }

    func keyboardDidHide(_ notification: Notification) {
        updateTextViewSizeForKeyboardHeight(0)
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


