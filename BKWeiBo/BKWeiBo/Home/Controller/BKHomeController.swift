//
//  BKHomeController.swift
//  BKWeiBo
//
//  Created by bk.xiong on 2018/6/29.
//  Copyright © 2018年 xiongbk. All rights reserved.
//

import UIKit

class BKHomeController: BKBaseController {
    
    // 是否展开
    var isPresent:Bool = false
    var titleBtn = TitleButton()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        
        if !isLogin {
            
            visitView?.setVisitInfo(isHome: true, imageName: "visitordiscover_feed_image_house", message: "关注一些人，回这里看看有什么惊喜")
//            visitView?.startAnimation()
        }else{
            
            setNav()
        }
    }

    // MARK: - 设置 UI
    // 设置导航栏
    func setNav(){
        
        navigationItem.leftBarButtonItem = UIBarButtonItem.itemCreated(image: "navigationbar_friendattention", target: self, action: #selector(addFriendsBtnClick))
        navigationItem.rightBarButtonItem = UIBarButtonItem.itemCreated(image: "navigationbar_pop", target: self, action: #selector(scanBtnClick))
        
        // 设置导航标题
        titleBtn.setTitle("壹拾零", for: .normal)
        navigationItem.titleView = titleBtn
        titleBtn.addTarget(self, action: #selector(titleBtnClick(btn:)), for: .touchUpInside)
        
//        let lastY:CGFloat = (navigationItem.titleView?.frame.maxY)!
//        print(lastY)
        

    }
    
    // MARK: - 按钮点击方法
    @objc func titleBtnClick(btn:UIButton){
        
        btn.isSelected = !btn.isSelected
    
        // 获取 storyBoard 对象
        let sb = UIStoryboard(name: "BKPopoverController", bundle: nil)
        // 实例化 stroyBoard 视图控制器
        let popover = sb.instantiateViewController(withIdentifier: "PopoverController")
        
        // 使用默认的 modal 会导致当前控制器的 view 被移除
        // 使用自定义的就不会移除
        popover.transitioningDelegate = popoverDelegate
        popover.modalPresentationStyle = UIModalPresentationStyle.custom
        present(popover, animated: true, completion: nil)
    }
    
    @objc func addFriendsBtnClick(){
    
        print(#function)
    }
    
    @objc func scanBtnClick(){
        
        print(#function)
    }
    
    lazy var popoverDelegate: BKPopoverDelegate = {
        
        let pop = BKPopoverDelegate()
        
        return pop
    }()
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}

//extension BKHomeController:UIViewControllerTransitioningDelegate,UIViewControllerAnimatedTransitioning {
//
//    // MARK: - UIViewControllerAnimatedTransitioning
//    // 动画时长
//    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
//
//        return 0.5
//    }
//
//    // 如何动画
//    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
//
//        titleBtn.isSelected = isPresent
//
//        if isPresent {
//
//            // transform 动画
//            let toView = transitionContext.view(forKey: UITransitionContextViewKey.to)
//            toView?.transform = CGAffineTransform(scaleX: 1.0, y: 0.0)
//            toView?.layer.anchorPoint = CGPoint(x: 0.5, y: 0)
//            transitionContext.containerView .addSubview(toView!)
//
//            UIView.animate(withDuration: 0.5, animations: {
//
//                toView?.transform = CGAffineTransform.identity
//
//            }) { (_) in
//
//                transitionContext.completeTransition(true)
//            }
//
//        }else{
//
//            let fromView = transitionContext.view(forKey: UITransitionContextViewKey.from)
//            UIView .animate(withDuration: 0.5, animations: {
//
//                fromView?.transform = CGAffineTransform(scaleX: 1.0, y: 0.00001)
//
//            }) { (_) in
//
//                transitionContext.completeTransition(true)
//            }
//
//        }
//
//
//
//    }
//
//    // MARK: - UIViewControllerTransitioningDelegate
//
//    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
//
//        return BKPresentationController(presentedViewController: presented, presenting: presenting)
//    }
//
//    // 设置谁负责动画
//    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//
//        isPresent = true
//
//        return self
//    }
//
//    // 设置负责消失动画
//    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//
//        isPresent = false
//        return self
//    }
//
//
//}


