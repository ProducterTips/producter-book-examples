//
//  ViewController.swift
//  SimpleHello
//
//  Created by kevinzhow on 15/6/10.
//  Copyright (c) 2015年 kevinzhow. All rights reserved.
//

import UIKit

import UIKit

class ViewController: UIViewController {
    
    var askButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let askButton = UIButton(type: UIButtonType.system)
        
        //创建一个 UIButton
        
        askButton.setTitle("你吃了吗",
            for: UIControlState())
        
        //创建一个 设置默认状态下的文字，显示为 你吃了吗
        
        askButton.addTarget(self, action: #selector(ViewController.eatOrNot),
            for: UIControlEvents.touchUpInside)
        
        UIView.animate(withDuration: 1.0, delay: 0, options:
            UIViewAnimationOptions.curveEaseInOut, animations: {
                
                self.view.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
                // 可以修改多个属性
                
            }, completion: nil)

        
        //当点击这个 Button 的时候，执行 self （即 ViewController 这个类） 里面的 eatOrNot 方法
        
        askButton.frame = CGRect(
            x: view.frame.width/2.0 - 50,
            y: view.frame.height/2.0 - 20,
            width: 100, height: 40)
        
        //通过计算 View 的高度和宽度，以及这个 Button 的宽度和高度，将 Button 放置在屏幕中间
        
        view.addSubview(askButton)
        
        //把 Button 添加到容器（即 View 里）
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func eatOrNot() {
        
        //创建一个 UIAlertController
        let alertController = UIAlertController(title: "Hi", message: "我只吃电，不吃饭.", preferredStyle: .alert)
        let oKAction = UIAlertAction(title: "好的", style: .default) { action in
            // add something
        }
        alertController.addAction(OKAction)
        
        self.present(alertController, animated: true, completion: {
            // add something
        })
        
    }
    
}
