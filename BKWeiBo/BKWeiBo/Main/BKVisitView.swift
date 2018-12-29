//
//  BKVisitView.swift
//  BKWeiBo
//
//  Created by bk.xiong on 2018/12/26.
//  Copyright © 2018 xiongbk. All rights reserved.
//

import UIKit
import SnapKit

protocol VisitViewDelegate:NSObjectProtocol {
    
    func loginBtnClick()
    
    func registerBtnClick()
    
}


class BKVisitView: UIView {
    
    weak var delegate:VisitViewDelegate?
    

    override init(frame: CGRect) {
    
        super .init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setVisitInfo(isHome:Bool,imageName:String,message:String) {
        
        maskImageView.isHidden = !isHome
        iconImageView.image = UIImage(named: imageName)
        messageLabel.text = message
        cycleImageView.isHidden = !isHome
        
    }
    
    
    func setupUI() -> () {
        
        addSubview(maskImageView)
        addSubview(cycleImageView)
        addSubview(iconImageView)
        addSubview(messageLabel)
        addSubview(registerButton)
        addSubview(loginButton)
        
        
        cycleImageView.snp.makeConstraints { (make) in
            
            make.center.equalTo(self)
        }
        maskImageView.snp.makeConstraints { (make) in
            
            make.edges.equalTo(self)
        }
        
        iconImageView.snp.makeConstraints { (make) in
            
            make.center.equalTo(self)
        }
        
        messageLabel.snp.makeConstraints { (make) in
            
            make.top.equalTo(cycleImageView.snp.bottom)
            make.centerX.equalTo(cycleImageView)
            make.width.equalTo(224)
        }
        
        registerButton.snp.makeConstraints { (make) in
            
            make.top.equalTo(messageLabel.snp.bottom).offset(10)
            make.leading.equalTo(messageLabel)
            make.height.equalTo(35)
            make.width.equalTo(100)
        }
        
        loginButton.snp.makeConstraints { (make) -> Void in
            
            make.top.equalTo(registerButton)
            make.trailing.equalTo(messageLabel)
            make.size.equalTo(registerButton)
        }
        
    }

    // 动画视图
    lazy var cycleImageView: UIImageView = {
        
        let cycle = UIImageView(image: UIImage(named: "visitordiscover_feed_image_smallicon"))
        return cycle
    }()
    

    
    
    lazy var iconImageView : UIImageView = {
        
        let icon = UIImageView()
        
        return icon
    }()
    
    
    private lazy var messageLabel: UILabel = {
        
        let label = UILabel()
        label.text = "关注一些人，回这里看看有什么惊喜"
        label.textColor = UIColor.darkGray
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .center
        label.numberOfLines = 0
        
        return label
    }()
    
    //注册
    private lazy var registerButton: UIButton = {
        

        let button = UIButton()
        
        button.setTitle("注册", for: .normal)
        button.setTitleColor(UIColor.darkGray, for:.normal)
        button.setTitleColor(UIColor.orange, for: .highlighted)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.setBackgroundImage(UIImage(named: "common_button_white_disable"), for: .normal)
        button.setBackgroundImage(UIImage(named: "common_button_white_disable"), for: .highlighted)
        button.addTarget(self, action: #selector(register), for: .touchUpInside)
        
        return button
    }()
    
    //登录
    private lazy var loginButton:UIButton = {
        
        let button = UIButton()
        
        button.setTitle("登录", for: .normal)
        button.setTitleColor(UIColor.darkGray, for:.normal)
        button.setTitleColor(UIColor.orange, for: .highlighted)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.setBackgroundImage(UIImage(named: "common_button_white_disable"), for: .normal)
        button.setBackgroundImage(UIImage(named: "common_button_white_disable"), for: .highlighted)
        button.addTarget(self, action: #selector(login), for: .touchUpInside)

        return button
    }()
    
    // 遮盖视图
    lazy var maskImageView: UIImageView = {
        
        let mask = UIImageView(image: UIImage(named: "visitordiscover_feed_mask_smallicon"))
        
        return mask
    }()
    
    //开启动画
    func startAnimation() {
        
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        animation.toValue = 2 * Double.pi
        animation.repeatCount = MAXFLOAT
        animation.isRemovedOnCompletion = false
        cycleImageView.layer.add(animation, forKey: nil)
    }
    
    @objc func login() -> () {
        
        delegate?.loginBtnClick()
        
    }
    
   @objc func register() -> () {
        
        delegate?.registerBtnClick()
    }
}
