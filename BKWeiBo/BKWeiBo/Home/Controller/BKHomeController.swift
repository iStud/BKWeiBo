//
//  BKHomeController.swift
//  BKWeiBo
//
//  Created by bk.xiong on 2018/6/29.
//  Copyright © 2018年 xiongbk. All rights reserved.
//

/*
 App Key：3003757086
 App Secret：f96b489c33e676f78e4d5e772689aca7
 */

import UIKit

private let CellIdentifier = "CellIdentifier"


class BKHomeController: BKBaseController,PictureViewDelegate {

    // 是否展开
    var isPresent:Bool = false
    var titleBtn = TitleButton()
    
    var modelArr:[BKStatuses]?{
        
        didSet{
            
            tableView.reloadData()
        }
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        
        if !isLogin {
            
            visitView?.setVisitInfo(isHome: true, imageName: "visitordiscover_feed_image_house", message: "关注一些人，回这里看看有什么惊喜")
            return
        }
        
        // 设置导航
        setNav()
        
        // 设置刷新
        refreshControl = BKRefreshControl()
        refreshControl?.addTarget(self, action: #selector(loadData), for:.valueChanged)
        
        loadData()
        
        
        tableView.register(BKNormalCell.self, forCellReuseIdentifier:statusCellIdentifier.NormalCell.rawValue)
        tableView.register(BKRetweetCell.self, forCellReuseIdentifier: statusCellIdentifier.RetweetCell.rawValue)
    }

    // MARK: - 设置 UI
    // 设置导航栏
    func setNav(){
        
        navigationItem.leftBarButtonItem = UIBarButtonItem.itemCreated(image: "navigationbar_friendattention", target: self, action: #selector(addFriendsBtnClick))
        navigationItem.rightBarButtonItem = UIBarButtonItem.itemCreated(image: "navigationbar_pop", target: self, action: #selector(scanBtnClick))
        
        // 设置导航标题
        titleBtn.setTitle("壹拾零", for: .normal)
        navigationItem.titleView = titleBtn
        titleBtn.addTarget(self, action: #selector(titleBtnClick(btn:)), for: .touchUpInside)
        
//        tableView.estimatedRowHeight = 500
//        tableView.rowHeight = UITableViewAutomaticDimension
//        tableView.rowHeight = 400

    }
    
    var pullupRefreshFlag = false
    
    @objc func loadData() {
        
        // 设置下拉刷新的 since id
        var since_id = modelArr?.first?.id ?? 0
        
        // 设置上拉加载更多 id
        var max_id =  0
        
        // 上拉 since_id = 0
        if pullupRefreshFlag {
            
            since_id = 0
            max_id = modelArr?.last?.id ?? 0
        }
        
        
        // 加载数据
        BKStatuses.loadData(since_id: since_id,max_id :max_id) { (modelArr, error) in
            
            self.refreshControl?.endRefreshing()
            
            if error != nil{
                
                return
            }
            
            // 下拉刷新
            if since_id > 0 {
                
                self.modelArr = modelArr! + self.modelArr!
                
                // 设置动画
                
                
            }else if (max_id > 0){
                
                self.modelArr = self.modelArr! + modelArr!
            }
            else{
                
                self.modelArr = modelArr
            }
            
            
        }
    }
    
    
    
    // MARK: - 按钮点击方法
    @objc func titleBtnClick(btn:UIButton){
        
        btn.isSelected = !btn.isSelected
    
        // 获取 storyBoard 对象
        let sb = UIStoryboard(name: "BKPopoverController", bundle: nil)
        // 实例化 stroyBoard 视图控制器
        let popover = sb.instantiateViewController(withIdentifier: "PopoverController")
        
        // 使用默认的 modal 会导致当前控制器的 view 被移除
        // 使用自定义的就不会移除
        popover.transitioningDelegate = popoverDelegate
        popover.modalPresentationStyle = UIModalPresentationStyle.custom
        present(popover, animated: true, completion: nil)
    }
    
    @objc func addFriendsBtnClick(){
    
        print(#function)
    }
    
    @objc func scanBtnClick(){
        
        print(#function)
    }
    
    lazy var popoverDelegate: BKPopoverDelegate = {
        
        let pop = BKPopoverDelegate()
        
        return pop
    }()
    
    
    var rowCache:[Int:CGFloat] = [Int:CGFloat]()
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        rowCache.removeAll()
    }
    
    // MARK: - PictureViewDelegate    
    func popBrowseController(index: Int, urls: [URL]) {
        
        let browseVc = BKBrowseController(urls: urls, index: index)
        present(browseVc, animated: true, completion: nil)
    }
    
    
}


extension BKHomeController{
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modelArr?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        let statuses = modelArr![indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: statusCellIdentifier.cellID(status: statuses), for: indexPath) as! BKStatusesCell
        
        cell.statuses = statuses
        cell.delegate = self
        
        // 上拉加载更多
        let count = modelArr?.count ?? 0
        if indexPath.row == count - 1 {
            
            print("上拉加载更多")
            pullupRefreshFlag = true
            loadData()
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        let statuses = modelArr![indexPath.row]
        
        if let height = rowCache[statuses.id] {
            
//            print("缓存中获取")
            return height
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier:statusCellIdentifier.cellID(status: statuses))as!BKStatusesCell
        
        let height = cell.getHeight(model: statuses)
        
        rowCache[statuses.id] = height
//         print("重新计算")
        return height
    }
    

}


