//
//  YJUITableView.swift
//  YJCocoa
//
//  HomePage:https://github.com/937447974/YJCocoa
//
//  Created by 阳君 on 2019/5/23.
//  Copyright © 2016-现在 YJCocoa. All rights reserved.
//

import UIKit

/// UITableView
@objcMembers
open class YJUITableView: UITableView {
    
    /// 管理器
    public var manamger: YJUITableViewManager!
    /// header 数据源
    public var dataSourceHeader: Array<YJUITableCellObject> {
        get {return self.manamger.dataSourceHeader}
        set {self.manamger.dataSourceHeader = newValue}
    }
    /// cell 数据源
    public var dataSourceCell: Array<Array<YJUITableCellObject>> {
        get {return self.manamger.dataSourceCell}
        set {self.manamger.dataSourceCell = newValue}
    }
    /// cell 第一组数据源
    public var dataSourceCellFirst: Array<YJUITableCellObject> {
        get {return self.manamger.dataSourceCellFirst}
        set {self.manamger.dataSourceCellFirst = newValue}
    }
    
    public override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        self.manamger = YJUITableViewManager(tableView: self)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
