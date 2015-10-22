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
        
        let pan = UIPanGestureRecognizer(target: self, action: "updatePathPan:")
        
        view.addGestureRecognizer(pan)
        //// Polygon Drawing
        let polygonPath = UIBezierPath()
        polygonPath.moveToPoint(CGPointMake(0, 0))
        polygonPath.addQuadCurveToPoint(CGPointMake(0, view.frame.height), controlPoint: CGPointMake(0, view.frame.height/2.0))
        polygonPath.closePath()
        
        // 绘制 CAShapeLayer
        
        jellyShape.drawsAsynchronously = true
        jellyShape.frame = view.bounds
        jellyShape.path = polygonPath.CGPath
        jellyShape.lineWidth = 3.0
        jellyShape.lineCap = kCALineCapRound
        jellyShape.lineJoin = kCALineJoinRound
        jellyShape.strokeColor = UIColor.whiteColor().CGColor
        jellyShape.fillColor = color.CGColor
        view.layer.addSublayer(jellyShape)
    }
    
    func updatePathPan(gesture: UIPanGestureRecognizer) {
        
        if gesture.state == UIGestureRecognizerState.Ended {
            
            let displayLink = CADisplayLink(target: self, selector: "syncPath")
            
            displayLink.addToRunLoop(NSRunLoop.currentRunLoop(), forMode: NSDefaultRunLoopMode)
            
            dummyView = UIView(frame: CGRect(x: currentControlPoint, y: view.frame.height/2.0, width: 10, height: 10))
            
            view.addSubview(dummyView!)
            
            UIView.animateWithDuration(1.0, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 50, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                
                self.dummyView!.center = CGPointMake(0, self.view.frame.height/2.0)
                
                }, completion: { finish in
                    self.currentControlPoint = 0
                    displayLink.invalidate()
            })
            
            
            
        } else if gesture.state == UIGestureRecognizerState.Changed {
            let translationPoint = gesture.translationInView(view)
            
            currentControlPoint = currentControlPoint + translationPoint.x
            
            //// Polygon Drawing
            let polygonPath = UIBezierPath()
            polygonPath.moveToPoint(CGPointMake(0, 0))
            polygonPath.addQuadCurveToPoint(CGPointMake(0, view.frame.height), controlPoint: CGPointMake(currentControlPoint, view.frame.height/2.0))
            polygonPath.closePath()
            gesture.setTranslation(CGPointZero, inView: view)
            
            jellyShape.path = polygonPath.CGPath
        }
        
    }
    
    func syncPath() {
        
        if let dummyView = dummyView, currentLayer = dummyView.layer.presentationLayer() as? CALayer {
            //// Polygon Drawing
            let polygonPath = UIBezierPath()
            polygonPath.moveToPoint(CGPointMake(0, 0))
            polygonPath.addQuadCurveToPoint(CGPointMake(0, view.frame.height), controlPoint: CGPointMake(currentLayer.frame.origin.x, view.frame.height/2.0))
            polygonPath.closePath()
            
            jellyShape.path = polygonPath.CGPath
        }
        
    }
    
}
