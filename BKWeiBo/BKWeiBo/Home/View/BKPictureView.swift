//
//  BKPictureView.swift
//  BKWeiBo
//
//  Created by bk.xiong on 2019/1/14.
//  Copyright © 2019 xiongbk. All rights reserved.
//

import UIKit
import SnapKit
class BKPictureView: UIView {
    
   var origainViewConstraint :Constraint?
    

    var pictureCount:Int?{
        
        didSet{
            
            origainViewConstraint?.deactivate()
            print(pictureCount as Any)
            
            if pictureCount! > 0 {
                
                 print("有图")
                self.snp.updateConstraints { (make) in
                    
                    self.origainViewConstraint = make.bottom.equalTo(self).offset(5).constraint

                }
                
                
            }else{
                
                
            }
            
        }
    }
    

}
