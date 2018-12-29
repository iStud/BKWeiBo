//
//  BKPopoverDelegate.swift
//  BKWeiBo
//
//  Created by bk.xiong on 2018/12/28.
//  Copyright © 2018 xiongbk. All rights reserved.
//

import UIKit

class BKPopoverDelegate: NSObject,UIViewControllerTransitioningDelegate,UIViewControllerAnimatedTransitioning {
    
    var isPresent:Bool = false
    
    // MARK: - UIViewControllerAnimatedTransitioning
    // 动画时长
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        
        return 0.2
    }
    
    // 如何动画
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        //        titleBtn.isSelected = isPresent
        
        if isPresent {
            
            // transform 动画
            let toView = transitionContext.view(forKey: UITransitionContextViewKey.to)
            toView?.transform = CGAffineTransform(scaleX: 1.0, y: 0.0)
            toView?.layer.anchorPoint = CGPoint(x: 0.5, y: 0)
            transitionContext.containerView .addSubview(toView!)
            
            UIView.animate(withDuration: 0.2, animations: {
                
                toView?.transform = CGAffineTransform.identity
                
            }) { (_) in
                
                transitionContext.completeTransition(true)
            }
            
        }else{
            
            let fromView = transitionContext.view(forKey: UITransitionContextViewKey.from)
            UIView .animate(withDuration: 0.2, animations: {
                
                fromView?.transform = CGAffineTransform(scaleX: 1.0, y: 0.00001)
                
            }) { (_) in
                
                transitionContext.completeTransition(true)
            }
            
        }
        
        
        
    }
    
    // MARK: - UIViewControllerTransitioningDelegate
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        
        return BKPresentationController(presentedViewController: presented, presenting: presenting)
    }
    
    // 设置谁负责动画
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        isPresent = true
        
        return self
    }
    
    // 设置负责消失动画
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        isPresent = false
        return self
    }
}

