//
//  UIBarButtonItem+Category.swift
//  BKWeiBo
//
//  Created by bk.xiong on 2018/12/26.
//  Copyright © 2018 xiongbk. All rights reserved.
//

import UIKit

extension UIBarButtonItem{
    
    class func itemCreated(image:String,target:Any?,action:Selector) -> UIBarButtonItem {
        
        let btn = UIButton()
        btn.setImage(UIImage(named: image), for:.normal)
        btn.setImage(UIImage(named: image+"_highlighted"), for: .highlighted)
        btn.sizeToFit()
        btn.addTarget(target, action: action, for: .touchUpInside)
        return UIBarButtonItem(customView: btn)
        
    }
    
    convenience init(imageName:String,taget:AnyObject,action:String?) {
        
        let btn = UIButton()
        btn.setImage(UIImage(named: imageName), for: UIControlState.normal)
        btn.setImage(UIImage(named: imageName + "_highlighted"), for: .highlighted)
        
        if action != nil{
            
            btn.addTarget(taget, action:Selector(action!), for: .touchUpInside)
            
        }
        
        btn.sizeToFit()
        self.init(customView: btn)
    }
}
