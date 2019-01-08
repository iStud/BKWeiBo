//
//  BKNewFeatureController.swift
//  BKWeiBo
//
//  Created by bk.xiong on 2019/1/7.
//  Copyright © 2019 xiongbk. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"
private let count = 4



class BKNewFeatureController: UICollectionViewController,NewFeatureCellDelegate {
    

    let layout = UICollectionViewFlowLayout()

    init() {
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        layout.itemSize = view.bounds.size
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        collectionView?.isPagingEnabled = true
        collectionView?.bounces = false
    }
    

    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.backgroundColor = UIColor.yellow

        self.collectionView!.register(BKNewFeatureCell.self, forCellWithReuseIdentifier: reuseIdentifier)

    }



    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! BKNewFeatureCell
        cell.delegate = self;
        cell.backgroundColor = UIColor.yellow
        cell.imageIndex = indexPath.item
        return cell
    }
    
    
    // cell显示后调用
    override func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        // 取出当前显示的 indexPath
        let index = collectionView.indexPathsForVisibleItems.last!
        if index.item == count - 1 {
            let cell = collectionView.cellForItem(at: index) as!BKNewFeatureCell
            cell.showStartBtn()
        }
    }
    

    override var prefersStatusBarHidden: Bool{
        
        return true
    }

    // MARK: NewFeatureCellDelegate
    func startBtnClick() {
        
        print(#function)
        NotificationCenter.default.post(name: Notification.Name(SwitchMainNotification), object: true)
    }

}
