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
        
        
        //// 绘制多边形
        let polygonPath = UIBezierPath()
        polygonPath.move(to: CGPoint(x: 162, y: 93))
        polygonPath.addLine(to: CGPoint(x: 230.48, y: 142.75))
        polygonPath.addLine(to: CGPoint(x: 204.32, y: 223.25))
        polygonPath.addLine(to: CGPoint(x: 119.68, y: 223.25))
        polygonPath.addLine(to: CGPoint(x: 93.52, y: 142.75))
        polygonPath.close()
        
        
        //// 绘制五角星
        let starPath = UIBezierPath()
        starPath.move(to: CGPoint(x: 162, y: 82))
        starPath.addLine(to: CGPoint(x: 191.27, y: 124.71))
        starPath.addLine(to: CGPoint(x: 240.94, y: 139.35))
        starPath.addLine(to: CGPoint(x: 209.36, y: 180.39))
        starPath.addLine(to: CGPoint(x: 210.79, y: 232.15))
        starPath.addLine(to: CGPoint(x: 162, y: 214.8))
        starPath.addLine(to: CGPoint(x: 113.21, y: 232.15))
        starPath.addLine(to: CGPoint(x: 114.64, y: 180.39))
        starPath.addLine(to: CGPoint(x: 83.06, y: 139.35))
        starPath.addLine(to: CGPoint(x: 132.73, y: 124.71))
        starPath.close()
        
        // 绘制 CAShapeLayer
        
        let shape = CAShapeLayer()
        shape.drawsAsynchronously = true
        shape.frame = view.bounds
        shape.path = polygonPath.cgPath
        shape.lineWidth = 3.0
        shape.lineCap = .round
        shape.lineJoin = .round
        shape.strokeColor = UIColor.white.cgColor
        shape.fillColor = color.cgColor
        view.layer.addSublayer(shape)
        
        let pathAnimation = CABasicAnimation(keyPath: "path")
        pathAnimation.fromValue = polygonPath.cgPath
        pathAnimation.toValue = starPath.cgPath
        pathAnimation.duration = 1.0
        pathAnimation.autoreverses = false
        pathAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        
        shape.add(pathAnimation, forKey: "animationKey")
        
        shape.path = starPath.cgPath
    }
}
