//
//  BKStatuses.swift
//  BKWeiBo
//
//  Created by bk.xiong on 2019/1/8.
//  Copyright © 2019 xiongbk. All rights reserved.
//

import UIKit
import SDWebImage

class BKStatuses: NSObject {
    
    
//    lazy var rowHeight: CGFloat = {
//        
//        // 实例化 cell
//        let cell = BKStatusesCell(style:.default, reuseIdentifier: "imgCell")
//        
//        // 返回行高
//        return cell.rowHeigt(model: self)
//    }()
    
    /// 微博ID
    @objc var id:Int = 0
    /// 微博信息内容
    @objc var text:String?
    /// 微博创建时间
    @objc var created_at:String?{
        
        didSet{
            //            created_at = "Wed Nov 9 16:42:11 +0800 2018"
            let createdDate = Date.dateStr2Date(time: created_at!)
            created_at = createdDate.descDate
            
        }
        
    }
    /// 微博来源
    @objc var source:String?{
        
        didSet{
            
            //截取字符串
            // <a href="http://weibo.com/" rel="nofollow">iPhone客户端</a>
            if let str = source{
                
                if str == ""{
                    
                    return
                }
                //                String[Range<String.Index>]
                let start = str.range(of: ">")
                let end = str.range(of: "</")
                source = "来自 " + "\(str[start!.upperBound ..< end!.lowerBound])"
                
            }
        }
    }
    
    /// 图片数组
    @objc var pic_urls: [[String: AnyObject]]?{
        
        // 只要属性数值改变了,就把 URL字典中剥离,并保存
        didSet{
            
            urlArr = [URL]()
            for dic in pic_urls!{
                
                if let urlStr = dic["thumbnail_pic"]{
                    
                    urlArr?.append(URL(string: urlStr as! String)!)
                }
            }
        }
    }
    
    /// 图片 URL 数组
    var urlArr:[URL]?
    
    /// 用户模型
    @objc var user:BKUser?
    
    /// 转发微博的数据
    var retweetedStatus:BKStatuses?
    
    /// 转发微博 URL 数组
    // get 方法,计算属性
    var retweetUrlArr:[URL]?{
        
        return retweetedStatus != nil ? retweetedStatus?.urlArr : urlArr
    }
    
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

            // 缓存图片
            cacheImage(modelArr: modelArr, finish: finish)
//            finish(modelArr,nil)
            
            
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
    
    override func setValue(_ value: Any?, forKey key: String) {
        
        if "user" == key {
            
            user = BKUser(dict: value as! [String:Any])
            
            return
        }
        
        if "retweeted_status" == key {
            
            retweetedStatus = BKStatuses(dict: value as! [String:Any])
        }
        
        super.setValue(value, forKey: key)
    }
    
    // 缓存图片
    class func cacheImage(modelArr:[BKStatuses],finish:@escaping (_ modelArr:[BKStatuses]?,_ error:Error?)->()) {
        
        // 创建组
        let group = DispatchGroup()
        
        // 遍历模型数组
        for dic in modelArr{
            
            if dic.retweetUrlArr == nil{
                
                continue
            }
            
            // 已经提前把 url 从字典中取出了
            for url in dic.retweetUrlArr!{
                
                group.enter()
                
                // 使用 sdwebimage 缓存图片
                SDWebImageManager.shared().imageDownloader?.downloadImage(with: url, options: SDWebImageDownloaderOptions(rawValue: 0), progress: nil, completed: { (_, _, _, _) in
                    
//                    print(url)
                    group.leave()
                })
            }
            
        }
        
        // 通知组
        group.notify(queue: DispatchQueue.main) {
            
//            print("结束缓存")
            finish(modelArr,nil)
        }
        
    }
    
    
    
    
    var properties = ["created_at", "id", "text", "source","pic_urls","user"]
    override var description: String{
        
        let dic = dictionaryWithValues(forKeys: properties)
        return "\(dic)"
    }
}
