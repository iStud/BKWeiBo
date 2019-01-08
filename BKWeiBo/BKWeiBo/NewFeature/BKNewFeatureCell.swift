//
//  BKNewFeatureCell.swift
//  BKWeiBo
//
//  Created by bk.xiong on 2019/1/7.
//  Copyright © 2019 xiongbk. All rights reserved.
//

import UIKit

private let count = 4

protocol NewFeatureCellDelegate:NSObjectProtocol{
    
    func startBtnClick() 

}

class BKNewFeatureCell: UICollectionViewCell{
    
    weak var delegate:NewFeatureCellDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(imageView)
        contentView.addSubview(startBtn)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imageView.frame = self.bounds
        startBtn.snp.makeConstraints { (make) in

            make.centerX.equalTo(contentView)
            make.bottom.equalTo(contentView.snp.bottom).offset(-100)
        }
        
    }
    
    lazy var imageView:UIImageView = {
        
        let icon = UIImageView()
        
        return icon
    }()
    
    var imageIndex:Int = 0{
        
        didSet{
            
            imageView.image = UIImage(named: "new_feature_\(imageIndex+1)")
            
            if imageIndex == count - 1 {
                startBtn.isHidden = false
            }else{
                startBtn.isHidden = true
            }
        }
    }
    
    lazy var startBtn: UIButton = {
        
        let btn = UIButton()
        btn.setBackgroundImage(UIImage(named: "new_feature_finish_button"), for: .normal)
        btn.setBackgroundImage(UIImage(named: "new_feature_finish_button_highlighted"), for: .highlighted)
        btn.setTitle("开始体验", for: .normal)
        btn.addTarget(self, action: #selector(startActon), for: .touchUpInside)
        return btn
    }()
    
    func showStartBtn() {
        
        startBtn.transform = CGAffineTransform(scaleX: 0, y: 0)
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5.0, options: UIViewAnimationOptions(rawValue: 0), animations: {
            
            self.startBtn.transform = CGAffineTransform.identity
        }, completion: { (_) in
            
            
        })
        
    }
    
    @objc func startActon() {
        
        delegate?.startBtnClick()
    }
    
}
