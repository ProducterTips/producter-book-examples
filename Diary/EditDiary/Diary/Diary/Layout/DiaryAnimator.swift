//
//  DiaryAnimator.swift
//  Diary
//
//  Created by kevinzhow on 15/5/19.
//  Copyright (c) 2015年 kevinzhow. All rights reserved.
//
import UIKit

class DiaryAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    var operation:UINavigationControllerOperation!
    
    // 转场时长
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.4
    }
    
    // 转场的参数变化
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        let containerView = transitionContext.containerView()
        // 获取转场舞台
        
        let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)
        let fromView = fromVC!.view
        // 获取从哪个场景开始转
        
        let toVC   = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)
        let toView = toVC!.view
        // 获取要转去哪个场景
        
        toView.alpha = 0.0
        // 设置新场景透明度
        
        // UINavigationControllerOperation.Pop 用来判断是转入还是转出
        if operation ==  UINavigationControllerOperation.Pop {
            toView.transform = CGAffineTransformMakeScale(1.0,1.0)
            // 如果是返回旧场景，那么设置要转入的场景初始缩放为原始大小
            
        }else{
            toView.transform = CGAffineTransformMakeScale(0.3,0.3);
            // 如果是转到新场景，设置新场景初始缩放为 0.3
        }
        
        containerView!.insertSubview(toView, aboveSubview: fromView)
        // 在舞台上插入场景
        
        // 进行动画
        UIView.animateWithDuration(transitionDuration(transitionContext), delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations:
            {
                if self.operation ==  UINavigationControllerOperation.Pop {
                    fromView.transform = CGAffineTransformMakeScale(3.3,3.3)
                    // 放大要转出的场景
                    
                }else{
                    toView.transform = CGAffineTransformMakeScale(1.0,1.0);
                    // 设置新场景为原始大小
                }
                
                toView.alpha = 1.0
                
            }, completion: { finished in
                transitionContext.completeTransition(true)
                // 通知 NavigationController 已经完成转场
        })   
    }
}