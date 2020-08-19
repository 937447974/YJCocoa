//
//  YJUIRowActionTVCell.swift
//  YJCocoa
//
//  HomePage:https://github.com/937447974/YJCocoa
//
//  Created by 阳君 on 2020/8/19.
//  Copyright © 2016-现在 YJCocoa. All rights reserved.
//

import UIKit

/// 左滑 UITableViewRowAction 编辑 cell
open class YJUIRowActionTVCell: YJUITableViewCell {
    
    var beginX: CGFloat = 0
    /// 滑动最大区域
    public var panMaxWidth: CGFloat = 0
    /// 滑动的手势
    public lazy var panGesture: UIPanGestureRecognizer = {
        let gesture = UIPanGestureRecognizer()
        gesture.delegate = self
        gesture.addTarget(self, action: #selector(YJUIRowActionTVCell.gesturePanAction))
        return gesture
    }()
    /// 滑动的视图
    public lazy var sideView: UIView = UIView(frame: self.bounds)
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(self.sideView)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        self.sideView.frame = self.bounds
    }
    
    @objc
    func gesturePanAction() {
        switch self.panGesture.state {
        case .began:
            self.beginX = self.panGesture.translation(in: self).x
        case .changed:
            var left = self.panGesture.translation(in: self).x - self.beginX
            if left < -self.panMaxWidth {
                left = -self.panMaxWidth
            } else if left > 0 {
                left = 0
            }
            self.sideView.frameLeft = left
        default:
            let left = self.sideView.frameLeft < -self.panMaxWidth / 2 ? -self.panMaxWidth : 0
            UIView.animate(withDuration: 0.2) {
                self.sideView.frameLeft = left
            }
        }
    }
    
}

extension YJUIRowActionTVCell {
    
    open override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        guard gestureRecognizer == self.panGesture else {
            return super.gestureRecognizerShouldBegin(gestureRecognizer)
        }
        let translation = self.panGesture.translation(in: gestureRecognizer.view)
        return abs(translation.y) <= abs(translation.x)
    }
    
    open override func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer == self.panGesture {
            let translation = self.panGesture.translation(in: gestureRecognizer.view)
            if translation.x >= 0 || abs(translation.y) <= abs(translation.x) {
                return false
            }
        }
        if let gestureView = otherGestureRecognizer.view {
            return gestureView.isKind(of: UITableView.self)
        }
        return super.gestureRecognizer(gestureRecognizer, shouldRecognizeSimultaneouslyWith: otherGestureRecognizer)
    }
    
}

