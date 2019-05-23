//
//  YJUITableViewManager.swift
//  YJTableView
//
//  Created by 阳君 on 2019/5/22.
//  Copyright © 2019 YJCocoa. All rights reserved.
//

import UIKit

/// 缓存高的策略
public enum YJUITableViewCacheHeight : Int {
    /// 根据相同的UITableViewCell类缓存高度
    case `default`
    /// 根据NSIndexPath对应的位置缓存高度
    case indexPath
    /// 根据类名和NSIndexPath双重绑定缓存高度
    case classAndIndexPath
}

/** UITableView管理器*/
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
    
    /// 是否缓存高，默认缓存
    public var isCacheHeight = true
    /// 缓存高的策略
    public var cacheHeight = YJUITableViewCacheHeight.default
    
    weak private(set) var tableView: UITableView!
    
    private var identifierSet = Set<String>()
    private var cacheHeightDict = Dictionary<String, CGFloat>()
    
    init(tableView: UITableView) {
        super.init()
        self.tableView = tableView
        self.dataSourceCellFirst = Array()
    }
    
}

extension YJUITableViewManager: UITableViewDataSource {
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return self.dataSourceCell.count
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard section < self.dataSourceCell.count else {
            print("error:数组越界; selector:\(#function)")
            return 0
        }
        return self.dataSourceCell[section].count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard indexPath.section < self.dataSourceCell.count && indexPath.row < self.dataSourceCell[indexPath.section].count else {
            print("error:数组越界; selector:\(#function)")
            return YJUITableViewCell.init(style: .default, reuseIdentifier: "YJUITableViewCell")
        }
        let co = self.dataSourceCell[indexPath.section][indexPath.row]
        co.indexPath = indexPath
        return self.dequeueReusableCell(withCellObject: co)
    }
    
    private func dequeueReusableCell(withCellObject cellObject: YJUITableCellObject) -> UITableViewCell {
        if !self.identifierSet.contains(cellObject.reuseIdentifier) {
            self.tableView.register(cellObject.cellClass, forCellReuseIdentifier: cellObject.reuseIdentifier)
            self.identifierSet.insert(cellObject.reuseIdentifier)
        }
        let cell = self.tableView.dequeueReusableCell(withIdentifier: cellObject.reuseIdentifier, for: cellObject.indexPath)
        cell.tableViewManager(self, reloadWith: cellObject)
        return cell
    }
    
    private func dequeueReusableHeaderFooterView(withCellObject cellObject: YJUITableCellObject)  -> UITableViewHeaderFooterView? {
        if !self.identifierSet.contains(cellObject.reuseIdentifier) {
            self.tableView.register(cellObject.cellClass, forHeaderFooterViewReuseIdentifier: cellObject.reuseIdentifier)
            self.identifierSet.insert(cellObject.reuseIdentifier)
        }
        let view = self.tableView.dequeueReusableHeaderFooterView(withIdentifier: cellObject.reuseIdentifier)
        view?.tableViewManager(self, reloadWith: cellObject)
        return view
    }
    
}

extension YJUITableViewManager: UITableViewDelegate {
    
    // MARK: cell
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let co = self.cellObject(with: indexPath) else {
            print("error:数组越界; selector:\(#function)")
            return tableView.rowHeight
        }
        return self.tableView(tableView, heightFor: co)
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let co = self.cellObject(with: indexPath) {
            if let block = co.didSelectBlock {
                block(self, co)
            }
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
        let key = self.getKeyFromCellObject(cellObject)
        if self.isCacheHeight {
            if let height = self.cacheHeightDict[key] {
                return height
            }
        }
        var height = tableView.rowHeight
        if let cellType = cellObject.cellClass as? UITableViewCell.Type {
            height = cellType.tableViewManager(self, heightWith: cellObject)
        } else if let headerType = cellObject.cellClass as? UITableViewHeaderFooterView.Type {
            height = headerType.tableViewManager(self, heightWith: cellObject)
        }
        if self.isCacheHeight {
            self.cacheHeightDict[key] = height
        }
        return height
    }
    
    private func getKeyFromCellObject(_ cellObject: YJUITableCellObject) -> String {
        let indexPath = cellObject.indexPath!
        switch self.cacheHeight {
        case .`default`:
            return cellObject.cellName
        case .indexPath:
            return "\(indexPath.section)-\(indexPath.row)"
        case .classAndIndexPath:
            return "\(cellObject.cellName)(\(indexPath.section)-\(indexPath.row))"
        }
    }
    
}
