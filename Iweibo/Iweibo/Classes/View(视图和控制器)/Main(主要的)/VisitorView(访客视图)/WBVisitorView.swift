//
//  WBVisitorView.swift
//  Iweibo
//
//  Created by walker on 2017/11/4.
//  Copyright © 2017年 walker. All rights reserved.
//

import UIKit

class WBVisitorView: UIView {
    
    //注册按钮
    lazy var registerButton=UIButton.textButton(title: "注册", fontSize: 16, normalColor: UIColor.orange, highlightedColor: UIColor.black, backgroundImageName: "common_button_white_disable")
    
    //登陆按钮
    lazy var loginButton=UIButton.textButton(title: "登陆", fontSize: 16, normalColor: UIColor.darkGray, highlightedColor: UIColor.black, backgroundImageName: "common_button_white_disable")

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 访客视图的信息字典
    // 使用字典设置访客视图的信息
    // 如果是首页，imageName ＝＝“”
    var visitorInfo:[String:String]?{
        didSet {
            // 取字典信息
            guard let imageName=visitorInfo?["imageName"],
                let message=visitorInfo?["message"] else{
                    return
            }
            
            //设置消息
            tipLabel.text=message
            
            //设置图像
            if imageName == "" {
                startAnimation()
                return
            }
            
            iconView.image = UIImage(named: imageName)
            
            //其他控制器的访客视图不需要显示小房子／遮罩视图
            houseIconView.isHidden=true
            maskIconView.isHidden=true
        }
    }
    
    //旋转图标动画(首页)
    private func startAnimation (){
        let anim = CABasicAnimation(keyPath: "transform.rotation")
        anim.toValue = 2*Double.pi
        anim.repeatCount = MAXFLOAT
        anim.duration = 15
        
        //动画完成不删除，如果 iconView 被释放，动画一起被销毁
        anim.isRemovedOnCompletion = false
        
        //将动画添加到图层
        iconView.layer.add(anim, forKey: nil)
    }
    
    // MARK: -私有控件
    //图像视图
    lazy var iconView = UIImageView(image: UIImage(named:"visitordiscover_feed_image_smallicon"))
    
    //遮罩图像
    lazy var maskIconView:UIImageView=UIImageView(image: UIImage(named: "visitordiscover_feed_mask_smallicon"))
    
    //小房子
    lazy var houseIconView = UIImageView(image: UIImage(named:"visitordiscover_feed_image_house"))
    
    //提示标签
    lazy var tipLabel:UILabel=UILabel.label(
        text: "关注一些人，回这儿看看有什么惊喜，关注一些人，回这儿看看有什么惊喜，",
        fontSize: 14,
        color: UIColor.darkGray)
}

// MARK: - 设置界面
extension WBVisitorView{
    private func setupUI() {
        backgroundColor=UIColor.colorWithHex(0xEDEDED)
        
        //此处注意顺序
        addSubview(iconView)
        addSubview(maskIconView)
        addSubview(houseIconView)
        addSubview(tipLabel)
        addSubview(registerButton)
        addSubview(loginButton)
        
        tipLabel.textAlignment = .center
        
        //   －－取消 autoresizing
        for v in subviews{
            v.translatesAutoresizingMaskIntoConstraints=false
        }
        
        //自动布局
        let margin:CGFloat = 20.0
        //图像视图
        addConstraint(NSLayoutConstraint(
            item: iconView,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: self,
            attribute: .centerX,
            multiplier: 1.0,
            constant: 0))
        addConstraint(NSLayoutConstraint(
            item: iconView,
            attribute: .centerY,
            relatedBy: .equal,
            toItem: self,
            attribute: .centerY,
            multiplier: 1.0,
            constant: -60))
        //小房子
        addConstraint(NSLayoutConstraint(
            item: houseIconView,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: iconView,
            attribute: .centerX,
            multiplier: 1.0,
            constant: 0))
        
        addConstraint(NSLayoutConstraint(
            item: houseIconView,
            attribute: .centerY,
            relatedBy: .equal,
            toItem: iconView,
            attribute: .centerY,
            multiplier: 1.0,
            constant: 0))
        
        //提示标签
        addConstraint(NSLayoutConstraint(
            item: tipLabel,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: iconView,
            attribute: .centerX,
            multiplier: 1.0,
            constant: 0))
        
        addConstraint(NSLayoutConstraint(
            item: tipLabel,
            attribute: .top,
            relatedBy: .equal,
            toItem: iconView,
            attribute: .bottom,
            multiplier: 1.0,
            constant: margin))
        
        //行设置宽度
        addConstraint(NSLayoutConstraint(
            item: tipLabel,
            attribute: .width,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1.0,
            constant: 236))
        
        //注册按钮
        addConstraint(NSLayoutConstraint(
            item: registerButton,
            attribute: .left,
            relatedBy: .equal,
            toItem: tipLabel,
            attribute: .left,
            multiplier: 1.0,
            constant: 0))
        
        addConstraint(NSLayoutConstraint(
            item: registerButton,
            attribute: .top,
            relatedBy: .equal,
            toItem: tipLabel,
            attribute: .bottom,
            multiplier: 1.0,
            constant: margin))
        
        addConstraint(NSLayoutConstraint(
            item: registerButton,
            attribute: .width,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1.0,
            constant: 100))
        
        //登录按钮
        addConstraint(NSLayoutConstraint(
            item: loginButton,
            attribute: .right,
            relatedBy: .equal,
            toItem: tipLabel,
            attribute: .right,
            multiplier: 1.0,
            constant: 0))
        
        addConstraint(NSLayoutConstraint(
            item: loginButton,
            attribute: .top,
            relatedBy: .equal,
            toItem: tipLabel,
            attribute: .bottom,
            multiplier: 1.0,
            constant: margin))
        
        addConstraint(NSLayoutConstraint(
            item: loginButton,
            attribute: .width,
            relatedBy: .equal,
            toItem: registerButton,
            attribute: .width,
            multiplier: 1.0,
            constant: 0))
        
        //遮罩图像  --- 苹果原生自定的布局
        let viewDict = ["maskIconView":maskIconView,"registerButton":registerButton] as [String : Any]
        
        //定义 VFL 中（） 指定的常数映射关系
        let metrics = ["spacing":-35]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-0-[maskIconView]-0-|",
            options: [],
            metrics: nil,
            views: viewDict))
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-0-[maskIconView]-(spacing)-[registerButton]",
            options: [],
            metrics: metrics,
            views: viewDict))
    }
}
