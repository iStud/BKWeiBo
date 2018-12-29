//
//  BKBaseController.swift
//  BKWeiBo
//
//  Created by bk.xiong on 2018/12/26.
//  Copyright © 2018 xiongbk. All rights reserved.
//




import UIKit

class BKBaseController: UITableViewController ,VisitViewDelegate{
    

    var isLogin = false
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
        
        // 没有登录时的导航条
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "注册", style: UIBarButtonItemStyle.plain, target: self, action:#selector(registerBtnClick))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "登录", style: UIBarButtonItemStyle.plain, target: self, action:#selector(loginBtnClick))
        
        
    }
    


    
    // MARK: - VisitViewDelegate
    @objc func loginBtnClick() {
        
        print(#function)
        
        let oauthVC = BKOAuthController()
        let nav = UINavigationController(rootViewController: oauthVC)
        present(nav, animated: true, completion: nil)
        
        

    }
    
    @objc func registerBtnClick() {
        
        print(#function)
    }
    


    


}
