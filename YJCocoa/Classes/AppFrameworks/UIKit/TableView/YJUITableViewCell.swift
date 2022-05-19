//
//  YJUITableViewCell.swift
//  YJCocoa
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2019/5/22.
//  Copyright © 2016-现在 YJCocoa. All rights reserved.
//

import UIKit

@objc extension UITableViewCell {
    
    /// 获取 YJUITableCellObject
    open class func cellObject() -> YJUITableCellObject {
        return YJUITableCellObject(cellClass: self)
    }
    
    /// 获取 YJUITableCellObject 并自动填充模型
    open class func cellObject(with cellModel: Any?) -> YJUITableCellObject {
        let co = self.cellObject()
        co.cellModel = cellModel
        return co
    }
    
    /// 获取 cell 的显示高
    open class func tableViewManager(_ tableViewManager: YJUITableViewManager, heightWith cellObject: YJUITableCellObject) -> CGFloat {
        return tableViewManager.tableView.rowHeight
    }
    
    /// 刷新 UITableViewCell
    open func tableViewManager(_ tableViewManager: YJUITableViewManager, reloadWith cellObject: YJUITableCellObject) {}
    
}

open class YJUITableViewCell: UITableViewCell {
    
    public private(set) var cellObject: YJUITableCellObject!
    public private(set) var tableViewManager: YJUITableViewManager!
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    open override func tableViewManager(_ tableViewManager: YJUITableViewManager, reloadWith cellObject: YJUITableCellObject) {
        super.tableViewManager(tableViewManager, reloadWith: cellObject)
        self.tableViewManager = tableViewManager
        self.cellObject = cellObject
    }
    
}
