//
//  UIColor+Category.swift
//  BKWeiBo
//
//  Created by bk.xiong on 2019/2/15.
//  Copyright © 2019 xiongbk. All rights reserved.
//

import UIKit

extension UIColor{
    
    class func randomColor() -> UIColor {

        return UIColor(red: RandomNumber(), green: RandomNumber(), blue: RandomNumber(), alpha: 1.0)
    }
    
    class func RandomNumber() -> CGFloat {
    
       return CGFloat(arc4random_uniform(256)) / CGFloat(255)
    }
}
