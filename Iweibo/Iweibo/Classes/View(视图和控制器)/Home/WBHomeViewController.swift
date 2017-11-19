//
//  WBHomeViewController.swift
//  Iweibo
//
//  Created by walker on 2017/11/4.
//  Copyright © 2017年 walker. All rights reserved.
//

import UIKit

// 原创微博可重用 cell ID
private let originalCellId = "originalCellId"
//被转发微博的可重用 cell id
private let retweetedCellId="retweetedCellId"

class WBHomeViewController: WBBaseViewController {
    
    // 列表视图模型
    lazy var listViewModel = WBStatusListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

extension WBHomeViewController{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //取视图模型，根据视图模型判断可重用 cell
        let vm=listViewModel.statusList[indexPath.row]
        
        let cellId=(vm.status.retweeted_status != nil) ? retweetedCellId :originalCellId
        // 取cell
        tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        
        return UITableViewCell()
    }
}
