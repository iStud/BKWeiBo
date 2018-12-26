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
        addChildViewController(UIViewController())
        addChildVc(childController:BKDiscoverController(), imageName: "tabbar_discover", title: "发现")
        addChildVc(childController:BKMeController(), imageName: "tabbar_profile", title: "我")
        
        
    }
    
    func addChildVc(childController:UIViewController,imageName:String,title:String) -> Void {
        
        addChildViewController(childController)
        childController.tabBarItem.image = UIImage(named: imageName)
        childController.tabBarItem.selectedImage = UIImage(named: "\(imageName)_selected")
        childController.tabBarItem.title = title
        
        // 修改 tabbar 文字的颜色
        childController.tabBarItem.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.darkGray], for:.selected);
        
        // 添加导航控制器
        let nav = UINavigationController(rootViewController: childController)
        addChildViewController(nav)
    }
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
}
