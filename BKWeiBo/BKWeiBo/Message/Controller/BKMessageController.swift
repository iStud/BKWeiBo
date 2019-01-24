//
//  BKMessageController.swift
//  BKWeiBo
//
//  Created by bk.xiong on 2018/6/29.
//  Copyright © 2018年 xiongbk. All rights reserved.
//

import UIKit

class BKMessageController: BKBaseController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        
        if !isLogin {
            
            visitView?.setVisitInfo(isHome: false, imageName: "visitordiscover_image_message", message: "登录后，别人评论你的微博，发给你的消息，都会在这里收到通知")
        }
        self.tableView.estimatedRowHeight=50
        self.tableView.rowHeight=UITableViewAutomaticDimension
        tableView.register(BKMTableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 10
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView .dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! BKMTableViewCell
//        cell.textLabel?.text = "123"
        return cell
    }

}
