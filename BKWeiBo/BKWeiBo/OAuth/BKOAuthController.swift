//
//  BKOAuthController.swift
//  BKWeiBo
//
//  Created by bk.xiong on 2018/12/29.
//  Copyright © 2018 xiongbk. All rights reserved.
//

import UIKit
import AFNetworking

class BKOAuthController: UIViewController {
    
    //    App Key：3003757086
    //    App Secret：f96b489c33e676f78e4d5e772689aca7
    
    let appKey = "2332464734"
    let appSecret = "90823de42ee0dda927c57074e84f87ad"
    let redirect_uri = "https://nba.hupu.com"
    
    // App Key：2332464734
//    App Secret：90823de42ee0dda927c57074e84f87ad
//    https://nba.hupu.com
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        setUI()
        loadOauthPage()
        
    }
    
    func loadOauthPage() {
        
        
        let urlStr = "https://api.weibo.com/oauth2/authorize?client_id=\(appKey)&redirect_uri=\(redirect_uri)"
        let url = URL(string: urlStr)!
        let request =  URLRequest(url: url)
        webView.loadRequest(request)
        
    }
    
    
    private func setUI() {
        
        view = webView
        
        title = "陆上竞技"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "退出", style: .plain, target: self, action: #selector(quitBtnClick))
    }
    
    
    
    
    lazy var webView: UIWebView = {
        
        let web = UIWebView()
        web.delegate = self
        // 解决 iPhone x 出现 黑边问题
        //         原因是 黑边是因为scrollView发生了偏移。
        //        if #available(iOS 11.0, *) {
        //           web.scrollView.contentInsetAdjustmentBehavior = .never
        //        } else {
        //            automaticallyAdjustsScrollViewInsets = false
        //        }
        
        web.isOpaque = false
        web.backgroundColor = UIColor.white
        
        return web
    }()
    
    
    
    
    @objc func quitBtnClick(){
        
        print(#function)
        dismiss(animated: true, completion: nil)
    }
    
}

extension BKOAuthController:UIWebViewDelegate{
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
        
        print((request.url?.absoluteString)!)
        
        let urlStr = (request.url?.absoluteString)!
        if !urlStr.hasPrefix(redirect_uri) {
            
            return true
        }
        let query = (request.url?.query)!
        let queryPre = "code="
        if query.hasPrefix(queryPre){
            
            print("有授权码")
            // 取出 token
            let index = queryPre.endIndex
            let codeStr = String(query[index...])
            print("授权码"+codeStr)
            getAccessToken(code: codeStr)
            
        }else{
            
            print("没有授权码")
            quitBtnClick()
        }
        
        return false
    }
    
    // 通过授权码获取 token
    func getAccessToken(code:String) {
        
        let grant_type = "authorization_code"
        let code = code
        let dic = ["client_id":appKey,"client_secret":appSecret,"grant_type":grant_type,"code":code,"redirect_uri":redirect_uri]
        
        let url = "oauth2/access_token"
        
        
        // 获取 token 的请求
        BKNetworkTools.shareNetworkTools.post(url, parameters: dic, progress: nil, success: { (_, response) in
            
            print("response", response!)
            let account = BKUserCount(dict: response as! [String : AnyObject])
            account.loadUserInfo { (account, error) in
                
                if(account != nil){
                    
                    // 保存用户信息
                    account!.saveAccount()
                    NotificationCenter.default.post(name: Notification.Name(SwitchMainNotification), object: false)
                    
                    
                }else{
                    
                    print("网络错误")
                }
            }
            
            
        }) { (_, error) in
            
            print(error)
        }
        
        
    }
}
