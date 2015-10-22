//
//  DetailViewController.swift
//  Animation Advanced
//
//  Created by zhowkevin on 15/8/29.
//  Copyright © 2015年 zhowkevin. All rights reserved.
//

import UIKit

let color = UIColor(red: 0.225, green: 1.000, blue: 0.743, alpha: 1.000)

class DetailViewController: UIViewController {

    @IBOutlet weak var detailDescriptionLabel: UILabel!

    let jellyShape = CAShapeLayer()
    
    var currentControlPoint: CGFloat = 0
    
    var dummyView: UIView?
    
    //
    
    var box : UIView?
    
    var animator:UIDynamicAnimator? = nil
    
    var gravity: UIGravityBehavior!
    
    var collision: UICollisionBehavior!

    var displayLinkUIDynamic: CADisplayLink?
    
    //
    
    var imageView = UIImageView(frame: CGRectZero)
    
    var maskView = UIImageView(frame: CGRectZero)

    var detailItem: AnimationType? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }

    func configureView() {
        // Update the user interface for the detail item.
        if let detail = self.detailItem {
            if let label = self.detailDescriptionLabel {
                label.text = detail.rawValue
            }
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if let detail = self.detailItem {
            switch detail {
            case .Bezier:
                bezierSimple()
            case .BezierAdvanced:
                bezierAdvanced()
            case .BezierUIDynamic:
                bezierUIDynamic()
            case .KeyFrame:
                keyFrame()
            case .MaskAnimation:
                maskAnimation()
            }
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

