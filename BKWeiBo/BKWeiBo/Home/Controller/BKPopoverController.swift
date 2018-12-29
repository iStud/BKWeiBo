//
//  BKPopoverController.swift
//  BKWeiBo
//
//  Created by bk.xiong on 2018/12/26.
//  Copyright © 2018 xiongbk. All rights reserved.
//

import UIKit

class BKPopoverController: UIViewController,UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return titleGroup.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PopupCell", for: indexPath)
        cell.textLabel?.text = titleGroup[indexPath.row]
        cell.textLabel?.textColor = UIColor.white
        return cell

    }
    
    lazy var titleGroup:[String] = {
        
       return ["首页", "好友圈", "群微博", "我的微博"];
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    


}
