//
//  YJUIScrollViewManager.swift
//  YJCocoa
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2019/5/23.
//  Copyright © 2016-现在 YJCocoa. All rights reserved.
//

import UIKit

/// UIScrollView滚动
public enum YJUIScrollViewScroll: Int {
    // 用户触摸，将要滚动
    case none
    
    /// 滚动到顶部
    case endTop
    /// 滚动到边缘顶部
    case edgeTop
    /// 向上滚动
    case didTop
    
    /// 向下滚动
    case didBottom
    /// 滚动到边缘底部
    case edgeBottom
    /// 滚动到底部
    case endBottom
    
    /// 滚动到最左
    case endLeft
    /// 滚动到边缘左
    case edgeLeft
    /// 向左滚动
    case didLeft
    
    /// 向右滚动
    case didRight
    /// 滚动到边缘右
    case edgeRight
    /// 滚动到最右
    case endRight
}

/// UIScrollView管理器
open class YJUIScrollViewManager: NSObject {
    
    public typealias DidScrollClosure = (_ scroll: YJUIScrollViewScroll) -> Void
    
    /// 已经滚动间隔,控制.Did...枚举提示间隔
    public var didSpacing: CGFloat = 30
    /// 边缘距离,控制.Edge...枚举提示区域,需edgeInset内值>endInset内值
    public var edgeInset = UIEdgeInsets.zero
    /// 边界距离,控制.End...枚举提示区域
    public var endInset = UIEdgeInsets.zero
    
    /// 垂直滚动回调
    public var didVerticalScrollClosure: DidScrollClosure?
    /// 水平滚动回调
    public var didHorizontalScrollClosure: DidScrollClosure?
    
    private var contentOffset = CGPoint.zero
    private var verticalScroll = YJUIScrollViewScroll.none {
        willSet {
            if newValue != self.verticalScroll || newValue == .none  {
                self.didVerticalScrollClosure!(newValue)
            }
        }
    }
    private var horizontalScroll = YJUIScrollViewScroll.none {
        willSet {
            if newValue != self.horizontalScroll || newValue == .none  {
                self.didHorizontalScrollClosure!(newValue)
            }
        }
    }
    
}

extension YJUIScrollViewManager: UIScrollViewDelegate {
    
    public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.contentOffset = scrollView.contentOffset
        if self.didVerticalScrollClosure != nil {
            self.verticalScroll = .none
        }
        if self.didHorizontalScrollClosure != nil {
            self.horizontalScroll = .none
        }
    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if self.didVerticalScrollClosure != nil {
            self.scrollViewDidVerticalScroll(scrollView)
        }
        if self.didHorizontalScrollClosure != nil {
            self.scrollViewDidHorizontalScroll(scrollView)
        }
    }
    
    func scrollViewDidVerticalScroll(_ scrollView: UIScrollView) {
        let y = scrollView.contentOffset.y;
        let maxY = scrollView.contentSize.height - scrollView.frameHeight
        guard maxY > 0 else {
            return
        }
        let spacing = y - self.contentOffset.y;
        if (y <= self.endInset.top) {
            self.verticalScroll = .endTop;
        } else if (y <= self.edgeInset.top) {
            self.verticalScroll = .edgeTop;
        } else if (y >= maxY - self.endInset.bottom) {
            self.verticalScroll = .endBottom;
        } else if (y >= maxY - self.edgeInset.bottom) {
            self.verticalScroll = .edgeBottom;
        } else if spacing <= -self.didSpacing {
            self.verticalScroll = .didTop;
        } else if spacing >= self.didSpacing {
            self.verticalScroll = .didBottom;
        } else {
            return
        }
        self.contentOffset.y = y;
    }
    
    func scrollViewDidHorizontalScroll(_ scrollView: UIScrollView) {
        let x = scrollView.contentOffset.x;
        let maxX = scrollView.contentSize.width - scrollView.frameWidth
        guard maxX > 0 else {
            return
        }
        let spacing = x - self.contentOffset.x;
        if (x <= self.endInset.left) {
            self.horizontalScroll = .endLeft;
        } else if (x <= self.edgeInset.left) {
            self.horizontalScroll = .edgeLeft;
        } else if (x >= maxX - self.endInset.right) {
            self.horizontalScroll = .endRight;
        } else if (x >= maxX - self.edgeInset.right) {
            self.horizontalScroll = .edgeRight;
        } else if spacing <= -self.didSpacing {
            self.horizontalScroll = .didLeft;
        } else if spacing >= self.didSpacing {
            self.horizontalScroll = .didRight;
        } else {
            return
        }
        self.contentOffset.x = x;
    }
    
}

