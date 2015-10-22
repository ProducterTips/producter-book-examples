//
//  keyframe.swift
//  Animation Advanced
//
//  Created by zhowkevin on 15/9/6.
//  Copyright © 2015年 zhowkevin. All rights reserved.
//

import UIKit

extension DetailViewController {
    func keyFrame() {
        imageView.image = UIImage(named: "leaf")
        imageView.clipsToBounds = true
        imageView.contentMode = UIViewContentMode.ScaleAspectFill
        
        view.window!.addSubview(imageView)
        imageView.frame = CGRect(x: 0, y: 64, width: view.frame.width, height: 260)
        startKeyFrameAnimation()
    }
    
    func startKeyFrameAnimation() {
        UIView.animateKeyframesWithDuration(2, delay: 0, options: UIViewKeyframeAnimationOptions.CalculationModeCubic, animations: {
            
            UIView.addKeyframeWithRelativeStartTime(0.0, relativeDuration: 0.5) {
                self.imageView.frame = CGRect(x: 0, y: 48, width: self.view.frame.width, height: 0)
            }
            
            UIView.addKeyframeWithRelativeStartTime(0.25, relativeDuration: 0.5) {
                self.imageView.frame = CGRect(x: 0, y: 32, width: self.view.frame.width, height: 260 + self.view.frame.height/4.0)
            }
            
            UIView.addKeyframeWithRelativeStartTime(0.5, relativeDuration: 0.5) {
                self.imageView.frame = CGRect(x: 0, y: 16, width: self.view.frame.width, height: 260 + self.view.frame.height/2.0)
            }
            
            UIView.addKeyframeWithRelativeStartTime(0.75, relativeDuration: 0.5) {
                self.imageView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
            }
            }, completion: nil)
        
    }
}
