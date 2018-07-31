//
//  BFRefreshNoDataView.swift
//  BFRefreshDemo
//
//  Created by HJQ on 2018/7/29.
//  Copyright © 2018年 HJQ. All rights reserved.
//

import UIKit

public class BFRefreshNoDataView: UIView {

    public var refreshBlock: BFRefreshRefreshingBlock?

    public var offsetY: CGFloat = 100
    public var imageViewSize = CGSize.init(width: 150.0, height: 150.0)

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        addSubview(tipImageView)
        addSubview(tipLabel)
        let ges = UITapGestureRecognizer.init(target: self, action: #selector(refresjAction))
        self.addGestureRecognizer(ges)
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override public func layoutSubviews() {
        super.layoutSubviews()
        tipImageView.frame = CGRect.init(x: (bounds.width - imageViewSize.width) / 2.0, y: offsetY, width: imageViewSize.width, height: imageViewSize.height)
        tipLabel.frame = CGRect.init(x: 10, y: tipImageView.frame.origin.y + tipImageView.frame.height + 20.0, width: bounds.width - 20, height: 20.0)
    }

    // MARK: - Event response
    @objc
    func refresjAction() {
        if let _ = refreshBlock {
            refreshBlock!()
        }
    }

    // MARK: - Lazy load
    public lazy var tipImageView: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage.init(named: "RefreshTableView.bundle/refreshtableview_defaultnodata", in: Bundle.init(for: BFRefreshNoDataView.self), compatibleWith: nil)
        imageView.image = image
        return imageView
    }()

    public lazy var tipLabel: UILabel = {
        let label = UILabel.init(frame: .zero)
        label.text = "暂无数据"
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = .gray
        label.textAlignment = .center
        label.backgroundColor = .clear
        return label
    }()


}
