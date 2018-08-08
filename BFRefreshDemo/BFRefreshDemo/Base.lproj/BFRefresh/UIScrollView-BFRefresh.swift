//
//  BFRefresh-Extension.swift
//  BFRefreshDemo
//
//  Created by HJQ on 2018/7/29.
//  Copyright © 2018年 HJQ. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

// Extension add variable
fileprivate struct BFRefreshRuntimeKey {
    static let refreshkey = UnsafeRawPointer.init(bitPattern: "refreshkey".hashValue)
    static let loadTypekey = UnsafeRawPointer.init(bitPattern: "loadTypekey".hashValue)
    static let refreshNoNetworkViewkey = UnsafeRawPointer.init(bitPattern: "refreshNoNetworkViewkey".hashValue)
    static let refreshRequestErrorViewViewkey = UnsafeRawPointer.init(bitPattern: "refreshRequestErrorViewViewkey".hashValue)
    static let refreshNoDataViewkey = UnsafeRawPointer.init(bitPattern: "refreshNoDataViewkey".hashValue)
    static let loadingViewkey = UnsafeRawPointer.init(bitPattern: "loadingViewkey".hashValue)
}

public extension UIScrollView {

    /**
     *  设置页面显示的类型
     */
    public var loadType: BFRefreshLoadType? {
        set(newValue) {
            objc_setAssociatedObject(self, BFRefreshRuntimeKey.loadTypekey!, newValue, .OBJC_ASSOCIATION_ASSIGN)
        }
        get {
            return  objc_getAssociatedObject(self, BFRefreshRuntimeKey.loadTypekey!) as? BFRefreshLoadType
        }
    }

    /**
     *  刷新回调
     */
    public var refreshBlock: BFRefreshRefreshingBlock? {
        set(newValue) {
            objc_setAssociatedObject(self, BFRefreshRuntimeKey.refreshkey!, newValue, .OBJC_ASSOCIATION_COPY)
        }
        get {
            return  objc_getAssociatedObject(self, BFRefreshRuntimeKey.refreshkey!) as? BFRefreshRefreshingBlock
        }
    }

    // MARK: - 视图
    /**
     *  没有网络时显示的视图
     */
    public var refreshNoNetworkView: BFRefreshNoNetworkView? {
        set(newValue) {
            objc_setAssociatedObject(self, BFRefreshRuntimeKey.refreshNoNetworkViewkey!, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            guard let view = objc_getAssociatedObject(self, BFRefreshRuntimeKey.refreshNoNetworkViewkey!) as? BFRefreshNoNetworkView else {
                return self.getRefreshNoNetworkView()
            }
            return view
        }
    }

    /**
     *  访问出错时显示的视图
     */
    public var refreshRequestErrorView: BFRefreshRequestErrorView? {
        set(newValue) {
            objc_setAssociatedObject(self, BFRefreshRuntimeKey.refreshRequestErrorViewViewkey!, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            guard let view = objc_getAssociatedObject(self, BFRefreshRuntimeKey.refreshRequestErrorViewViewkey!) as? BFRefreshRequestErrorView else {
                return self.getRefreshRequestErrorView()
            }
            return view
        }
    }

    /**
     *  没有数据显示的视图
     */
    public var refreshNoDataView: BFRefreshNoDataView? {
        set(newValue) {
            objc_setAssociatedObject(self, BFRefreshRuntimeKey.refreshNoDataViewkey!, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            guard let view = objc_getAssociatedObject(self, BFRefreshRuntimeKey.refreshNoDataViewkey!) as? BFRefreshNoDataView else {
                return self.getRefreshNoDataView()
            }
            return view
        }
    }

    /**
     *  加载中的视图
     */
    public var refreshLoadingView: BFRefreshLoadingView? {
        set(newValue) {
            objc_setAssociatedObject(self, BFRefreshRuntimeKey.loadingViewkey!, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            guard let view = objc_getAssociatedObject(self, BFRefreshRuntimeKey.loadingViewkey!) as? BFRefreshLoadingView else {
                return self.getLoadingView()
            }
            return  view
        }
    }

}

public extension UIScrollView {

    public func set(loadType: BFRefreshLoadType) {

        if let _ = self.refreshNoDataView, let _ = self.refreshNoDataView?.superview {
            self.refreshNoDataView?.removeFromSuperview()
        }

        if let _ = self.refreshNoNetworkView, let _ = self.refreshNoNetworkView?.superview {
            self.refreshNoNetworkView?.removeFromSuperview()
        }

        if let _ = self.refreshRequestErrorView, let _ = self.refreshRequestErrorView?.superview {
            self.refreshRequestErrorView?.removeFromSuperview()
        }

        if let _ = self.refreshLoadingView, let _ = self.refreshLoadingView?.superview {
            self.refreshLoadingView?.removeFromSuperview()
        }

        self.loadType = loadType
        switch loadType {
        case .noData:
            guard let noDataView = self.refreshNoDataView else {
                return
            }
            addSubview(noDataView)
            noDataView.snp.makeConstraints { (make) in
                make.left.top.equalToSuperview()
                make.width.equalToSuperview()
                make.height.equalToSuperview()
            }

        case .noNetwork:
            guard let noNetWorkView = self.refreshNoNetworkView else {
                return
            }
            addSubview(noNetWorkView)
            noNetWorkView.snp.makeConstraints { (make) in
                make.left.top.equalToSuperview()
                make.width.equalToSuperview()
                make.height.equalToSuperview()
            }

        case .error:
            guard let errorView = self.refreshRequestErrorView else {
                return
            }
            addSubview(errorView)
            errorView.snp.makeConstraints { (make) in
                make.left.top.equalToSuperview()
                make.width.equalToSuperview()
                make.height.equalToSuperview()
            }

        case .loading:
            guard let loadingView = self.refreshLoadingView else{
                return
            }
            addSubview(loadingView)
            loadingView.snp.makeConstraints { (make) in
                make.left.top.equalToSuperview()
                make.width.equalToSuperview()
                make.height.equalToSuperview()
            }

        default:break
        }
    }
}

extension UIScrollView {

    // 获取无网络View
    fileprivate func getRefreshNoNetworkView() -> BFRefreshNoNetworkView {
        let rNoNetworkView = BFRefreshNoNetworkView.init(frame: .zero)
        rNoNetworkView.refreshNoNetworkViewBlock = {[weak self] in
            guard let strongSelf = self else {
                return
            }
            if let _ = strongSelf.refreshBlock {
                strongSelf.refreshBlock!()
            }
        }
        self.refreshNoNetworkView = rNoNetworkView
        return rNoNetworkView

    }

    // 请求错误View
    fileprivate func getRefreshRequestErrorView() -> BFRefreshRequestErrorView {
        let errorView = BFRefreshRequestErrorView.init(frame: .zero)
        errorView.refreshRequestErrorViewBlock = {[weak self] in
            guard let strongSelf = self else {
                return
            }
            if let _ = strongSelf.refreshBlock {
                strongSelf.refreshBlock!()
            }
        }
        self.refreshRequestErrorView = errorView
        return errorView

    }

    // 没有数据View
    fileprivate func getRefreshNoDataView() -> BFRefreshNoDataView {
        let noDataView = BFRefreshNoDataView.init(frame: .zero)
        noDataView.refreshBlock = {[weak self] in
            guard let strongSelf = self else {
                return
            }
            if let _ = strongSelf.refreshBlock {
                strongSelf.refreshBlock!()
            }
        }
        self.refreshNoDataView = noDataView
        return noDataView

    }

    // 加载中
    fileprivate func getLoadingView() -> BFRefreshLoadingView {
        let loadingView = BFRefreshLoadingView()
        self.refreshLoadingView = loadingView
        return loadingView
    }

}

