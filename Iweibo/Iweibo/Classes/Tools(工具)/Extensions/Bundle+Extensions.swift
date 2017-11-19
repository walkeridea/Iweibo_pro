//
//  Bundle+Extensions.swift
//  Iweibo
//
//  Created by walker on 2017/10/4.
//  Copyright © 2017年 walker. All rights reserved.
//

import Foundation

extension Bundle {
    
    // 计算型属性类似于函数，没有参数，有返回值
    var namespace: String {
        return infoDictionary?["CFBundleName"] as? String ?? ""
    }
}
