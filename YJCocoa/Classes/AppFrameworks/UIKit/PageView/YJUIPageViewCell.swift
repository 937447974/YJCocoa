//
//  YJUIPageViewCell.swift
//  YJCocoa
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2019/5/24.
//  Copyright © 2016-现在 YJCocoa. All rights reserved.
//

import UIKit

public protocol YJUIPageViewCellProtocol : UIViewController {
    var cellObject: YJUIPageViewCellObject! { get }
    var pageViewManager: YJUIPageViewManager! { get }
    var cellDidAppear: YJUIPageViewCell.DidAppearClosure! { get set }
    /// 获取 YJUITableCellObject
    static func cellObject() -> YJUIPageViewCellObject
    /// 获取 YJUITableCellObject 并自动填充模型
    static func cellObject(withCellModel cellModel: Any) -> YJUIPageViewCellObject
    /// 刷新 YJUIPageViewCell
    func pageViewManager(_ pageViewManager: YJUIPageViewManager, reloadWith cellObject: YJUIPageViewCellObject)
}

/// PageView 的 cell 基类
@objcMembers
open class YJUIPageViewCell: UIViewController, YJUIPageViewCellProtocol {
    
    /// 点击cell的回调
    public typealias DidAppearClosure = (_ index: Int) -> Void
    
    public private(set) var cellObject: YJUIPageViewCellObject!
    public private(set) var pageViewManager: YJUIPageViewManager!
    public var cellDidAppear: DidAppearClosure!
    
    // MARK: override
    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.cellDidAppear(self.cellObject.index)
        self.cellObject.didAppearClosure?(self.cellObject.index)
    }
    
    // MARK: YJCocoa
    /// 获取 YJUITableCellObject
    public class func cellObject() -> YJUIPageViewCellObject {
        return YJUIPageViewCellObject(cellClass: self)
    }
    
    /// 获取 YJUITableCellObject 并自动填充模型
    public class func cellObject(withCellModel cellModel: Any) -> YJUIPageViewCellObject {
        let co = self.cellObject()
        co.cellModel = cellModel
        return co
    }
    
    /// 刷新 YJUIPageViewCell
    open func pageViewManager(_ pageViewManager: YJUIPageViewManager, reloadWith cellObject: YJUIPageViewCellObject) {
        self.pageViewManager = pageViewManager
        self.cellObject = cellObject
    }
    
}
