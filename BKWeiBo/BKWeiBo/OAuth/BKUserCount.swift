//
//  BKUserCount.swift
//  BKWeiBo
//
//  Created by bk.xiong on 2019/1/2.
//  Copyright © 2019 xiongbk. All rights reserved.
//

import UIKit
import Foundation

class BKUserCount: NSObject,NSCoding{
    
    
    
    // swift 4 必须加上 @objc
    @objc var access_token:String!
    @objc var uid:String!
    
    // token的生命周期
    @objc var expires_in:NSNumber!
    
    // 保存用户的过期时间
    @objc var expiresDate:Date?
    // 用户名称
    @objc var name:String?
    // 用户头像
    @objc var avatar_large:String?
    
    init(dict: [String: AnyObject]) {
        
        super.init()
    
        access_token = dict["access_token"] as? String
        expires_in = dict["expires_in"] as? NSNumber
        uid = dict["uid"] as? String
        expiresDate = Date(timeIntervalSinceNow: expires_in as! TimeInterval)
    }
    
    // 重写 description 方法,目的是打印对象的属性
    override var description: String{

        let info = ["access_token", "expires_in", "uid","expiresDate","name","avatar_large"]
        let dic = dictionaryWithValues(forKeys: info)
        return "\(dic)"
    }
    
    
    // 归档
    func encode(with aCoder: NSCoder) {
        
        aCoder.encode(access_token, forKey: "access_token")
        aCoder.encode(expires_in as! Double, forKey: "expires_in")
        aCoder.encode(uid, forKey: "uid")
        aCoder.encode(expiresDate, forKey: "expiresDate")
        aCoder.encode(name, forKey: "name")
        aCoder.encode(avatar_large, forKey: "avatar_large")
    }
    
    override init() {
    
    }
    
    // 解档
    required init?(coder aDecoder: NSCoder) {

        access_token = aDecoder.decodeObject(forKey: "access_token") as? String
        expires_in = aDecoder.decodeDouble(forKey: "expires_in") as NSNumber
        uid = aDecoder.decodeObject(forKey: "uid") as? String
        expiresDate = (aDecoder.decodeObject(forKey: "expiresDate") as! Date)
        name = aDecoder.decodeObject(forKey: "name") as? String
        avatar_large = aDecoder.decodeObject(forKey: "avatar_large") as? String
    }
    

    // 保存用户信息
    static let encodePath = "user.plist".docDir()
    func saveAccount() {
        
        NSKeyedArchiver.archiveRootObject(self, toFile: BKUserCount.encodePath)

    }
    
    // 读取用户信息
    
    class func loadAccount() -> BKUserCount?{
        
        let account = NSKeyedUnarchiver.unarchiveObject(withFile: encodePath) as? BKUserCount
        if (account != nil) {
            
            if account?.expiresDate?.compare(Date()) == ComparisonResult.orderedDescending {

                return account
            }
        }
        return nil
        
    }
    
    // 类方法,判断是否登录
    class func isLogin() -> Bool {
        
        return BKUserCount.loadAccount() != nil
    }
    
    // 加载用户信息
    func loadUserInfo(finished:@escaping(BKUserCount?,Error?)->()) {
        
        let url = "2/users/show.json"
        let uidValue = Int(uid)!
        let token = access_token!

        let params = ["access_token":token,"uid":uidValue] as [String : Any]
    
        BKNetworkTools.shareNetworkTools.get(url, parameters: params, progress: nil, success: { (_, json) in
            
            let dic = json as! [String:Any]
            self.name = dic["name"] as? String
            self.avatar_large = dic["avatar_large"] as? String
            finished(self,nil)
            
        }) { (_, error) in
            
            print(error)
            finished(nil,error)
        }
       
    }
    
    
}
