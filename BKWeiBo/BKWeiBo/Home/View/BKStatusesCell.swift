//
//  BKStatusesCell.swift
//  BKWeiBo
//
//  Created by bk.xiong on 2019/1/8.
//  Copyright © 2019 xiongbk. All rights reserved.
//

import UIKit

class BKStatusesCell: UITableViewCell {
    
    // designated
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        
        contentView.addSubview(headView)
        contentView.addSubview(varifyView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(mBrankView)
        contentView.addSubview(timeLabel)
        contentView.addSubview(sourceLabel)
        
        contentView.addSubview(contentLabel)
        contentLabel.numberOfLines = 0
        
        contentView.addSubview(reposeBtn)
        contentView.addSubview(commentBtn)
        contentView.addSubview(likeBtn)
        
        headView.snp.makeConstraints { (make) in
            
            make.top.left.equalTo(10)
            make.size.equalTo(CGSize(width: 30, height: 30))
        }
        
        varifyView.snp.makeConstraints { (make) in
            
            make.left.equalTo(headView.snp.right).offset(-10)
            make.top.equalTo(headView.snp.bottom).offset(-10)
            make.size.equalTo(CGSize(width: 15, height: 15))
        }
        
        nameLabel.snp.makeConstraints { (make) in
            
            make.top.equalTo(headView)
            make.left.equalTo(headView.snp.right).offset(10)
        }
        
        mBrankView.snp.makeConstraints { (make) in
            
            make.centerY.equalTo(nameLabel)
            make.left.equalTo(nameLabel.snp.right).offset(5)
            make.size.equalTo(CGSize(width: 13, height: 13))
        }
        
        timeLabel.snp.makeConstraints { (make) in
            
            make.top.equalTo(nameLabel.snp.bottom).offset(2)
            make.left.equalTo(nameLabel)
        }
        
        sourceLabel.snp.makeConstraints { (make) in
            
            make.top.equalTo(timeLabel)
            make.left.equalTo(timeLabel.snp.right).offset(10)
        }
        
        contentLabel.snp.makeConstraints { (make) in
            
            make.top.equalTo(timeLabel.snp.bottom).offset(5)
            make.left.equalTo(headView)
            make.right.equalTo(contentView.snp.right).offset(-10)
        }
        
        reposeBtn.snp.makeConstraints { (make) in
            
            make.left.equalTo(contentLabel)
            make.top.equalTo(contentLabel.snp.bottom).offset(5)
            make.width.equalTo((UIScreen.main.bounds.size.width-10)/3)
            make.bottom.equalTo(contentView.snp.bottom).offset(-5)
        }
        
        commentBtn.snp.makeConstraints { (make) in
            
            make.left.equalTo(reposeBtn.snp.right)
            make.top.equalTo(reposeBtn)
            make.width.equalTo(reposeBtn)
            make.bottom.equalTo(reposeBtn)
        }
        
        likeBtn.snp.makeConstraints { (make) in

            make.left.equalTo(commentBtn.snp.right)
            make.top.equalTo(commentBtn)
            make.width.equalTo(commentBtn)
            make.bottom.equalTo(commentBtn)
        }
        
        
    }
    
    lazy var headView: UIImageView = {
        
        let imageView = UIImageView()
//        imageView.sizeToFit()
        imageView.image = UIImage(named: "avatar_default_big")
        return imageView
    }()
    
    lazy var nameLabel: UILabel = UILabel.createLabel(lableTextFont: 14, labelTextColor: UIColor.black)

    
    lazy var timeLabel: UILabel = UILabel.createLabel(lableTextFont: 12, labelTextColor: UIColor.lightGray)
    
    lazy var sourceLabel: UILabel = UILabel.createLabel(lableTextFont: 12, labelTextColor: UIColor.lightGray)
    
    
    lazy var contentLabel: UILabel = UILabel.createLabel(lableTextFont: 15, labelTextColor: UIColor.black)

    
    
    lazy var reposeBtn: UIButton = UIButton.createButton(buttonName: "转发", font: 13, titleColor: UIColor.darkGray,imageName: "timeline_icon_retweet")

    
    lazy var commentBtn: UIButton = UIButton.createButton(buttonName: "评论", font: 13, titleColor: UIColor.darkGray,imageName: "timeline_icon_comment")
    
    lazy var likeBtn: UIButton = UIButton.createButton(buttonName: "喜欢", font: 13, titleColor: UIColor.darkGray,imageName:"timeline_icon_unlike")
    
    lazy var varifyView: UIImageView = {
        let view = UIImageView()
        view.sizeToFit()
        view.image = UIImage(named: "avatar_vip")
        return view
    }()
    
    lazy var mBrankView: UIImageView = {
        
        let menber = UIImageView()
        return menber
    }()
    
    
    var statuses:BKStatuses?{
        
        didSet{
            
            contentLabel.text = statuses!.text
            sourceLabel.text = statuses?.source
            timeLabel.text = statuses?.created_at
            nameLabel.text = statuses?.user?.name
            varifyView.image = statuses?.user?.varifiImage
            mBrankView.image = statuses?.user?.mbrankImage
            if  let url = statuses?.user?.imageUrl{
        
                headView.sd_setImage(with: url)
            }
            
            
//            layoutIfNeeded()
//            
//            statuses?.rowHeight = Float(reposeBtn.frame.maxY + 5)
//            print(statuses?.rowHeight as Any)
            
        }
    }
    

}
