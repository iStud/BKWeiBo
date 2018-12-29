//
//  BKTabBarController.swift
//  BKWeiBo
//
//  Created by bk.xiong on 2018/6/29.
//  Copyright © 2018年 xiongbk. All rights reserved.
//

import UIKit

class BKTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChildVc(childController:BKHomeController(), imageName: "tabbar_home", title: "首页")
        addChildVc(childController:BKMessageController(), imageName: "tabbar_message_center", title: "消息")
        addChildVc(childController:BKComposeController(), imageName: "", title: "")
        addChildVc(childController:BKDiscoverController(), imageName: "tabbar_discover", title: "发现")
        addChildVc(childController:BKMeController(), imageName: "tabbar_profile", title: "我")
        
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
        
        // 添加加号按钮
        setupComposeButton()
    }
    
    
    func addChildVc(childController:UIViewController,imageName:String,title:String) -> Void {
        
        addChildViewController(childController)
        childController.tabBarItem.image = UIImage(named: imageName)
        childController.tabBarItem.selectedImage = UIImage(named: "\(imageName)_selected")
        childController.tabBarItem.title = title
        
        // 修改 tabbar 文字的颜色
        childController.tabBarItem.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.darkGray], for:.selected);
        childController.title = title
        
        // 添加导航控制器
        let nav = UINavigationController(rootViewController: childController)
        addChildViewController(nav)
    }
    
    // 懒加载创建撰写按钮
    lazy var composeBtn: UIButton = {
        
        let button = UIButton()
        
        button.setImage(UIImage(named: "tabbar_compose_icon_add"), for:.normal)
        button.setImage(UIImage(named: "tabbar_compose_icon_add_highlighted"), for: .highlighted)
        button.setBackgroundImage(UIImage(named: "tabbar_compose_button"), for: .normal)
        button.setBackgroundImage(UIImage(named: "tabbar_compose_button_highlighted"), for: .highlighted)

        button.addTarget(self,action:#selector(composeBtnClick),for:.touchUpInside)
        
        return button
    }()
    
    
    private func setupComposeButton()
    {
        tabBar.addSubview(composeBtn)
        
        // 1.计算按钮宽度
        let width = tabBar.bounds.width / CGFloat(viewControllers!.count)
        // 2.创建按钮frame
        let rect = CGRect(x: 0, y: 0, width: width, height: tabBar.bounds.height)
        // 3.设置偏移
        composeBtn.frame = rect.offsetBy(dx: width*2, dy: 0)
        
    }
    
    @objc func composeBtnClick() {
        
        print(#function)
    }
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
}
