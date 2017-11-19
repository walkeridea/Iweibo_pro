//
//  WBMainViewController.swift
//  Iweibo
//
//  Created by walker on 2017/11/4.
//  Copyright © 2017年 walker. All rights reserved.
//

import UIKit

class WBMainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupChildController()
        setupComposeButton()
        
        self.delegate=self
    }
    
    // MARK: - 私有控件
    ///撰写按钮
    lazy var composeButton = UIButton.imageButton(
        imageName: "tabbar_compose_icon_add",backgroundImageName:"tabbar_compose_button"
    )
    
    // MARK: -监听方法
    /// 撰写微博
    @objc func composeStatus(){
        print("撰写微博")
        
        //判断是否登录
        //实例化视图
        let v = WBComposeTypeView.composeTypeView()
        
        //显示视图
        v.show{ [weak v] (clsName) in
            
            print(clsName as Any)
            //展现撰写微博控制器
            guard let clsName=clsName,
                let cls=NSClassFromString(Bundle.main.namespace+"."+clsName) as? UIViewController.Type else{
                    
                    v?.removeFromSuperview()
                    return
            }
            
            let vc = cls.init()
            
            let nav=UINavigationController(rootViewController: vc)
            
            // 让导航控制器强行更新约束
            nav.view.layoutIfNeeded()
            
            self.present(nav, animated: true){
                //
                v?.removeFromSuperview()
            }
        }
        
    }
}

// MARK: - UITabBarControllerDelegate
extension WBMainViewController:UITabBarControllerDelegate{
    
    /// 将要切换到目标控制器
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        print("将要切换到 \(viewController)")
        
        let idx=(childViewControllers as NSArray).index(of: viewController)
        
        if selectedIndex == 0 && idx == selectedIndex{
            print("点击首页")
            
            let nav=childViewControllers[0] as! UINavigationController
            let vc = nav.childViewControllers[0] as! WBHomeViewController

            vc.tableView?.setContentOffset(CGPoint(x: 0, y: -UIDevice.current.getNavHeight()), animated: true)
            
            //FIXME: - 刷新数据---增加延迟，是保证表格先滚动到顶部在刷新
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+1, execute: {
                vc.loadData()
            })
            
            UIApplication.shared.applicationIconBadgeNumber=0
        }
        //判断目标控制器是否是 UIViewController
        return !viewController.isMember(of: UIViewController.self)
    }
}

// MARK: - 设置界面
extension WBMainViewController{
    
    /// 设置所有子控制器
    func setupChildController(){
        let docDir=NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let jsonPath=(docDir as NSString).appendingPathComponent("main.json")
        
        var data=NSData(contentsOfFile: jsonPath)
        //判断 data 是否有内容，如果没有，说明本地沙盒没有文件
        if data==nil{
            let path=Bundle.main.path(forResource: "main.json", ofType: nil)
            data=NSData(contentsOfFile: path!)
        }
        
        // 从 Boudle 加载配置 json
        guard let array=try? JSONSerialization.jsonObject(with: data! as Data, options: []) as? [[String:Any]] else{
            return
        }
       
        var arrayM=[UIViewController]()
        for dict in array!{
            arrayM.append(controller(dict: dict))
        }
        
        //设置 tabBar 的子控制器
        viewControllers=arrayM
    }
    
    private func controller(dict:[String:Any]) ->UIViewController {
        guard let clsName=dict["clsName"] as? String,
            let title=dict["title"] as? String,
            let imageName=dict["imageName"] as? String,
            let cls=NSClassFromString(Bundle.main.namespace+"."+clsName) as? WBBaseViewController.Type,
        let visitorDict=dict["visitorInfo"] as? [String:String] else {
            return UIViewController()
        }
        
        //创建视图控制器
        let vc=cls.init()
        vc.title=title
        vc.visitorInfoDictionary=visitorDict
        vc.tabBarItem.image=UIImage(named: "tabbar_"+imageName)
        vc.tabBarItem.selectedImage=UIImage(named:"tabbar_"+imageName+"_selected")?.withRenderingMode(.alwaysOriginal)
        
        //设置 tabbar 的标题字体
        vc.tabBarItem.setTitleTextAttributes([NSAttributedStringKey.foregroundColor:UIColor.orange],for: .highlighted)
        //设置字体 －－－系统默认是12号字
        vc.tabBarItem.setTitleTextAttributes([NSAttributedStringKey.font:UIFont.systemFont(ofSize: 12)],for: UIControlState(rawValue:0))
        
        let nav=WBNavigationController(rootViewController: vc)
        return nav
    }
    
    /// 设置撰写按钮
    func setupComposeButton(){
        tabBar.addSubview(composeButton)
        let count=CGFloat(childViewControllers.count)
        //将向内缩进的宽度
        let w = tabBar.bounds.width/count
        
        composeButton.frame=tabBar.bounds.insetBy(dx: 2*w, dy: 0)
        //按钮监听方法
        composeButton.addTarget(self, action: #selector(composeStatus), for: .touchUpInside)
    }
}
