//
//  UILabel+Extension.swift
//  Iweibo
//
//  Created by walker on 2017/10/9.
//  Copyright © 2017年 walker. All rights reserved.
//

import UIKit

extension UILabel{
    static func label(text:String,fontSize:CGFloat,color:UIColor)->UILabel{
        let label=UILabel()
        label.text=text
        label.font=UIFont.systemFont(ofSize: fontSize)
        label.textColor=color
        label.numberOfLines=0;
        label.sizeToFit()
        return label
    }
    
}
