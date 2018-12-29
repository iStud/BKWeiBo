//
//  BKOAuthController.swift
//  BKWeiBo
//
//  Created by bk.xiong on 2018/12/29.
//  Copyright © 2018 xiongbk. All rights reserved.
//

import UIKit


class BKOAuthController: UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white

        setUI()
        tabBarController?.tabBar.backgroundColor = UIColor.yellow
    }
    
    private func setUI() {
        
        view = webView
        title = "陆上竞技"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "退出", style: .plain, target: self, action: #selector(quitBtnClick))
    }
    

    lazy var webView: UIWebView = {
        
        let web = UIWebView()
        
        // 解决 iPhone x 出现 黑边问题
        // 原因是 黑边是因为scrollView发生了偏移。
        if #available(iOS 11.0, *) {
           web.scrollView.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
      
        
//        web.isOpaque = false
//        web.backgroundColor = UIColor.white
        return web
    }()
    
    @objc func quitBtnClick(){
        
        print(#function)
        dismiss(animated: true, completion: nil)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
