//
//  BKMTableViewCell.swift
//  BKWeiBo
//
//  Created by bk.xiong on 2019/1/15.
//  Copyright © 2019 xiongbk. All rights reserved.
//

import UIKit
import SnapKit

class BKMTableViewCell: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        
        //约束头像
        headImageView.backgroundColor=UIColor.red
        contentView.addSubview(headImageView)
        
        //约束用户名
        contentView.addSubview(nameLabel)
        nameLabel.text = "是明明才"
        
        // 时间
        contentView.addSubview(timeLabel)
        timeLabel.text = "098762"
        
        contentView.addSubview(contentLabel)
        
        headImageView.snp.makeConstraints({make in
            
            make.top.left.equalTo(10)
            make.width.height.equalTo(40)

        })
        
        
        nameLabel.snp.makeConstraints({make in
            
            make.top.equalTo(headImageView.snp.top)
            make.left.equalTo(headImageView.snp.right).offset(5)

        })
        

        timeLabel.snp.makeConstraints({make in
            
            make.left.equalTo(headImageView.snp.right).offset(5)
            make.bottom.equalTo(headImageView.snp.bottom)
            
        })
        
        
        //约束文字内容
        contentLabel.text = "一行代码搞定自动布局！支持Cell和Tableview高度自适应，Label和ScrollView内容自适应，致力于做最简单易用的AutoLayout库。The most easy way for autoLayout. Based on runtime"
        contentLabel.snp.makeConstraints({make in
        
            make.top.equalTo(headImageView.snp.bottom).offset(5)
            make.left.equalTo(headImageView.snp.left)
            make.right.equalTo(-10)
            
        })
        
        
        
        //约束图片
        
        picView.dataSource = self
        
        picView.delegate = self
        
        // let nib = UINib.init(nibName: "CollectionViewCell", bundle: nil)
        
        picView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "imgCell")
        
        contentView.addSubview(picView)

        picView.snp.makeConstraints({make in

            make.top.equalTo(contentLabel.snp.bottom).offset(5)
            
            make.height.equalTo(200)
            
            make.left.equalTo(contentLabel.snp.left)
            
            make.right.equalTo(-10)
        })
        
        
        
        
        
        //约束底部工具条
        
        contentView.addSubview(bottomBar)

        bottomBar.snp.makeConstraints({make in

            make.top.equalTo(picView.snp.bottom).offset(5)
            
            make.left.equalTo(10)
            
            make.right.equalTo(-10)
            
            make.height.equalTo(40)
            
            make.bottom.equalTo(-10)//这句一定要放在最后一个view不然无法自动计算高度
            
            
            
        })
        
        
        
        
        
    }
        

    
    //懒加载头像
    
    lazy private var headImageView:UIImageView={
        
        let headImageView = UIImageView()
        return headImageView
        
    }()
    
    
    
    //懒加载用户名
    
    lazy private var nameLabel:UILabel={
        
        let nameLabel=UILabel()
        return nameLabel
    
        
    }()
    
    
    
    //懒加载时间
    
    lazy private var timeLabel:UILabel={
        

        let timeLabel = UILabel()
        timeLabel.font=UIFont.systemFont(ofSize: 14)
        timeLabel.textColor=UIColor.darkGray
        return timeLabel
        
    }()
    
    
    
    //懒加载文字内容
    
    lazy private var contentLabel:UILabel={
        
    
        let contentLabel = UILabel()
        contentLabel.numberOfLines=0
        return contentLabel
        
    }()
    
    
    
    
    
    //懒加载图片容器
    
    lazy private var picView:UICollectionView={

        let picView=UICollectionView(frame:CGRect.zero,collectionViewLayout: UICollectionViewFlowLayout())
        
        return picView
        
    }()
    
    
    //底部工条
    
    lazy private var bottomBar:UIView={
        
        let bottomBar=UIView()

        bottomBar.backgroundColor=UIColor.cyan
        
        return bottomBar

    }()
    
    
}


extension BKMTableViewCell:UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        
        
        return 1
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        
        return 9
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        
        
        return 5
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        
        return CGSize(width:(UIScreen.main.bounds.size.width-30)/3,height:100)
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imgCell", for: indexPath)
        
        
        
        
        
        cell.backgroundColor=UIColor.orange
        
        
        
        
        
        return cell
        
    }
    
    
    
}
