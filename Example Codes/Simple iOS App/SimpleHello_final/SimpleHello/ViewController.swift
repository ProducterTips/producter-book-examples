//
//  ViewController.swift
//  SimpleHello
//
//  Created by kevinzhow on 15/6/10.
//  Copyright (c) 2015年 kevinzhow. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.lightGray
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func eatOrNot(_ sender: AnyObject) {
        let message = UIAlertView(title: "Hi", message: "我只吃电，不吃饭", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "好的")
        message.show()
    }

    
}

