//
//  YJUIPageViewManager.swift
//  Pods-YJPageView
//
//  Created by 阳君 on 2019/5/24.
//

import UIKit

open class YJUIPageViewManager: NSObject {
    
    /// cell 数据源
    public var dataSourceCell = Array<YJUIPageViewCellObject>()
    
    /// 当前页码
    public private(set) var index: Int = 0
    /// 是否循环展示, 默认 true 循环
    public var isLoop = true
    /// 是否取消阻力效果
    public var isDisableBounces = false
    
    /// YJUIPageViewController
    weak public private(set) var pageVC: YJUIPageViewController!
    
    private var cachePage = NSCache<NSString, YJUIPageViewCell>()
    private lazy var scrollView: UIScrollView? = {
        for view in self.pageVC.view.subviews {
            if let scrollView = view as? UIScrollView {
                return scrollView
            }
        }
        return nil
    }()
    
    init(pageViewController: YJUIPageViewController) {
        super.init()
        self.pageVC = pageViewController
        self.scrollView?.addObserver(self, forKeyPath: "contentOffset", options: .new, context: nil)
    }
    
    deinit {
        self.scrollView?.removeObserver(self, forKeyPath: "contentOffset")
    }
    
    /**
     * 前往指定界面
     * - Parameters:
     *   - index: 页码
     *   - animated: A Boolean value that indicates whether the transition is to be animated.
     *   - completion: A block to be called when the page-turn animation completes. The block takes the following parameters: finished true if the animation finished; false if it was skipped.
     */
    public func setIndex(_ index: Int, animated: Bool, completion: ((Bool) -> Void)? = nil) {
        guard let cell = self.pageViewCell(at: index) else {
            return
        }
        var vcs = [cell]
        if self.pageVC.spineLocation == .mid {
            if let cell1 = self.pageViewCell(at: index + 1) {
                vcs.append(cell1)
            } else if let cell1 = self.pageViewCell(at: index - 1) {
                vcs.insert(cell1, at: 0)
            }
        }
        let direction: UIPageViewController.NavigationDirection = index >= self.index ? .forward : .reverse
        self.pageVC.setViewControllers(vcs, direction: direction, animated: animated, completion: completion)
    }
    
}

extension YJUIPageViewManager {
    
    open override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        guard "contentOffset" == keyPath else {
            return
        }
        guard self.isDisableBounces else {
            return
        }
        var offset = self.scrollView!.contentOffset
        if self.index == 0 {
            switch (self.pageVC.navigationOrientation) {
            case .horizontal:
                guard offset.x < self.scrollView!.frameWidth else {
                    return
                }
                offset.x = self.scrollView!.frameWidth
                self.scrollView!.setContentOffset(offset, animated: false)
            case .vertical:
                guard offset.y < self.scrollView!.frameHeight else {
                    return
                }
                offset.y = self.scrollView!.frameHeight
                self.scrollView!.setContentOffset(offset, animated: false)
             default: return
            }
        } else if self.index == self.dataSourceCell.count - 1 {
            switch (self.pageVC.navigationOrientation) {
            case .horizontal:
                guard offset.x > self.scrollView!.frameWidth else {
                    return
                }
                offset.x = self.scrollView!.frameWidth
                self.scrollView!.setContentOffset(offset, animated: false)
            case .vertical:
                guard offset.y > self.scrollView!.frameHeight else {
                    return
                }
                offset.y = self.scrollView!.frameHeight
                self.scrollView!.setContentOffset(offset, animated: false)
            @unknown default: return
            }
        } else {
            return
        }
        self.scrollView!.setContentOffset(offset, animated: false)
    }
    
}

extension YJUIPageViewManager: UIPageViewControllerDataSource {
    
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let cell = viewController as! YJUIPageViewCell
        return self.pageViewCell(at: cell.cellObject.index - 1)
    }
    
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let cell = viewController as! YJUIPageViewCell
        return self.pageViewCell(at: cell.cellObject.index + 1)
    }
    
    private func pageViewCell(at index:Int) -> YJUIPageViewCell? {
        guard let co = self.cellObject(at: index) else {
            YJLogWarn("[YJPageView] 返回空cell")
            return nil
        }
        let key = "\(co.reuseIdentifier)-\(index)" as NSString
        var cell: YJUIPageViewCell! = self.cachePage.object(forKey: key)
        if cell == nil {
            cell = (co.cellClass as! YJUIPageViewCell.Type).init()
            self.cachePage.setObject(cell, forKey: key)
            if cell.view.backgroundColor == nil {
                cell.view.backgroundColor = UIColor.white
            }
            cell.cellDidAppear = {[unowned self] (index: Int) in
                self.index = index
            }
        }
        cell.pageViewManager(self, reloadWith: co)
        return cell
    }
    
    private func cellObject(at index:Int) -> YJUIPageViewCellObject? {
        guard self.dataSourceCell.count > 0 else {
            return nil
        }
        guard self.isLoop || (0 <= index && index < self.dataSourceCell.count) else {
            return nil
        }
        var index = index
        if index < 0 {
            index = self.dataSourceCell.count - 1
        } else if index >= self.dataSourceCell.count {
            index = 0
        }
        let co = self.dataSourceCell[index]
        co.index = index
        return co
    }
    
}

