//
//  BKStatusesCell.swift
//  BKWeiBo
//
//  Created by bk.xiong on 2019/1/8.
//  Copyright © 2019 xiongbk. All rights reserved.
//

import UIKit
import SDWebImage
import SnapKit

let CellReuseIdentifier = "CellReuseIdentifier"


enum statusCellIdentifier:String {
    
    case NormalCell = "NormalCell"
    case RetweetCell = "RetweetCell"
    
    static func cellID(status:BKStatuses) -> String{
        
        return status.retweetedStatus != nil ? RetweetCell.rawValue:NormalCell.rawValue
    }
}

class BKStatusesCell: UITableViewCell {
    
   
    var values:BKStatuses?
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
        
        // 初始化配图
        setupPictureView()
    }
    
    
    func getHeight(model:BKStatuses) -> CGFloat {
        
        self.statuses = model
        self.layoutIfNeeded()
        return  bottomBar.frame.maxY
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        
        // 头像
        contentView.addSubview(headView)
        // 认证 VIP
        contentView.addSubview(varifyView)
        // 名称
        contentView.addSubview(nameLabel)
        // 会员
        contentView.addSubview(mBrankView)
        // 时间
        contentView.addSubview(timeLabel)
        // 来源
        contentView.addSubview(sourceLabel)

        // 内容
        contentView.addSubview(contentLabel)
        
        // 图片
        contentView.addSubview(pictureView)

        // 底部工具条
        contentView.addSubview(bottomBar)
        
        
        // MARK: - 布局UI
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
            
            make.top.equalTo(headView.snp.bottom).offset(10)
            make.left.equalTo(headView.snp.left)
            make.right.equalTo(-10)

        }
        
//        pictureView.snp.makeConstraints { (make) in
//
//            make.top.equalTo(contentLabel.snp.bottom).offset(10)
//            make.left.equalTo(10)
//            make.size.equalTo(CGSize(width: 90.0, height: 300.0))
//        }


        bottomBar.snp.makeConstraints({make in
            
            make.top.equalTo(pictureView.snp.bottom).offset(10)
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.height.equalTo(44)
//            make.bottom.equalTo(contentView.snp.bottom)
            
        })
        
    }
    
    
    private func setupPictureView()
    {
        // 1.注册cell
        pictureView.register(PictureViewCell.self, forCellWithReuseIdentifier: "imgCell")
        
        // 2.设置数据源
        pictureView.dataSource = self
        
        // 2.设置cell之间的间隙
        pictureLayout.minimumInteritemSpacing = 10
        pictureLayout.minimumLineSpacing = 10
        pictureView.backgroundColor = UIColor.white

    }
    
    
    
    
    
    // MARK: - 懒加载控件
    lazy var headView: UIImageView = {
        
        let imageView = UIImageView()
        imageView.image = UIImage(named: "avatar_default_big")
        return imageView
    }()
    
    lazy var nameLabel: UILabel = UILabel.createLabel(lableTextFont: 14, labelTextColor: UIColor.black)
    
    
    lazy var timeLabel: UILabel = UILabel.createLabel(lableTextFont: 12, labelTextColor: UIColor.lightGray)
    
    lazy var sourceLabel: UILabel = UILabel.createLabel(lableTextFont: 12, labelTextColor: UIColor.lightGray)
    
    lazy var contentLabel: UILabel = {
        
        let content = UILabel()
        content.numberOfLines = 0
        content.preferredMaxLayoutWidth = UIScreen.main.bounds.width - 20
        return content
    
    }()
    

    
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
    
    /// 配图
    lazy var pictureLayout: UICollectionViewFlowLayout =  UICollectionViewFlowLayout()
    lazy var pictureView: UICollectionView = UICollectionView(frame: CGRect.zero , collectionViewLayout: pictureLayout)
    
    /// 底部工具条
    lazy var bottomBar:BottomBar={
        
        let bottomBar = BottomBar()
        bottomBar.backgroundColor=UIColor.white
        return bottomBar
        
    }()
    
    // MARK: - 计算配图尺寸
    private func calculateImageSize() -> (viewSize: CGSize, itemSize: CGSize)
    {
        // 1.取出配图个数

        
        let count = values?.urlArr?.count
        // 2.如果没有配图zero
        if count == 0 || count == nil
        {
            return (CGSize.zero, CGSize.zero)
        }
        // 3.如果只有一张配图, 返回图片的实际大小
        if count == 1
        {
            
            let key = values?.urlArr!.first?.absoluteString
            let image = SDWebImageManager.shared().imageCache?.imageFromCache(forKey: key)

//            print("一张图")
//            print("\(image!.size)")
            
            return (image?.size ?? CGSize(width: 0, height: 0) , image?.size ?? CGSize(width: 0, height: 0))
           
        }
        // 4.如果有4张配图, 计算田字格的大小
        let width = 90
        let margin = 10
        if count == 4
        {
            let viewWidth = width * 2 + margin
//            print("4张图")
//            print("\(viewWidth)")
            return (CGSize(width: viewWidth, height: viewWidth), CGSize(width: width, height: width))
        }
        

        let colNumber = 3
   
        let rowNumber = (count! - 1) / 3 + 1
        // 宽度 = 列数 * 图片的宽度 + (列数 - 1) * 间隙
        let viewWidth = colNumber * width + (colNumber - 1) * margin
        // 高度 = 行数 * 图片的高度 + (行数 - 1) * 间隙
        let viewHeight = rowNumber * width + (rowNumber - 1) * margin
        
//        print("多张图")
//        print("\(viewHeight)")
        
        return (CGSize(width: viewWidth, height: viewHeight), CGSize(width: width, height: width))
  
        
    }
    
    
    

    
    var statuses:BKStatuses?{
        
        didSet{
            
            values = statuses?.retweetedStatus != nil ? statuses?.retweetedStatus : statuses
            
//            print(statuses?.retweetedStatus)
            
            contentLabel.text = statuses!.text
            sourceLabel.text = statuses?.source
            timeLabel.text = statuses?.created_at
            nameLabel.text = statuses?.user?.name
            varifyView.image = statuses?.user?.varifiImage
            mBrankView.image = statuses?.user?.mbrankImage
            
            
            
            if  let url = statuses?.user?.imageUrl{
                
                headView.sd_setImage(with: url)
            }
            
            let size = calculateImageSize()
            
            pictureLayout.itemSize.width = size.itemSize.width
            pictureLayout.itemSize.height = size.itemSize.height
            pictureView.snp.updateConstraints { (make) in
                
                make.size.equalTo(size.viewSize)
//                make.height.equalTo(size.viewSize.height)
            }
            pictureView.reloadData()
          

        }
    }
    
    
   
    
}



class PictureViewCell: UICollectionViewCell {
    
    // 定义属性接收外界传入的数据
    var imageURL: URL?
    {
        didSet{
            iconImageView.sd_setImage(with:imageURL)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // 初始化UI
        setupUI()
    }
    
    private func setupUI()
    {
        // 1.添加子控件
        contentView.addSubview(iconImageView)
        // 2.布局子控件
        iconImageView.snp.makeConstraints { (make) in
            make.edges.equalTo(contentView)
        }
    }
    

    private lazy var iconImageView:UIImageView = UIImageView()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension BKStatusesCell:UICollectionViewDataSource{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return values?.urlArr?.count ?? 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imgCell", for: indexPath) as! PictureViewCell

        
        cell.imageURL = values?.urlArr![indexPath.item]
        
        return cell
    }
    
    
    
}



class BottomBar: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        
        addSubview(reposeBtn)
        addSubview(commentBtn)
        addSubview(likeBtn)
        
        reposeBtn.snp.makeConstraints { (make) in
            
            make.left.top.bottom.equalTo(self)
            make.width.equalTo(UIScreen.main.bounds.size.width/3)
        }
        
        commentBtn.snp.makeConstraints { (make) in
            make.left.equalTo(reposeBtn.snp.right)
            make.top.height.width.equalTo(reposeBtn)
        }
        
        likeBtn.snp.makeConstraints { (make) in
            make.left.equalTo(commentBtn.snp.right)
            make.top.height.width.equalTo(commentBtn)
        }
    }
    
    
    lazy var reposeBtn: UIButton = UIButton.createButton(buttonName: "转发", font: 13, titleColor: UIColor.darkGray,imageName: "timeline_icon_retweet")
    
    
    lazy var commentBtn: UIButton = UIButton.createButton(buttonName: "评论", font: 13, titleColor: UIColor.darkGray,imageName: "timeline_icon_comment")
    
    lazy var likeBtn: UIButton = UIButton.createButton(buttonName: "喜欢", font: 13, titleColor: UIColor.darkGray,imageName:"timeline_icon_unlike")
}



