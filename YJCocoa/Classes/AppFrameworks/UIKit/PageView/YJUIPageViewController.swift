//
//  YJUIPageViewController.swift
//  Pods
//
//  Created by 阳君 on 2019/5/24.
//

import UIKit

open class YJUIPageViewController: UIPageViewController {

    /// 管理器
    public var manamger: YJUIPageViewManager!
    /// cell 数据源
    public var dataSourceCell: Array<YJUIPageViewCellObject> {
        get {return self.manamger.dataSourceCell}
        set {self.manamger.dataSourceCell = newValue}
    }

    public override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        super.init(transitionStyle: style, navigationOrientation: navigationOrientation, options: options)
        self.manamger = YJUIPageViewManager(pageViewController: self)
        self.dataSource = self.manamger
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 刷新pageVC
    public func reloadData() {
        self.manamger.setIndex(0, animated: false)
    }
    
}
