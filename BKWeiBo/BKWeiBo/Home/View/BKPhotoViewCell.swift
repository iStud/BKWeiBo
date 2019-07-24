//
//  BKPhotoViewCell.swift
//  BKWeiBo
//
//  Created by bk.xiong on 2019/2/18.
//  Copyright © 2019 xiongbk. All rights reserved.
//

import UIKit

protocol BKPhotoViewCellDelegate : NSObjectProtocol
{
    func closePhoto()
}


class BKPhotoViewCell: UICollectionViewCell {
    
    weak var delegate:BKPhotoViewCellDelegate?
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        setupUI()
    }
    
    var imageUrl:URL?{
        
        didSet{
            
            // 重置 scrollview
            self.resetScrollView()
            
            // 显示菊花
            activity.startAnimating()
            
            imageView.sd_setImage(with: imageUrl) { (image, _, _, _) in
                
                // 隐藏菊花
                self.activity.stopAnimating()
                
                // 设置图片的位置
                self.setImagePosition()
                
            }
        }
    }
    
    func setImagePosition() {
        
        let size = self.displaySize(image: imageView.image!)
        if size.height < UIScreen.main.bounds.height {
            
            self.imageView.frame = CGRect(origin: CGPoint.zero, size: size)
            let y = (UIScreen.main.bounds.height - size.height)*0.5
            self.scrollview.contentInset = UIEdgeInsets(top: y, left: 0, bottom: y, right: 0)
        }else{
            
            self.imageView.frame = CGRect(origin: CGPoint.zero, size: size)
            self.scrollview.contentSize = size
        }
    }
    
    private func resetScrollView(){
        
        scrollview.contentSize = CGSize.zero
        scrollview.contentOffset = CGPoint.zero
        scrollview.contentInset = UIEdgeInsets.zero
    }
    
    func displaySize(image:UIImage) -> CGSize {
       
        // 计算图片的宽高比
        let scale = image.size.height / image.size.width
        let width = UIScreen.main.bounds.width
        let height = width * scale
        return CGSize(width: width, height: height)
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI(){
        
        contentView.addSubview(scrollview)
        scrollview.addSubview(imageView)
        scrollview.frame = UIScreen.main.bounds
        
        contentView.addSubview(activity)
        activity.center = contentView.center
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(close))
        imageView.addGestureRecognizer(tap)
        imageView.isUserInteractionEnabled = true
    }
    
    lazy var scrollview: UIScrollView = {
        
        let view = UIScrollView()
        return view
        
    }()
    
    lazy var imageView:UIImageView = UIImageView()
    
    lazy var activity:UIActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle:UIActivityIndicatorViewStyle.whiteLarge)
    
    @objc func close(){
        
       delegate?.closePhoto()
    }
    
}
