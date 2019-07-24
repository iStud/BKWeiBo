//
//  BKComposeController.swift
//  BKWeiBo
//
//  Created by bk.xiong on 2018/6/29.
//  Copyright © 2018年 xiongbk. All rights reserved.
//

import UIKit

let kScreenWidth = UIScreen.main.bounds.size.width
let kScreenHeight = UIScreen.main.bounds.size.height
let isPhoneX = Bool(kScreenWidth >= 375.0 && kScreenHeight >= 812.0)
let kBottomSafeHeight = CGFloat(isPhoneX ? 34 : 0)


class BKComposeController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        
        setNav()
        setupToolbar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        textView.becomeFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewDidDisappear(animated)
        
        textView.resignFirstResponder()
    }
    
    // 设置导航栏
    private func setNav() {
        
        // 左按钮
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "取消", style: .plain, target: self, action: #selector(cancel))
        
        // 右按钮
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "发送", style: .plain, target: self, action: #selector(send))
        navigationItem.rightBarButtonItem?.isEnabled = false
        
        // 标题
        let titleView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 40))
   
        let titleLabel = UILabel()
        titleView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            
            make.top.equalTo(titleView)
            make.centerX.equalTo(titleView)
        }
        titleLabel.text = "发微博"

        let nameLabel = UILabel();
        titleView.addSubview(nameLabel)
        nameLabel.text = "莲华"
        nameLabel.font = UIFont.systemFont(ofSize: 14)
        nameLabel.textColor = UIColor.lightGray
        nameLabel.snp.makeConstraints { (make) in
            
            make.top.equalTo(titleLabel.snp_bottom)
            make.centerX.equalTo(titleView)
        }
        navigationItem.titleView = titleView
        
        
        // 输入框
        view.addSubview(textView)
        textView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
        // 占位符
        textView.addSubview(placeholderLabel)
        placeholderLabel.snp.makeConstraints { (make) in
            make.left.equalTo(5)
            make.top.equalTo(8)
        }
    }
    
    // 设置工具栏
    func setupToolbar() {
        
        view.addSubview(toolbar)
        var items = [UIBarButtonItem]()
        let itemSettings = [["imageName": "compose_toolbar_picture", "action": "selectPicture"],
                            
                            ["imageName": "compose_mentionbutton_background"],
                            
                            ["imageName": "compose_trendbutton_background"],
                            
                            ["imageName": "compose_emoticonbutton_background", "action": "inputEmoticon"],
                            
                            ["imageName": "compose_addbutton_background"]]
        
        
        for dict in itemSettings {
            
            let item = UIBarButtonItem(imageName: dict["imageName"]!, taget: self, action:dict["action"])
            items.append(item)
            items.append(UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil))
        }
        items.removeLast()
        toolbar.items = items
        
        toolbar.snp.makeConstraints { (make) in
            
            make.width.equalTo(view)
            make.height.equalTo(44)
            make.bottom.equalTo(view.snp_bottom).offset(-kBottomSafeHeight)
        }
    }
    
    @objc func selectPicture() {
        
        print("图片")
    }
    
    @objc func inputEmoticon() {
        
        print("emoji")
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    @objc func cancel() {
        
        dismiss(animated: true, completion: nil)
    }

    // 发微博 使用的是 第三方分享接口
    @objc func send(){
        
        let url = "2/statuses/share.json"
        let access_token = BKUserCount.loadAccount()?.access_token!
        let status = textView.text + "https://www.baidu.com/"
        let param = ["access_token":access_token,"status":status]
        
        BKNetworkTools.shareNetworkTools.post(url, parameters: param, progress: nil, success: { (_, json) in
            
            print(json as Any)
            
        }) { (_, error) in
            
            print(error)
        }
    }
    
    
    lazy var textView: UITextView = {
        
        let textView = UITextView()
        textView.delegate = self
        textView.alwaysBounceVertical = true
        textView.keyboardDismissMode = UIScrollViewKeyboardDismissMode.onDrag
        return textView
    }()
    
    lazy var placeholderLabel: UILabel = {
        
        let label = UILabel()
        label.text = "分享新鲜事...."
        label.textColor = UIColor.lightGray
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    
    lazy var toolbar:UIToolbar = UIToolbar()

}

extension BKComposeController:UITextViewDelegate{
    
    func textViewDidChange(_ textView: UITextView) {
        
        placeholderLabel.isHidden = textView.hasText
        navigationItem.rightBarButtonItem?.isEnabled = textView.hasText
    }
}
