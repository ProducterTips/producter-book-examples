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
        imageView.contentMode = .scaleAspectFill
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
        
        // 针对bounds的变形动画
        let transformAnim            = CAKeyframeAnimation(keyPath:"bounds")
        
        // values中定义了各个关键帧真对属性所需要修改的目标数值
        transformAnim.values         = [NSValue(cgRect:CGRect(x: 0, y: 0, width: 64, height: 64)) ,
                                        NSValue(cgRect:CGRect(x: 0, y: 0, width: 128, height: 128)) ,
                                        NSValue(cgRect:CGRect(x: 0, y: 0, width: 256, height: 256)) ,
                                        NSValue(cgRect:CGRect(x: 0, y: 0, width: view.frame.height*2 , height: view.frame.height*2)) ]
        
        // keyTimes和values是一一对应的关系，定义了每个关键帧
        // 执行时相对于总时间的位置
        transformAnim.keyTimes       = [0, 0.349, 0.618, 1]
        
        // duration为总时间
        transformAnim.duration       = 1
        
        // removedOnCompletion定义了动画完成时是否从Layer上删除
        transformAnim.isRemovedOnCompletion = false
        
        // fillMode定义了动画完成时，对于Layer的属性修改是否保留
        transformAnim.fillMode = .forwards
        
        // 我们这里将removedOnCompletion定义为false，fillMode
        // 定义为kCAFillModeForwards则可以使得动画结束时，保留
        // Layer的结束状态，你可以通过注释到这两句，看看其默认效果
        
        self.maskView.layer.add(transformAnim, forKey: "bounds")
        
        // 定义位移动画，因为Core Animation不能操作frame，所以
        // 需要拆分成position和bounds两个动画
        
        let positionAnim            = CAKeyframeAnimation(keyPath:"position")
        positionAnim.values         = [NSValue(cgPoint:CGPoint(x: screenWidth/8.0, y: screenHeight/8.0)) ,
            NSValue(cgPoint:CGPoint(x: screenWidth/4.0, y: screenHeight/4.0)) ,
            NSValue(cgPoint:CGPoint(x: screenWidth/2.0, y: screenHeight/2.0)) ,
            NSValue(cgPoint:CGPoint(x: screenWidth/2.0, y: screenHeight/2.0)) ]
        positionAnim.keyTimes       = [0, 0.249, 0.618, 1]
        positionAnim.duration       = 1
        positionAnim.isRemovedOnCompletion = false
        positionAnim.fillMode = .forwards
        self.maskView.layer.add(positionAnim, forKey: "position")
        
        // 定义修改圆角的动画
        
        let radiusAnim            = CAKeyframeAnimation(keyPath:"cornerRadius")
        radiusAnim.values         = [32,64,128,view.frame.height]
        radiusAnim.keyTimes       = [0, 0.349, 0.618, 1]
        radiusAnim.duration       = 1
        radiusAnim.isRemovedOnCompletion = false
        radiusAnim.fillMode = .forwards
        self.maskView.layer.add(radiusAnim, forKey: "cornerRadius")

        
    }
    
}
