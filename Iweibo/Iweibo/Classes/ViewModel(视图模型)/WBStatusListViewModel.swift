//
//  WBStatusListViewModel.swift
//  Iweibo
//
//  Created by walker on 2017/11/4.
//  Copyright © 2017年 walker. All rights reserved.
//

import Foundation

///  微博列表视图模型-------需要使用 KVC 或字典转模型设置对象值，类就要继承 NSObject
// 负责微博的数据处理
class WBStatusListViewModel {
    /// 微博视图模型数组懒加载
    lazy var statusList = [WBStatusViewModel]()
}
