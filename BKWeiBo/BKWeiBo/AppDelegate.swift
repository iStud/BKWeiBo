//
//  AppDelegate.swift
//  BKWeiBo
//
//  Created by bk.xiong on 2018/6/29.
//  Copyright © 2018年 xiongbk. All rights reserved.
//

import UIKit

let SwitchMainNotification = "SwitchMainNotification"

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let rootVc = defaultController()
        window?.rootViewController = rootVc;
        window?.makeKeyAndVisible()
        
        UINavigationBar.appearance().tintColor = UIColor.orange
        
        
        // 注册通知,切换控制器
        NotificationCenter.default.addObserver(self, selector: #selector(switchMainController(noti:)), name: Notification.Name(SwitchMainNotification), object: nil)

        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    // 检查版本
    func isNewVersion() -> Bool {
        
        // 当前版本
        let currentStr = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
//        let currentStr = "2.0"
        
        let version = Double(currentStr)!

//        print("当前版本" + currentStr)
        
        // 沙盒版本
        let versionKey = "versionKey"
        let sandboxVerson = UserDefaults.standard.double(forKey: versionKey)
        
        // 版本写入沙盒
        UserDefaults.standard.set(version, forKey: versionKey)
        
//        print("沙盒版本"+"\(sandboxVerson)")
        return version > sandboxVerson
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    
    // 通知切换控制器
    @objc func switchMainController(noti:Notification) {

        if noti.object as! Bool{
            
            window?.rootViewController = BKTabBarController()
            
        }else{
            
           window?.rootViewController = BKWelcomeController()
        }
        
    }
    
    // 设置默认控制器
    func defaultController() -> UIViewController {
        
        // 是否登录
        if BKUserCount.isLogin() {
            
            // 是否有新特性
            return isNewVersion() ? BKNewFeatureController():BKWelcomeController()
        }
        return BKTabBarController()
    }

}

