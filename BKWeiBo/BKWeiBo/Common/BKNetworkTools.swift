//
//  BKNetworkTools.swift
//  BKWeiBo
//
//  Created by bk.xiong on 2018/12/29.
//  Copyright © 2018 xiongbk. All rights reserved.
//

import UIKit
import AFNetworking

class BKNetworkTools: AFHTTPSessionManager {
    

    static let shareNetworkTools:BKNetworkTools = {
        
        let url = URL(string: "https://api.weibo.com/")
        let tools = BKNetworkTools(baseURL:url)
        tools.responseSerializer.acceptableContentTypes?.insert("text/plain")
        return tools
    }()
    

}
