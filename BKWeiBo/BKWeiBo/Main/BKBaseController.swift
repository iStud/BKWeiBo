//
//  BKBaseController.swift
//  BKWeiBo
//
//  Created by bk.xiong on 2018/12/26.
//  Copyright © 2018 xiongbk. All rights reserved.
//

import UIKit

class BKBaseController: UITableViewController ,VisitViewDelegate{
    

    var isLogin = true
    var visitView:BKVisitView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        isLogin ? super.loadView() :setVisitView()
        

    }
    
    // MARK: - 设置UI
    
    func setVisitView()  {
        
        visitView = BKVisitView()
        // 设置代理
        visitView?.delegate = self
        view = visitView
        
        setNavItem()
        
    }
    
    func setNavItem() {
        
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "注册", style: UIBarButtonItemStyle.plain, target:nil, action:#selector(registerBtnClick))
//        navigationItem.leftBarButtonItem?.tintColor = UIColor.orange
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "登录", style: UIBarButtonItemStyle.plain, target: nil, action:#selector(loginBtnClick))
//        navigationItem.rightBarButtonItem?.tintColor = UIColor.orange
        

    }

    
    // MARK: - VisitViewDelegate
    @objc func loginBtnClick() {
        
        print(#function)
    }
    
    @objc func registerBtnClick() {
        
        print(#function)
    }
    


}
