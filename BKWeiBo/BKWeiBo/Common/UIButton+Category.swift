
//
//  UIButton+Category.swift
//  BKWeiBo
//
//  Created by bk.xiong on 2019/1/10.
//  Copyright © 2019 xiongbk. All rights reserved.
//

import UIKit

extension UIButton{
    
    class func createButton(buttonName:String,font:CGFloat,titleColor:UIColor,imageName:String) -> UIButton {
        
        let btn = UIButton()
        btn.setTitle(buttonName, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize:font)
        btn.setTitleColor(titleColor, for: .normal)
        btn.setImage(UIImage(named: imageName), for: .normal)
        btn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        return btn
    }
}
