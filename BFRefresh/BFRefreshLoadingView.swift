//
//  BFRefreshLoadingView.swift
//  BFRefreshDemo
//
//  Created by HJQ on 2018/7/29.
//  Copyright © 2018年 HJQ. All rights reserved.
//

import UIKit

public class BFRefreshLoadingView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        addSubview(loadingView)
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override public func layoutSubviews() {
        super.layoutSubviews()
        loadingView.frame = CGRect.init(x: (frame.width - 20.0) / 2, y: 130, width: 30, height: 30)
    }

    // MARK: - Lazy load
    public lazy var loadingView: UIActivityIndicatorView = {
        let indicatorView = UIActivityIndicatorView.init(frame: .zero)
        let style = UIActivityIndicatorViewStyle.gray
        indicatorView.activityIndicatorViewStyle = style
        indicatorView.startAnimating()
        return indicatorView
    }()

}
