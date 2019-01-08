//
//  BKStatuses.swift
//  BKWeiBo
//
//  Created by bk.xiong on 2019/1/8.
//  Copyright © 2019 xiongbk. All rights reserved.
//

import UIKit

class BKStatuses: NSObject {
    
    /// 微博ID
    @objc var id:Int = 0
    /// 微博信息内容
    @objc var text:String?
    /// 微博创建时间
    @objc var created_at:String?
    /// 微博来源
    @objc var source:String?
    
    init(dict:[String:Any]) {
        
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
       
    }
    
//    override func setValue(_ value: Any?, forKey key: String) {
//        super.setValue(value, forKey: key)
//    }
    
    class func loadData(finish:@escaping (_ modelArr:[BKStatuses]?,_ error:Error?)->()) {
        
        let url = "2/statuses/home_timeline.json"
        let token = BKUserCount.loadAccount()?.access_token
        let dic = ["access_token":token]
        BKNetworkTools.shareNetworkTools.get(url, parameters: dic, progress: nil, success: { (_, json) in
            
            // 字典转模型
            let result = json as![String:Any]
            let modelArr = dic2Model(list: result["statuses"] as! [[String : Any]])
            finish(modelArr,nil)
            print(modelArr)
            
        }) { (_, error) in
            
            print(error)
            finish(nil,error)
        }
    }
    
    // 字典转模型
   class func dic2Model(list:[[String:Any]]) -> [BKStatuses] {
        
        var modelArr = [BKStatuses]()
    
        // 遍历字典数组
        for dic in list {
            
            modelArr.append(BKStatuses(dict:dic))
        }
        return modelArr
    }
    
    var properties = ["created_at", "id", "text", "source"]
    override var description: String{

        let dic = dictionaryWithValues(forKeys: properties)
        return "\(dic)"
    }
}
