//
//  BFRefreshHeader.swift
//  BFRefreshDemo
//
//  Created by HJQ on 2018/7/29.
//  Copyright © 2018年 HJQ. All rights reserved.
//

import Foundation

public typealias BFRefreshRefreshingBlock = () -> ()

public enum BFRefreshLoadType: String {
    case normal     = "正常"
    case loading    = "加载中"
    case error      = "请求错误"
    case noNetwork  = "无网络"
    case noData     = "无数据"
}
