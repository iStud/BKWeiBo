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
            lageUrlArr = [URL]()
            for dic in pic_urls!{
                
                if let urlStr = dic["thumbnail_pic"] as? String{
                    
                    // 小图
                    urlArr?.append(URL(string: urlStr)!)
                    
                    // 大图
                    let largeUrlStr = urlStr.replacingOccurrences(of:"thumbnail", with:"large")
                    lageUrlArr?.append(URL(string: largeUrlStr)!)
                }
            }
        }
    }
    
    /// 原创微博 图片 URL 数组
    var urlArr:[URL]?
    
    /// 原创微博图片大图数组
    var lageUrlArr:[URL]?
    
    /// 用户模型
    @objc var user:BKUser?
    
    /// 转发微博的数据
    var retweetedStatus:BKStatuses?
    
    /// 转发微博 URL 数组
    var retweetUrlArr:[URL]?{
        
        return retweetedStatus != nil ? retweetedStatus?.urlArr : urlArr
    }
    
    /// 转发微博中的大图数组
    var retweetLargeUrlArr:[URL]?{
    
        return retweetedStatus != nil ? retweetedStatus?.lageUrlArr : lageUrlArr
    }
    
    init(dict:[String:Any]) {
        
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
    class func loadData(since_id:Int,max_id:Int,finish:@escaping (_ modelArr:[BKStatuses]?,_ error:Error?)->()) {
        
        let url = "2/statuses/home_timeline.json"
        let token = BKUserCount.loadAccount()?.access_token
        var dic = ["access_token":token]
        
        // 下拉刷新
        if since_id > 0 {
            
            dic["since_id"] = "\(since_id)"
        }
        
        if max_id > 0 {
            
            dic["max_id"] = "\(max_id - 1)"
        }
        
        
        BKNetworkTools.shareNetworkTools.get(url, parameters: dic, progress: nil, success: { (_, json) in
            
            // 字典转模型
            let result = json as![String:Any]
            let modelArr = dic2Model(list: result["statuses"] as! [[String : Any]])

            // 缓存图片
//            cacheImage(modelArr: modelArr, finish: finish)
            cachePhoto()
            finish(modelArr,nil)
            
            
        }) { (_, error) in
            
            print(error)
            finish(nil,error)
        }
    }
    
    class func cachePhoto() {
        
        
        let arr = ["http://wx1.sinaimg.cn/thumbnail/de9ecd0bly1g09sh6qg0dj20k03icdn9.jpg"
            ,"http://wx2.sinaimg.cn/thumbnail/6acb4f71ly1fwmpzhftvgg20m80cnkjo.gif"
            ,"http://wx1.sinaimg.cn/thumbnail/718878b5ly1g0cq0xt098j20ri84fx6q.jpg"
            ,"http://wx1.sinaimg.cn/thumbnail/006qmtKlly1g0bz1i9dk4j30j60cj0wy.jpg"
            ,"http://wx1.sinaimg.cn/thumbnail/64743272gy1g0cy6d5jl1j20dm0kaqir.jpg","http://wx2.sinaimg.cn/thumbnail/8854705agy1g0503huoqkg208c058e81.gif"
        ]
        
        for str in arr{
            
            SDWebImageManager.shared().imageDownloader?.downloadImage(with: URL(string: str)!, options: SDWebImageDownloaderOptions(rawValue: 0), progress: nil, completed: { (_, _, _, _) in
                
//                print("12333")
            })
            

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
        
        // 没有刷新到新的数据的时候调用
        if modelArr.count == 0 {
            
            finish(modelArr,nil)
            return
        }
        
        // 创建组
//        let group = DispatchGroup.init()

        // 遍历模型数组
        for dic in modelArr{
            
            // 转发微博
            if dic.retweetUrlArr == nil{

                continue
            }
            
            
            // 已经提前把 url 从字典中取出了
            for url in dic.retweetUrlArr!{
                
//                group.enter()
                
                // 使用 sdwebimage 缓存图片
                SDWebImageManager.shared().imageDownloader?.downloadImage(with: url, options: SDWebImageDownloaderOptions(rawValue: 0), progress: nil, completed: { (_, _, _, _) in
                    
                    print(url)
//                    group.leave()
                })
            }
            
        }
        
        // 通知组
//        group.notify(queue: DispatchQueue.main) {
//
//            print("结束缓存")
//            print("doc".docDir())
//            finish(modelArr,nil)
//        }
        
    }
    

    
    
    var properties = ["created_at", "id", "text", "source","pic_urls","user"]
    override var description: String{
        
        let dic = dictionaryWithValues(forKeys: properties)
        return "\(dic)"
    }
}
