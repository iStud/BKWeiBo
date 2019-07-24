//
//  BKBrowseController.swift
//  BKWeiBo
//
//  Created by bk.xiong on 2019/2/15.
//  Copyright © 2019 xiongbk. All rights reserved.
//

import UIKit
import SnapKit


private let ReuseIdentifier = "ReuseIdentifier"

class BKBrowseController: UIViewController,UICollectionViewDataSource,BKPhotoViewCellDelegate {

    

    var currentIndex:Int?
    var photoUrl:[URL]?

    init(urls:[URL],index:Int) {
        
        currentIndex = index
        photoUrl = urls
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        
        view.addSubview(photoView)
        view.addSubview(saveBtn)
        view.addSubview(closeBtn)
        
        photoView.register(BKPhotoViewCell.self, forCellWithReuseIdentifier:ReuseIdentifier)
        
        saveBtn.snp.makeConstraints { (make) in
            
            make.left.equalTo(20)
            make.bottom.equalTo(-40)
            make.width.equalTo(60)
            make.height.equalTo(40)
        }
        
        closeBtn.snp.makeConstraints { (make) in
            
            make.right.equalTo(view.snp.right).offset(-20)
            make.bottom.equalTo(saveBtn)
            make.width.equalTo(saveBtn)
            make.height.equalTo(saveBtn)
        }
        
        photoView.snp.makeConstraints { (make) in
            
            make.edges.equalTo(view)
        }
        
    }
    
    
    lazy var closeBtn: UIButton = {
        
        let btn = UIButton()
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        btn.setTitle("关闭", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.addTarget(self, action:#selector(closeBtnClick) , for: .touchUpInside)
        btn.backgroundColor = UIColor.black
        return btn
    }()
    
    lazy var saveBtn: UIButton = {
        
        let btn = UIButton()
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        btn.setTitle("保存", for: .normal)
        btn.addTarget(self, action:#selector(saveBtnClick) , for: .touchUpInside)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.backgroundColor = UIColor.black
        return btn
    }()
    
    lazy var flowLayout = UICollectionViewFlowLayout()
    
    lazy var photoView: UICollectionView = {
        
        flowLayout.itemSize = view.frame.size
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: flowLayout)
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.showsHorizontalScrollIndicator = false
        
        
        collectionView.dataSource = self
        return collectionView
    }()
    
    
    // MARK: - Button click
    @objc func closeBtnClick()  {
        
        dismiss(animated: true, completion: nil)
    }
    
    @objc func saveBtnClick() {
        
        print("保存")
    }
    
    // MARK: - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return photoUrl?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:ReuseIdentifier, for: indexPath) as! BKPhotoViewCell
//        cell.backgroundColor = UIColor.randomColor()
        cell.imageUrl = photoUrl![indexPath.item]
        cell.delegate = self
        return cell
    }
    
    // MARK: - BKPhotoViewCellDelegate
    func closePhoto() {
        
        closeBtnClick()
    }
    
}
