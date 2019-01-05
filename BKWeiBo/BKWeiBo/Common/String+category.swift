//
//  String+category.swift
//  BKWeiBo
//
//  Created by bk.xiong on 2019/1/3.
//  Copyright © 2019 xiongbk. All rights reserved.
//

import UIKit

extension String{
    
    func docDir () ->String {
        
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last!
        
        return path + "/" + "\(self)"
    }
}
