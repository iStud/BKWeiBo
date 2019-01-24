//
//  BKRetweetCell.swift
//  BKWeiBo
//
//  Created by bk.xiong on 2019/1/23.
//  Copyright © 2019 xiongbk. All rights reserved.
//

import UIKit

class BKRetweetCell: BKStatusesCell {
    
    
    override var statuses: BKStatuses?{
        
        didSet{
            
            let text = statuses?.retweetedStatus?.text ?? ""
            let name = statuses?.retweetedStatus?.user?.name ?? ""
            retweetLabel.text = "@" + name + ": " + text
        }
    }
    
    override func setupUI() {
        super.setupUI()
        
    
        contentView.insertSubview(backButton, belowSubview:pictureView)
        contentView.insertSubview(retweetLabel, aboveSubview: backButton)
        
        backButton.snp.makeConstraints { (make) in
            
            make.top.equalTo(contentLabel.snp.bottom)
            make.left.right.equalTo(contentView)
            make.bottom.equalTo(bottomBar.snp.top)

        }
        
        retweetLabel.snp.makeConstraints { (make) in

            make.left.equalTo(10)
            make.top.equalTo(backButton).offset(10)
        }
        
        pictureView.snp.makeConstraints { (make) in
            
            make.top.equalTo(retweetLabel.snp.bottom).offset(10)
            make.left.equalTo(10)
            make.size.equalTo(CGSize(width: 0.0, height: 0.0))
        }
        
        
        
    }
    
    // 灰色背景图
    lazy var backButton: UIButton = {
        
        let btn = UIButton()
        btn.backgroundColor = UIColor.init(white: 0.9, alpha: 1.0)
        return btn
        
    }()
    
    // 正文
    lazy var retweetLabel: UILabel = {
        let content = UILabel()
        content.text = "转发微博转发微博转发微博转发微博转发微博转发微博转发微博"
        content.numberOfLines = 0
        content.preferredMaxLayoutWidth = UIScreen.main.bounds.width - 20
        return content
    }()
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
