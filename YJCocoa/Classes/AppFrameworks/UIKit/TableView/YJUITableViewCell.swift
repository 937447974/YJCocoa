//
//  YJUITableViewCell.swift
//  YJTableView
//
//  Created by 阳君 on 2019/5/22.
//  Copyright © 2019 YJCocoa. All rights reserved.
//

import UIKit

@objc extension UITableViewCell {
    
    /// 获取 YJUITableCellObject
    public class func cellObject() -> YJUITableCellObject {
        return YJUITableCellObject(cellClass: self)
    }
    
    /// 获取 YJUITableCellObject 并自动填充模型
    open class func cellObject(withCellModel cellModel:AnyObject) -> YJUITableCellObject {
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
    
    private(set) var cellObject: YJUITableCellObject!
    private(set) var tableViewManager: YJUITableViewManager!
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override open func tableViewManager(_ tableViewManager: YJUITableViewManager, reloadWith cellObject: YJUITableCellObject) {
        super.tableViewManager(tableViewManager, reloadWith: cellObject)
        self.tableViewManager = tableViewManager
        self.cellObject = cellObject
    }
    
}
