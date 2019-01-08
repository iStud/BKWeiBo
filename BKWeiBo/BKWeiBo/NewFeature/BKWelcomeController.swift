//
//  BKWelcomeController.swift
//  BKWeiBo
//
//  Created by bk.xiong on 2019/1/7.
//  Copyright © 2019 xiongbk. All rights reserved.
//

import UIKit
import SnapKit
import SDWebImage


class BKWelcomeController: UIViewController {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        let urlStr = BKUserCount.loadAccount()?.avatar_large
        let url = URL(string: urlStr!)
        
        if (url != nil) {
            
            headView.sd_setImage(with: url)
        
        }

    }
    
    func setupUI() {
        
        // 背景
        view.addSubview(backgroundView)
        
        // 头像
        view.addSubview(headView)
        
        // 文字
        view.addSubview(welocmeLabel)
        
        backgroundView.snp.makeConstraints({ (make) in
            
            make.edges.equalTo(view)
        })
        
        headView.snp.makeConstraints({ (make) in
            
            make.centerX.equalTo(view)
            make.top.equalTo(50)
            make.size.equalTo(CGSize(width: 100, height: 100))
        })
        
        welocmeLabel.snp.makeConstraints { (make) in
            
            make.centerX.equalTo(view)
            make.bottom.equalTo(headView.snp.bottom).offset(50)
        }
    }

    lazy var backgroundView: UIImageView = {
        
        let backView = UIImageView()
        backView.image = UIImage(named:"ad_background")
        return backView
        
    }()
    
    lazy var headView: UIImageView = {
        
        let head = UIImageView()
        head.image = UIImage(named: "avatar_default_big")
        head.layer.cornerRadius = 50
        head.layer.masksToBounds = true
        return head
    }()
    
    lazy var welocmeLabel: UILabel = {
        
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.text = "欢迎回来"
        return label
    }()
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        
        NotificationCenter.default.post(name: Notification.Name(SwitchMainNotification), object: true)
    }
}
