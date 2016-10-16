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
    
    
    func updateUIDynamicPathPan(_ gesture: UIPanGestureRecognizer) {
        
        if gesture.state == UIGestureRecognizerState.ended {
            
            bezierUIDynamicSetup()
            
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
        } else if gesture.state == UIGestureRecognizerState.began {
            
            displayLinkUIDynamic?.invalidate()
            currentControlPoint = 0
            
        }
        
    }
    
    
    func bezierUIDynamic() {
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(DetailViewController.updateUIDynamicPathPan(_:)))
        
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
    
    
    func bezierUIDynamicSetup() {
        box = UIView(frame: CGRect(x: currentControlPoint, y: view.frame.height/2.0, width: 10, height: 10))
        //        box?.backgroundColor = UIColor.redColor()
        view.addSubview(box!)
        
        animator = UIDynamicAnimator(referenceView:self.view)
        
        gravity = UIGravityBehavior(items: [box!])
        gravity.gravityDirection = CGVector(dx: -10.9, dy: 0)
        
        collision = UICollisionBehavior(items: [box!])
        collision.translatesReferenceBoundsIntoBoundary = true
        
        let itemBehaviour = UIDynamicItemBehavior(items: [box!])
        itemBehaviour.elasticity = 0.6
        
        animator?.addBehavior(itemBehaviour)
        animator?.addBehavior(collision)
        animator?.addBehavior(gravity)
        
        displayLinkUIDynamic = CADisplayLink(target: self, selector: #selector(DetailViewController.syncUIDynamicPath))
        
        displayLinkUIDynamic!.add(to: RunLoop.current, forMode: RunLoopMode.defaultRunLoopMode)
    }
    
    func syncUIDynamicPath() {
        
        if let dummyView = box, let currentLayer = dummyView.layer.presentation() {
            //// Polygon Drawing
            let polygonPath = UIBezierPath()
            polygonPath.move(to: CGPoint(x: 0, y: 0))
            polygonPath.addQuadCurve(to: CGPoint(x: 0, y: view.frame.height), controlPoint: CGPoint(x: currentLayer.frame.origin.x, y: view.frame.height/2.0))
            polygonPath.close()
            
            jellyShape.path = polygonPath.cgPath
        }
        
    }
}
