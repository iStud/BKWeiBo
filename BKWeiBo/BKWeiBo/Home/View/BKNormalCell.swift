//
//  BKNormalCell.swift
//  BKWeiBo
//
//  Created by bk.xiong on 2019/1/23.
//  Copyright © 2019 xiongbk. All rights reserved.
//

import UIKit

class BKNormalCell: BKStatusesCell {
    
    override func setupUI() {
        super.setupUI()
        
        pictureView.snp.makeConstraints { (make) in
            
            make.top.equalTo(contentLabel.snp.bottom).offset(10)
            make.left.equalTo(10)
            make.size.equalTo(CGSize(width: 90.0, height: 300.0))
        }
        
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
