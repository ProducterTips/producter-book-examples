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
        imageView.contentMode = UIViewContentMode.scaleAspectFill
        view.window!.addSubview(imageView)
        imageView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.size
        .height)
        
        maskView.frame = CGRect(x: 0, y: 64, width: 30, height: 30)
        maskView.layer.cornerRadius = 15.0
        maskView.layer.masksToBounds = true
        maskView.backgroundColor = UIColor.black
        imageView.layer.mask = maskView.layer
        
        startMaskAnimation()
    }
    
    func startMaskAnimation() {
        
        let screenWidth = view.frame.width
        let screenHeight = view.frame.height
        
        //
        let transformAnim            = CAKeyframeAnimation(keyPath:"bounds")
        transformAnim.values         = [NSValue(cgRect:CGRect(x: 0, y: 0, width: 64, height: 64)) ,
                                        NSValue(cgRect:CGRect(x: 0, y: 0, width: 128, height: 128)) ,
                                        NSValue(cgRect:CGRect(x: 0, y: 0, width: 256, height: 256)) ,
                                        NSValue(cgRect:CGRect(x: 0, y: 0, width: view.frame.height*2 , height: view.frame.height*2)) ]
        transformAnim.keyTimes       = [0, 0.349, 0.618, 1]
        transformAnim.duration       = 1
        transformAnim.isRemovedOnCompletion = false
        transformAnim.fillMode = kCAFillModeForwards
        self.maskView.layer.add(transformAnim, forKey: "bounds")
        
        //
        
        let positionAnim            = CAKeyframeAnimation(keyPath:"position")
        positionAnim.values         = [NSValue(cgPoint:CGPoint(x: screenWidth/8.0, y: screenHeight/8.0)) ,
            NSValue(cgPoint:CGPoint(x: screenWidth/4.0, y: screenHeight/4.0)) ,
            NSValue(cgPoint:CGPoint(x: screenWidth/2.0, y: screenHeight/2.0)) ,
            NSValue(cgPoint:CGPoint(x: screenWidth/2.0, y: screenHeight/2.0)) ]
        positionAnim.keyTimes       = [0, 0.249, 0.618, 1]
        positionAnim.duration       = 1
        positionAnim.isRemovedOnCompletion = false
        positionAnim.fillMode = kCAFillModeForwards
        self.maskView.layer.add(positionAnim, forKey: "position")
        
        //
        
        let radiusAnim            = CAKeyframeAnimation(keyPath:"cornerRadius")
        radiusAnim.values         = [32,64,128,view.frame.height]
        radiusAnim.keyTimes       = [0, 0.349, 0.618, 1]
        radiusAnim.duration       = 1
        radiusAnim.isRemovedOnCompletion = false
        radiusAnim.fillMode = kCAFillModeForwards
        self.maskView.layer.add(radiusAnim, forKey: "cornerRadius")

        
    }
    
}
