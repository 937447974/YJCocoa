//
//  YJUITableViewManager.swift
//  YJCocoa
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2019/5/22.
//  Copyright © 2016-现在 YJCocoa. All rights reserved.
//

import UIKit

/** UITableView管理器*/
@objcMembers
open class YJUITableViewManager: NSObject {
    
    /// header 数据源
    public var dataSourceHeader = Array<YJUITableCellObject>()
    /// cell 数据源
    public var dataSourceCell = Array<Array<YJUITableCellObject>>()
    /// cell 第一组数据源
    public var dataSourceCellFirst: Array<YJUITableCellObject> {
        get {return self.dataSourceCell.first!}
        set {
            if self.dataSourceCell.count > 0 {
                self.dataSourceCell[0] = newValue
            } else {
                self.dataSourceCell.append(newValue)
            }            
        }
    }
    
    /// 是否缓存cell
    public var isCacheCell = true
    /// 是否缓存高，默认缓存
    public var isCacheHeight = true
    
    weak public private(set) var tableView: UITableView!
    
    private var identifierSet = Set<String>()
    private var cacheHeightDict = Dictionary<String, CGFloat>()
    
    public init(tableView: UITableView) {
        super.init()
        self.dataSourceCellFirst = Array()
        self.tableView = tableView
        tableView.delegate = self
        tableView.dataSource = self
    }
    
}

extension YJUITableViewManager: UITableViewDataSource {
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return self.dataSourceCell.count
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard section < self.dataSourceCell.count else {
            YJLogWarn("error:数组越界; selector:\(#function)")
            return 0
        }
        return self.dataSourceCell[section].count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard indexPath.section < self.dataSourceCell.count && indexPath.row < self.dataSourceCell[indexPath.section].count else {
            YJLogWarn("error:数组越界; selector:\(#function)")
            return YJUITableViewCell.init(style: .default, reuseIdentifier: "YJUITableViewCell")
        }
        let co = self.dataSourceCell[indexPath.section][indexPath.row]
        co.indexPath = indexPath
        return self.dequeueReusableCell(withCellObject: co)
    }
    
    private func dequeueReusableCell(withCellObject cellObject: YJUITableCellObject) -> UITableViewCell {
        let identifier = cellObject.reuseIdentifier
        if !self.identifierSet.contains(identifier) {
            self.identifierSet.insert(identifier)
            self.tableView.register(cellObject.cellClass, forCellReuseIdentifier: identifier)
        }
        let cell = self.isCacheCell ? self.tableView.dequeueReusableCell(withIdentifier: identifier, for: cellObject.indexPath) : self.tableView.dequeueReusableCell(withIdentifier: identifier)!
        cell.tableViewManager(self, reloadWith: cellObject)
        return cell
    }
    
    private func dequeueReusableHeaderFooterView(withCellObject cellObject: YJUITableCellObject)  -> UITableViewHeaderFooterView? {
        let identifier = cellObject.reuseIdentifier
        if !self.identifierSet.contains(identifier) {
            self.identifierSet.insert(identifier)
            self.tableView.register(cellObject.cellClass, forHeaderFooterViewReuseIdentifier: identifier)
        }
        let view = self.tableView.dequeueReusableHeaderFooterView(withIdentifier: identifier)
        view?.tableViewManager(self, reloadWith: cellObject)
        return view
    }
    
}

extension YJUITableViewManager: UITableViewDelegate {
    
    // MARK: cell
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let co = self.cellObject(with: indexPath) else {
            YJLogWarn("error:数组越界; selector:\(#function)")
            return tableView.rowHeight
        }
        return self.tableView(tableView, heightFor: co)
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let co = self.cellObject(with: indexPath) {
            co.didSelectClosure?(self, co)
        }
    }
    
    // MARK: header
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard let co = self.cellHeaderObject(with: section) else {
            return tableView.sectionHeaderHeight
        }
        return self.tableView(tableView, heightFor: co)
    }
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let co = self.cellHeaderObject(with: section) else {
            return nil
        }
        return self.dequeueReusableHeaderFooterView(withCellObject: co)
    }
    
    // MARK: private
    private func cellObject(with indexPath: IndexPath) -> YJUITableCellObject? {
        guard indexPath.section < self.dataSourceCell.count && indexPath.row < self.dataSourceCell[indexPath.section].count else {
            return nil
        }
        let co = self.dataSourceCell[indexPath.section][indexPath.row]
        co.indexPath = indexPath
        return co
    }
    
    private func cellHeaderObject(with section: Int) -> YJUITableCellObject? {
        guard section < self.dataSourceHeader.count else {
            return nil
        }
        let co = self.dataSourceHeader[section]
        co.indexPath = IndexPath(row: 0, section: section)
        return co
    }
    
    private func tableView(_ tableView: UITableView, heightFor cellObject: YJUITableCellObject) -> CGFloat {
        if self.isCacheHeight, let height = cellObject.height {
            return height
        }
        cellObject.height = tableView.rowHeight
        if let cellType = cellObject.cellClass as? UITableViewCell.Type {
            cellObject.height = cellType.tableViewManager(self, heightWith: cellObject)
        } else if let headerType = cellObject.cellClass as? UITableViewHeaderFooterView.Type {
            cellObject.height = headerType.tableViewManager(self, heightWith: cellObject)
        }
        return cellObject.height! >= 0 ? cellObject.height! : UITableView.automaticDimension
    }
    
}
