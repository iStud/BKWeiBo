//
//  BKPresentationController.swift
//  BKWeiBo
//
//  Created by bk.xiong on 2018/12/27.
//  Copyright © 2018 xiongbk. All rights reserved.
//

import UIKit

class BKPresentationController: UIPresentationController {
    
    override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
    }

    override func containerViewWillLayoutSubviews() {
        
        super.containerViewWillLayoutSubviews()
        
        // 修改被展示 view 的尺寸 presentedView
        // containerView 容器视图
        presentedView?.frame = CGRect(x: 100, y:70, width: 200, height: 230)

    }
    
    override func presentationTransitionWillBegin() {
        
        maskView.frame = UIScreen.main.bounds
        // 容器视图上添加蒙版 
        containerView?.insertSubview(maskView, at: 0)
        
    }
    
    
    lazy var maskView: UIView = {
        
        let view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 0.2)
        let tap = UITapGestureRecognizer(target: self, action: #selector(maskViewTap))
        view.addGestureRecognizer(tap)
        view.isUserInteractionEnabled = true
        return view
    }()
    
     @objc private func maskViewTap()  {
        
       presentedViewController.dismiss(animated: true, completion: nil)
    }
}
