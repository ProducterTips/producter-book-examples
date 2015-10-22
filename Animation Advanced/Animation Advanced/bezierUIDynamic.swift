//
//  bezierUIDynamic.swift
//  Animation Advanced
//
//  Created by zhowkevin on 15/9/6.
//  Copyright © 2015年 zhowkevin. All rights reserved.
//

import UIKit

extension DetailViewController {
    
    /**
    For BezierUIDynamic
    */
    
    
    func updateUIDynamicPathPan(gesture: UIPanGestureRecognizer) {
        
        if gesture.state == UIGestureRecognizerState.Ended {
            
            bezierUIDynamicSetup()
            
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
        } else if gesture.state == UIGestureRecognizerState.Began {
            
            displayLinkUIDynamic?.invalidate()
            currentControlPoint = 0
            
        }
        
    }
    
    
    func bezierUIDynamic() {
        
        let pan = UIPanGestureRecognizer(target: self, action: "updateUIDynamicPathPan:")
        
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
    
    
    func bezierUIDynamicSetup() {
        box = UIView(frame: CGRect(x: currentControlPoint, y: view.frame.height/2.0, width: 10, height: 10))
        //        box?.backgroundColor = UIColor.redColor()
        view.addSubview(box!)
        
        animator = UIDynamicAnimator(referenceView:self.view)
        
        gravity = UIGravityBehavior(items: [box!])
        gravity.gravityDirection = CGVectorMake(-10.9, 0)
        
        collision = UICollisionBehavior(items: [box!])
        collision.translatesReferenceBoundsIntoBoundary = true
        
        let itemBehaviour = UIDynamicItemBehavior(items: [box!])
        itemBehaviour.elasticity = 0.6
        
        animator?.addBehavior(itemBehaviour)
        animator?.addBehavior(collision)
        animator?.addBehavior(gravity)
        
        displayLinkUIDynamic = CADisplayLink(target: self, selector: "syncUIDynamicPath")
        
        displayLinkUIDynamic!.addToRunLoop(NSRunLoop.currentRunLoop(), forMode: NSDefaultRunLoopMode)
    }
    
    func syncUIDynamicPath() {
        
        if let dummyView = box, currentLayer = dummyView.layer.presentationLayer() as? CALayer {
            //// Polygon Drawing
            let polygonPath = UIBezierPath()
            polygonPath.moveToPoint(CGPointMake(0, 0))
            polygonPath.addQuadCurveToPoint(CGPointMake(0, view.frame.height), controlPoint: CGPointMake(currentLayer.frame.origin.x, view.frame.height/2.0))
            polygonPath.closePath()
            
            jellyShape.path = polygonPath.CGPath
        }
        
    }
}
