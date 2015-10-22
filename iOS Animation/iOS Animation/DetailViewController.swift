//
//  DetailViewController.swift
//  iOS Animation
//
//  Created by zhowkevin on 15/8/27.
//  Copyright © 2015年 zhowkevin. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailDescriptionLabel: UILabel!
    
    var codeView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))

    @IBOutlet weak var autoLayoutView: UIView!
    
    @IBOutlet weak var autoLayoutViewWidthConstraint: NSLayoutConstraint!
    
    var detailItem: AnyObject?

    func configureView() {
        
        // Update the user interface for the detail item.
        if let detailItem = self.detailItem, animation = AnimationType(rawValue: detailItem.integerValue) {
            
            switch animation {
            case AnimationType.SizeCode:
                codeView.hidden = false

                UIView.animateWithDuration(1.0, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
                    
                    self.codeView.frame = CGRectMake(self.codeView.frame.origin.x,self.codeView.frame.origin.y , 200, 200)
                    self.codeView.center = self.view.center
                    
                }, completion: nil)

            case AnimationType.SizeAutoLayout:
                
                autoLayoutView.hidden = false
                
                UIView.animateWithDuration(1.0, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
                    
                    self.autoLayoutViewWidthConstraint.constant = 200
                    
                    self.view.layoutIfNeeded()
                }, completion: nil)
            }
            
            
            if let label = self.detailDescriptionLabel {
                label.text = animation.description
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        autoLayoutView.hidden = true
        
        codeView.backgroundColor = autoLayoutView.backgroundColor
        
        view.addSubview(codeView)
        
        codeView.center = view.center
        
        codeView.hidden = true
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

