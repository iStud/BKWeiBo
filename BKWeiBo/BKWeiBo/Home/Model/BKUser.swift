//
//  BKUser.swift
//  BKWeiBo
//
//  Created by bk.xiong on 2019/1/8.
//  Copyright © 2019 xiongbk. All rights reserved.
//

import UIKit

class BKUser: NSObject {
    
    /// 用户UID
    @objc var id:Int = 0
    
    /// 友好显示名称
    @objc var name:String?
    
    /// profile_image_url
    @objc var profile_image_url:String?{
        
        didSet{
            
            if let url = profile_image_url {
                
                imageUrl = URL(string:url)
            }
        }
    }
    
    /// 头像 URL
    @objc var imageUrl:URL?
    
    /// 认证信息 -1：没有认证，0，认证用户，2,3,5,7: 企业认证，220: 达人
    @objc var verified_type:Int = -1
    
    /// 认证头像
    @objc var varifiImage:UIImage?{
        
        switch verified_type{
        case 0:
            return UIImage(named: "avatar_vip")
        case 2, 3, 5,7:
            return UIImage(named: "avatar_enterprise_vip")
        case 220:
            return UIImage(named: "avatar_grassroot")
        default:
            return nil
        }
       
    }
    
    /// 是否是微博认证用户
    @objc var verified:Bool = false
    

    
//    /// 会员
    @objc var mbrank:Int = 0

    /// 会员头像
    var mbrankImage:UIImage?{

        if mbrank > 0 && mbrank < 7 {

            return UIImage(named: "common_icon_membership_level\(mbrank)")

        }else{
            return nil
        }
    }
    
    
    init(dict:[String:Any]) {
        
        super.init()
        
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
    let properties = ["id","name","profile_image_url","verified","verified_type","mbrank"]
    
    override var description: String{
        
        let dict = dictionaryWithValues(forKeys: properties)
        
        return "\(dict)"
        
    }

}
