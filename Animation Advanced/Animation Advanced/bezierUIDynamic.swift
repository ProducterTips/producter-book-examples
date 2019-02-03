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
    
    
    @objc func updateUIDynamicPathPan(_ gesture: UIPanGestureRecognizer) {
        
        if gesture.state == .ended {
            
            bezierUIDynamicSetup()
            
        } else if gesture.state == .changed {
            
            let translationPoint = gesture.translation(in: view)
            
            currentControlPoint = currentControlPoint + translationPoint.x
            
            //// Polygon Drawing
            let polygonPath = UIBezierPath()
            polygonPath.move(to: CGPoint(x: 0, y: 0))
            polygonPath.addQuadCurve(to: CGPoint(x: 0, y: view.frame.height), controlPoint: CGPoint(x: currentControlPoint, y: view.frame.height/2.0))
            polygonPath.close()
            gesture.setTranslation(CGPoint.zero, in: view)
            
            jellyShape.path = polygonPath.cgPath
        } else if gesture.state == .began {
            
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
        jellyShape.lineCap = CAShapeLayerLineCap.round
        jellyShape.lineJoin = CAShapeLayerLineJoin.round
        jellyShape.strokeColor = UIColor.white.cgColor
        jellyShape.fillColor = color.cgColor
        view.layer.addSublayer(jellyShape)
    }
    
    
    func bezierUIDynamicSetup() {
        // 创建物理碰撞盒子
        box = UIView(frame: CGRect(x: currentControlPoint, y: view.frame.height/2.0, width: 10, height: 10))
        //        box?.backgroundColor = UIColor.redColor()
        view.addSubview(box!)
        
        // 创建 Animator
        animator = UIDynamicAnimator(referenceView:self.view)
        
        // 给盒子添加重力属性
        gravity = UIGravityBehavior(items: [box!])
        
        // 将重力调整为x轴向左坠落
        gravity.gravityDirection = CGVector(dx: -10.9, dy: 0)
        
        // 给盒子增加碰撞检测
        collision = UICollisionBehavior(items: [box!])
        collision.translatesReferenceBoundsIntoBoundary = true
        
        // 修改盒子的弹性
        let itemBehaviour = UIDynamicItemBehavior(items: [box!])
        itemBehaviour.elasticity = 0.6
        
        animator?.addBehavior(itemBehaviour)
        animator?.addBehavior(collision)
        animator?.addBehavior(gravity)
        
        displayLinkUIDynamic = CADisplayLink(target: self, selector: #selector(DetailViewController.syncUIDynamicPath))
        
        displayLinkUIDynamic!.add(to: .current, forMode: .default)
    }
    
    @objc func syncUIDynamicPath() {
        
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
