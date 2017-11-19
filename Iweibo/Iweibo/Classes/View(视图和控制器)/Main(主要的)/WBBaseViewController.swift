//
//  WBBaseViewController.swift
//  Iweibo
//
//  Created by walker on 2017/11/4.
//  Copyright © 2017年 walker. All rights reserved.
//

import UIKit

class WBBaseViewController: UIViewController {

    /// 访客视图信息字典
    var visitorInfoDictionary:[String:String]?
    /// 表格视图 －－－如果用户没有登陆就不创建
    var tableView:UITableView?
    /// 刷新控件
    var refreshController:UIRefreshControl?

    /// 上拉刷新标记
    var isPullup = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    // 加载数据 － 具体的实现由子类负责
    @objc func loadData(){
        //如果子类不实现任何方法，默认关闭刷新控件
        refreshController?.endRefreshing()
    }
    
    
    private func setupUI(){
        view.backgroundColor=UIColor.randomColor
        
        setupNavigationBar()
        
        setupVisitorView()
    }
    
    @objc private func register(){
        print(#function)
    }
    @objc private func login(){
        print(#function)
    }
}

// MARK: - 设置界面
extension WBBaseViewController{
    
    func setupVisitorView(){
        let visitorView=WBVisitorView(frame: view.bounds)
        view.addSubview(visitorView)
        visitorView.visitorInfo=visitorInfoDictionary
        
        // 添加访客视图按钮的监听方法
        visitorView.loginButton.addTarget(self, action: #selector(login), for: .touchUpInside)
        
        visitorView.registerButton.addTarget(self, action: #selector(register), for: .touchUpInside)
        
        navigationItem.leftBarButtonItem=UIBarButtonItem(title: "注册", style: .plain, target: self, action: #selector(register))
        navigationItem.rightBarButtonItem=UIBarButtonItem(title: "登陆", style: .plain, target: self, action: #selector(login))
    }
    
    
    ///  设置导航条
    func setupNavigationBar(){
        // 设置导航栏背景
        self.navigationController?.navigationBar.barTintColor=UIColor.colorWithHex(0xF6F6F6)
        // 标题颜色
        self.navigationController?.navigationBar.titleTextAttributes=[NSAttributedStringKey.foregroundColor:UIColor.darkGray]
        // item颜色
        self.navigationController?.navigationBar.tintColor=UIColor.orange
    }
}


// MARK: -UITableViewDataSource,UITableViewDelegate
extension WBBaseViewController:UITableViewDataSource,UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    // 基类只是准备方法，子类负责具体的实现
    // 子类的数据源方法不需要 super＋
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 10
    }
    
    // 在显示最后一行的时候，上拉刷新
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let row = indexPath.row
        
        let section=tableView.numberOfSections - 1
        
        if row < 0 || section < 0 {
            return
        }
        
        //行数
        let count = tableView.numberOfRows(inSection: section)
        
        if row == (count-1) && !isPullup{
            
            print("上拉刷新")
            isPullup = true
            
            //开始刷新
            loadData()
        }
    }
}
