//
//  YJUITableViewHeaderFooterView.swift
//  YJCocoa
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2019/5/23.
//  Copyright © 2016-现在 YJCocoa. All rights reserved.
//

import UIKit

@objc extension UITableViewHeaderFooterView {
    
    /// 获取 YJUITableCellObject
    public class func cellObject() -> YJUITableCellObject {
        return YJUITableCellObject(cellClass: self)
    }
    
    /// 获取YJUITableCellObject并自动填充模型
    public class func cellObject(withCellModel cellModel:AnyObject) -> YJUITableCellObject {
        let co = self.cellObject()
        co.cellModel = cellModel
        return co
    }
    
    /// 获取 header 的显示高
    open class func tableViewManager(_ tableViewManager: YJUITableViewManager, heightWith cellObject: YJUITableCellObject) -> CGFloat {
        return tableViewManager.tableView.sectionHeaderHeight
    }
    
    /// 刷新 UITableViewHeaderFooterView
    @objc func tableViewManager(_ tableViewManager: YJUITableViewManager, reloadWith cellObject: YJUITableCellObject) {}
    
}

open class YJUITableViewHeaderFooterView: UITableViewHeaderFooterView {
    
    private(set) var cellObject: YJUITableCellObject!
    private(set) var tableViewManager: YJUITableViewManager!
    
    open override var reuseIdentifier: String? {
        return super.reuseIdentifier ?? NSStringFromClass(self.classForCoder)
    }
    
    open override func tableViewManager(_ tableViewManager: YJUITableViewManager, reloadWith cellObject: YJUITableCellObject) {
        super.tableViewManager(tableViewManager, reloadWith: cellObject)
        self.tableViewManager = tableViewManager
        self.cellObject = cellObject
    }
    
}
