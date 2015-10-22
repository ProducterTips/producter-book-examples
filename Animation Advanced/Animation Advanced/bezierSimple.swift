//
//  bezierSimple.swift
//  Animation Advanced
//
//  Created by zhowkevin on 15/9/6.
//  Copyright © 2015年 zhowkevin. All rights reserved.
//

import UIKit

extension DetailViewController {
    
    /**
    For Bezier
    */
    
    
    func bezierSimple() {
        
        
        //// Polygon Drawing
        let polygonPath = UIBezierPath()
        polygonPath.moveToPoint(CGPointMake(162, 93))
        polygonPath.addLineToPoint(CGPointMake(230.48, 142.75))
        polygonPath.addLineToPoint(CGPointMake(204.32, 223.25))
        polygonPath.addLineToPoint(CGPointMake(119.68, 223.25))
        polygonPath.addLineToPoint(CGPointMake(93.52, 142.75))
        polygonPath.closePath()
        
        
        //// Star Drawing
        let starPath = UIBezierPath()
        starPath.moveToPoint(CGPointMake(162, 82))
        starPath.addLineToPoint(CGPointMake(191.27, 124.71))
        starPath.addLineToPoint(CGPointMake(240.94, 139.35))
        starPath.addLineToPoint(CGPointMake(209.36, 180.39))
        starPath.addLineToPoint(CGPointMake(210.79, 232.15))
        starPath.addLineToPoint(CGPointMake(162, 214.8))
        starPath.addLineToPoint(CGPointMake(113.21, 232.15))
        starPath.addLineToPoint(CGPointMake(114.64, 180.39))
        starPath.addLineToPoint(CGPointMake(83.06, 139.35))
        starPath.addLineToPoint(CGPointMake(132.73, 124.71))
        starPath.closePath()
        
        // 绘制 CAShapeLayer
        
        let shape = CAShapeLayer()
        shape.drawsAsynchronously = true
        shape.frame = view.bounds
        shape.path = polygonPath.CGPath
        shape.lineWidth = 3.0
        shape.lineCap = kCALineCapRound
        shape.lineJoin = kCALineJoinRound
        shape.strokeColor = UIColor.whiteColor().CGColor
        shape.fillColor = color.CGColor
        view.layer.addSublayer(shape)
        
        let pathAnimation = CABasicAnimation(keyPath: "path")
        pathAnimation.fromValue = polygonPath.CGPath
        pathAnimation.toValue = starPath.CGPath
        pathAnimation.duration = 1.0
        pathAnimation.autoreverses = false
        pathAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        
        shape.addAnimation(pathAnimation, forKey: "animationKey")
        
        shape.path = starPath.CGPath
    }
}