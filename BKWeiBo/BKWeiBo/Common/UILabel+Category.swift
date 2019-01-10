//
//  UILabel+Category.swift
//  BKWeiBo
//
//  Created by bk.xiong on 2019/1/10.
//  Copyright © 2019 xiongbk. All rights reserved.
//

import UIKit

extension UILabel{
    
  class  func createLabel(lableTextFont:CGFloat,labelTextColor:UIColor) -> UILabel {
        
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize:lableTextFont)
        label.textColor = labelTextColor
        return label
        
    }
}
