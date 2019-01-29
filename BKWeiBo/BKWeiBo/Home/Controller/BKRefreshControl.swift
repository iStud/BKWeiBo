//
//  BKRefreshControl.swift
//  BKWeiBo
//
//  Created by bk.xiong on 2019/1/24.
//  Copyright © 2019 xiongbk. All rights reserved.
//

import UIKit
import SnapKit

class BKRefreshControl: UIRefreshControl {
    
    override init() {
    
        super.init()
    
        setupUI()
    }
    
    func setupUI()  {
        
        addSubview(refreshView)
        
        refreshView.snp.makeConstraints { (make) in
            
            make.centerX.equalTo(self)
            make.top.equalTo(self)
            make.size.equalTo(CGSize(width: 150, height: 60))
        }
        
        // KVO 监听
        addObserver(self, forKeyPath: "frame", options: .new, context: nil)
        
    }
    
    deinit {
        
        removeObserver(self, forKeyPath: "frame")
    }
    
    // 记录箭头是否旋转
    var rotationArrowFlag = false
    // 记录圈圈动画是否执行
    var loadingViewFlag = false
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
//        print(frame.origin.y)
        
        if frame.origin.y == 0 {
            return
        }
        
        if isRefreshing && !loadingViewFlag{

            loadingViewFlag = true
            refreshView.startLoad()
            return
        }
        
        if frame.origin.y >= -50 && rotationArrowFlag{
            
            print("箭头向下")
            rotationArrowFlag = false
            refreshView.rotationAngle(flag: rotationArrowFlag)
            
        }else if frame.origin.y < -50 && !rotationArrowFlag{
            
            print("箭头向上")
            rotationArrowFlag = true
            refreshView.rotationAngle(flag: rotationArrowFlag)
            

        }
 
    
        
    }
    
    lazy var refreshView:BKRefreshView = BKRefreshView.refreshView()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    override func endRefreshing() {
        super.endRefreshing()
        // 结束动画
        refreshView.endLoad()
        // 转圈标记复位
        loadingViewFlag = false
    }
}


class BKRefreshView: UIView {
    
    
    @IBOutlet weak var loadingView: UIImageView!
    
    @IBOutlet weak var arrowView: UIImageView!
    
    @IBOutlet weak var tipView: UIView!
    
    
    /// 箭头转换
    func rotationAngle(flag:Bool) {
        
        var angle = Double.pi
        angle += flag ? -0.01 : 0.01
        
        UIView.animate(withDuration: 0.2) {
            
            self.arrowView.transform = self.arrowView.transform.rotated(by: CGFloat(angle))
            
        }
        
    }
    
    /// 开始转圈圈
    func startLoad() {
        
        tipView.isHidden = true
        
        let anim = CABasicAnimation(keyPath: "transform.rotation")
        
        anim.toValue = 2*Double.pi
        anim.duration = 1
        anim.repeatCount = MAXFLOAT
        
        anim.isRemovedOnCompletion = false
        loadingView.layer.add(anim, forKey: nil)
    }
    
    /// 停止转圈圈
    func endLoad() {
        
        tipView.isHidden = false
        loadingView.layer.removeAllAnimations()
    }
    
    
    class func refreshView() -> BKRefreshView {
        
       return Bundle.main.loadNibNamed("BKRefreshView", owner: nil, options: nil)?.last as! BKRefreshView
    }
    
}


