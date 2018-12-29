//
//  TitleButton.swift
//  BKWeiBo
//
//  Created by bk.xiong on 2018/12/27.
//  Copyright © 2018 xiongbk. All rights reserved.
//

import UIKit

class TitleButton: UIButton {
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        setTitleColor(UIColor.black, for: .normal)
        setImage(UIImage(named: "navigationbar_arrow_down"), for: .normal)
        setImage(UIImage(named: "navigationbar_arrow_up"), for: .selected)
        sizeToFit()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 布局子控件,修改图片和文字的位置
    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        titleLabel?.frame.origin.x = 0
        imageView?.frame.origin.x = (titleLabel?.frame.size.width )!+5
    }
}


