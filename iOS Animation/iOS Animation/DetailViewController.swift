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
        if let detailItem = self.detailItem, let animation = AnimationType(rawValue: detailItem.intValue) {
            
            switch animation {
            case AnimationType.sizeCode:
                codeView.isHidden = false

                UIView.animate(withDuration: 1.0, delay: 0, options: UIViewAnimationOptions(), animations: {
                    
                    self.codeView.frame = CGRect(x: self.codeView.frame.origin.x,y: self.codeView.frame.origin.y , width: 200, height: 200)
                    self.codeView.center = self.view.center
                    
                }, completion: nil)

            case AnimationType.sizeAutoLayout:
                
                autoLayoutView.isHidden = false
                
                UIView.animate(withDuration: 1.0, delay: 0, options: UIViewAnimationOptions(), animations: {
                    
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
        
        autoLayoutView.isHidden = true
        
        codeView.backgroundColor = autoLayoutView.backgroundColor
        
        view.addSubview(codeView)
        
        codeView.center = view.center
        
        codeView.isHidden = true
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

