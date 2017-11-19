//
//  Button+Extension.swift
//  Iweibo
//
//  Created by walker on 2017/10/4.
//  Copyright © 2017年 walker. All rights reserved.
//

import UIKit

extension UIButton{

    /// 给button设置图片
    ///
    /// - Parameters:
    ///   - imageName: 正常图片
    ///   - backgroundImageName: 背景图片
    /// - Returns: UIButton
    static func imageButton(imageName:String,backgroundImageName:String) -> UIButton {
        let button=UIButton()
        button.setImage(UIImage(named: imageName), for: .normal)
        button.setImage(UIImage(named: imageName+"_highlighted"), for: .highlighted)
        button.setBackgroundImage(UIImage(named: backgroundImageName), for: .normal)
        button.setBackgroundImage(UIImage(named: backgroundImageName+"_highlighted"), for: .highlighted)
        button.sizeToFit()
        return button
    }
    
    /// 设置button的高亮
    ///
    /// - Parameters:
    ///   - title:  title
    ///   - fontSize:   fontSize
    ///   - normalColor:    normalColor
    ///   - highlightedColor:   highlightedColor
    ///   - backgroundImageName:    backgroundImageName
    /// - Returns:  UIButton
    static func textButton(title:String,fontSize:CGFloat,normalColor:UIColor,highlightedColor:UIColor,backgroundImageName:String="") ->UIButton {
        let button=UIButton()
        button.setTitle(title, for: .normal)
        button.setTitleColor(normalColor, for: .normal)
        button.setTitleColor(highlightedColor, for: .highlighted)
        
        button.titleLabel?.font=UIFont.systemFont(ofSize: fontSize)
        
        if backgroundImageName != ""{
            button.setBackgroundImage(UIImage(named:backgroundImageName), for: .normal)
            button.setBackgroundImage(UIImage(named:backgroundImageName+"_highlighted"), for: .highlighted)
        }
        button.sizeToFit()
        return button
    }
    
    

}
