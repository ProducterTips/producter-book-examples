//
//  bezierAdvanced.swift
//  Animation Advanced
//
//  Created by zhowkevin on 15/9/6.
//  Copyright © 2015年 zhowkevin. All rights reserved.
//

import UIKit

extension DetailViewController {
    /**
    For BezierAdvanced
    */
    
    func bezierAdvanced() {
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(DetailViewController.updatePathPan(_:)))
        
        view.addGestureRecognizer(pan)
        //// Polygon Drawing
        let polygonPath = UIBezierPath()
        polygonPath.move(to: CGPoint(x: 0, y: 0))
        polygonPath.addQuadCurve(to: CGPoint(x: 0, y: view.frame.height), controlPoint: CGPoint(x: 0, y: view.frame.height/2.0))
        polygonPath.close()
        
        // 绘制 CAShapeLayer
        
        jellyShape.drawsAsynchronously = true
        jellyShape.frame = view.bounds
        jellyShape.path = polygonPath.cgPath
        jellyShape.lineWidth = 3.0
        jellyShape.lineCap = kCALineCapRound
        jellyShape.lineJoin = kCALineJoinRound
        jellyShape.strokeColor = UIColor.white.cgColor
        jellyShape.fillColor = color.cgColor
        view.layer.addSublayer(jellyShape)
    }
    
    func updatePathPan(_ gesture: UIPanGestureRecognizer) {
        
        if gesture.state == UIGestureRecognizerState.ended {
            
            let displayLink = CADisplayLink(target: self, selector: #selector(DetailViewController.syncPath))
            
            displayLink.add(to: RunLoop.current, forMode: RunLoopMode.defaultRunLoopMode)
            
            dummyView = UIView(frame: CGRect(x: currentControlPoint, y: view.frame.height/2.0, width: 10, height: 10))
            
            view.addSubview(dummyView!)
            
            UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 50, options: UIViewAnimationOptions(), animations: { () -> Void in
                
                self.dummyView!.center = CGPoint(x: 0, y: self.view.frame.height/2.0)
                
                }, completion: { finish in
                    self.currentControlPoint = 0
                    displayLink.invalidate()
            })
            
            
            
        } else if gesture.state == UIGestureRecognizerState.changed {
            let translationPoint = gesture.translation(in: view)
            
            currentControlPoint = currentControlPoint + translationPoint.x
            
            //// Polygon Drawing
            let polygonPath = UIBezierPath()
            polygonPath.move(to: CGPoint(x: 0, y: 0))
            polygonPath.addQuadCurve(to: CGPoint(x: 0, y: view.frame.height), controlPoint: CGPoint(x: currentControlPoint, y: view.frame.height/2.0))
            polygonPath.close()
            gesture.setTranslation(CGPoint.zero, in: view)
            
            jellyShape.path = polygonPath.cgPath
        }
        
    }
    
    func syncPath() {
        
        if let dummyView = dummyView, let currentLayer = dummyView.layer.presentation() {
            //// Polygon Drawing
            let polygonPath = UIBezierPath()
            polygonPath.move(to: CGPoint(x: 0, y: 0))
            polygonPath.addQuadCurve(to: CGPoint(x: 0, y: view.frame.height), controlPoint: CGPoint(x: currentLayer.frame.origin.x, y: view.frame.height/2.0))
            polygonPath.close()
            
            jellyShape.path = polygonPath.cgPath
        }
        
    }
    
}
