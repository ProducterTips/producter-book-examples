//
//  maskAnimation.swift
//  Animation Advanced
//
//  Created by zhowkevin on 15/9/6.
//  Copyright © 2015年 zhowkevin. All rights reserved.
//

import UIKit

extension DetailViewController {
    
    func maskAnimation() {
        imageView.image = UIImage(named: "leaf")
        imageView.clipsToBounds = true
        imageView.contentMode = UIViewContentMode.ScaleAspectFill
        view.window!.addSubview(imageView)
        imageView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.size
        .height)
        
        maskView.frame = CGRect(x: 0, y: 64, width: 30, height: 30)
        maskView.layer.cornerRadius = 15.0
        maskView.layer.masksToBounds = true
        maskView.backgroundColor = UIColor.blackColor()
        imageView.layer.mask = maskView.layer
        
        startMaskAnimation()
    }
    
    func startMaskAnimation() {
        
        let screenWidth = view.frame.width
        let screenHeight = view.frame.height
        
        //
        let transformAnim            = CAKeyframeAnimation(keyPath:"bounds")
        transformAnim.values         = [NSValue(CGRect:CGRectMake(0, 0, 64, 64)) ,
                                        NSValue(CGRect:CGRectMake(0, 0, 128, 128)) ,
                                        NSValue(CGRect:CGRectMake(0, 0, 256, 256)) ,
                                        NSValue(CGRect:CGRectMake(0, 0, view.frame.height*2 , view.frame.height*2)) ]
        transformAnim.keyTimes       = [0, 0.349, 0.618, 1]
        transformAnim.duration       = 1
        transformAnim.removedOnCompletion = false
        transformAnim.fillMode = kCAFillModeForwards
        self.maskView.layer.addAnimation(transformAnim, forKey: "bounds")
        
        //
        
        let positionAnim            = CAKeyframeAnimation(keyPath:"position")
        positionAnim.values         = [NSValue(CGPoint:CGPointMake(screenWidth/8.0, screenHeight/8.0)) ,
            NSValue(CGPoint:CGPointMake(screenWidth/4.0, screenHeight/4.0)) ,
            NSValue(CGPoint:CGPointMake(screenWidth/2.0, screenHeight/2.0)) ,
            NSValue(CGPoint:CGPointMake(screenWidth/2.0, screenHeight/2.0)) ]
        positionAnim.keyTimes       = [0, 0.249, 0.618, 1]
        positionAnim.duration       = 1
        positionAnim.removedOnCompletion = false
        positionAnim.fillMode = kCAFillModeForwards
        self.maskView.layer.addAnimation(positionAnim, forKey: "position")
        
        //
        
        let radiusAnim            = CAKeyframeAnimation(keyPath:"cornerRadius")
        radiusAnim.values         = [32,64,128,view.frame.height]
        radiusAnim.keyTimes       = [0, 0.349, 0.618, 1]
        radiusAnim.duration       = 1
        radiusAnim.removedOnCompletion = false
        radiusAnim.fillMode = kCAFillModeForwards
        self.maskView.layer.addAnimation(radiusAnim, forKey: "cornerRadius")

        
    }
    
}
