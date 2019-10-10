//
//  YJUIViewControllerTransitioning.swift
//  YJCocoa
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2019/6/19.
//  Copyright © 2016-现在 YJCocoa. All rights reserved.
//

import UIKit

/// UIViewController Present Dismiss 转场动画
@objcMembers
open class YJUIViewControllerTransitioning: NSObject {
    
    public static let presentAT = YJUIPresentVCAnimatedTransitioning(isHidden: false)
    public static let dismissAT = YJUIDismissVCAnimatedTransitioning(isHidden: true)
    public static let pushAT = YJUIPushVCAnimatedTransitioning(isHidden: false)
    public static let popAT = YJUIPopVCAnimatedTransitioning(isHidden: true)

    /// push 动画
    public var pushAT: YJUIViewControllerAnimatedTransitioning?
    /// pop 动画
    public var popAT: YJUIViewControllerAnimatedTransitioning?
    /// 自定义 UIPresentationController 管理动画
    public var presentationControllerClass: UIPresentationController.Type?
    /// pop 的视图
    public weak var popVC: UIViewController? {
        willSet {
            dispatch_async_main {
                newValue?.view.addGestureRecognizer(self.popGesture)
            }            
        }
    }
    /// pop 的手势
    public private(set) lazy var popGesture: UIPanGestureRecognizer = {
        let gesture = UIScreenEdgePanGestureRecognizer()
        gesture.edges = UIRectEdge.left
        gesture.addTarget(self, action: #selector(YJUIViewControllerTransitioning.panGestureRecognizerAction(pan:)))
        return gesture
    }()
    var popIT: UIPercentDrivenInteractiveTransition?
    var popBeganTime: CFAbsoluteTime = 0
    
    public init(popVC: UIViewController? = nil) {
        super.init()
        self.popVC = popVC
    }
    
    /// 属性设置
    /// - parameter pushAT: push 动画
    /// - parameter popAT: pop 动画
    open func setPushAT(_ pushAT: YJUIViewControllerAnimatedTransitioning, popAT: YJUIViewControllerAnimatedTransitioning) {
        self.pushAT = pushAT
        self.popAT = popAT
    }
    
    @objc
    func panGestureRecognizerAction(pan: UIPanGestureRecognizer) {
        var process = pan.translation(in: self.popVC!.view).x / self.popVC!.view.frameWidth
        process = min(1.0, max(0, process))
        switch pan.state {
        case .began:
            self.popBeganTime = CFAbsoluteTimeGetCurrent()
            self.popIT = UIPercentDrivenInteractiveTransition()
            if let nc = self.popVC?.navigationController, nc.viewControllers.count > 1 {
                nc.popViewController(animated: true)
            } else {
                self.popVC?.dismiss(animated: true, completion: nil)
            }
        case.changed:
            self.popIT?.update(process)
        case .ended, .cancelled:
            if (process > 0.5 || (CFAbsoluteTimeGetCurrent() - self.popBeganTime < 0.5 && process > 0.2)) {
                self.popIT?.finish()
            } else {
                self.popIT?.cancel()
            }
            self.popIT = nil
        default:
            break
        }
    }
    
}

extension YJUIViewControllerTransitioning: UIViewControllerTransitioningDelegate {
    
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self.pushAT
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self.popAT
    }
    
    public func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return self.popIT
    }
    
    public func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return self.presentationControllerClass?.init(presentedViewController: presented, presenting: presenting)
    }
    
}

extension YJUIViewControllerTransitioning: UINavigationControllerDelegate {
    
    public func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return animationController.isEqual(self.popAT) ? self.popIT : nil;
    }
    
    
    public func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        switch operation {
        case .push: return self.pushAT
        case .pop:  return self.popAT
        default:    return nil
        }
    }
    
}

/// 转场动画基类
@objcMembers
open class YJUIViewControllerAnimatedTransitioning: NSObject & UIViewControllerAnimatedTransitioning {
    
    ///  动画时间，默认0.3
    public var transitionDuration: TimeInterval = 0.3
    /// 是否隐藏
    public var isHidden: Bool = false
    
    public init(isHidden: Bool) {
        super.init()
        self.isHidden = isHidden
    }
    
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return self.transitionDuration
    }
    
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromView = transitionContext.view(forKey: .from),
            let toView = transitionContext.view(forKey: .to) else {
                return
        }
        let containerView = transitionContext.containerView
        if self.isHidden {
            containerView.insertSubview(toView, belowSubview: fromView)
        } else {
            containerView.addSubview(toView)
        }
        self.animateTransition(using: transitionContext, fromView: fromView, toView: toView) { [unowned self] _ in
            let toFrame = toView.frame
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            toView.frame = toFrame
            if !self.isHidden {
                containerView.insertSubview(fromView, belowSubview: toView)
            }
        }
    }
    
    ///
    ///  @abstract 执行动画
    ///
    ///  @param transitionContext UIViewControllerContextTransitioning
    ///  @param fromView 当前 UIView
    ///  @param toView 将要显示的 UIView
    ///  @param completion 完成回调
    open func animateTransition(using transitionContext: UIViewControllerContextTransitioning, fromView: UIView, toView: UIView, completion: @escaping ((_ finished: Bool) -> Void)) {
        fatalError("animateTransition(using:, fromView:, toView:) has not been implemented")
    }
    
}

/// 带暗淡的界面动画
open class YJUIDimmingVCAnimatedTransitioning: YJUIViewControllerAnimatedTransitioning {
    
    /// 暗淡视图
    public var dimmingView: UIView!
    
    public override init(isHidden: Bool) {
        super.init(isHidden: isHidden)
        self.dimmingView = UIView(frame: CGRect())
        self.dimmingView.backgroundColor = UIColor.black.withAlphaComponent(0.3)
    }
    
    public override func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromView = transitionContext.view(forKey: .from),
            let toView = transitionContext.view(forKey: .to) else {
                return
        }
        let containerView = transitionContext.containerView
        if self.isHidden {
            containerView.insertSubview(toView, belowSubview: fromView)
            containerView.insertSubview(self.dimmingView, belowSubview: fromView)
        } else {
            self.dimmingView.frame = fromView.frame
            containerView.insertSubview(toView, aboveSubview: fromView)
            containerView.insertSubview(self.dimmingView, aboveSubview: fromView)
        }
        self.animateTransition(using: transitionContext, fromView: fromView, toView: toView) { [unowned self] _ in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            if transitionContext.transitionWasCancelled {
                if self.isHidden {
                    containerView.insertSubview(self.dimmingView, belowSubview: fromView)
                }
            } else if !self.isHidden {
                containerView.insertSubview(fromView, belowSubview: toView)
                containerView.insertSubview(self.dimmingView, belowSubview: toView)
            }
        }
    }
    
}

/// Present 动画
public class YJUIPresentVCAnimatedTransitioning: YJUIViewControllerAnimatedTransitioning {
    public override func animateTransition(using transitionContext: UIViewControllerContextTransitioning, fromView: UIView, toView: UIView, completion: @escaping ((_ finished: Bool) -> Void)) {
        toView.frameTop = UIScreen.main.bounds.size.height
        UIView.animate(withDuration: self.transitionDuration, animations: {
            toView.frameTop = 0
        }, completion: completion)
    }
}

/// Dismiss 动画
public class YJUIDismissVCAnimatedTransitioning: YJUIViewControllerAnimatedTransitioning {
    public override func animateTransition(using transitionContext: UIViewControllerContextTransitioning, fromView: UIView, toView: UIView, completion: @escaping ((_ finished: Bool) -> Void)) {
        UIView.animate(withDuration: self.transitionDuration, animations: {
            fromView.frameTop = UIScreen.main.bounds.size.height;
        }, completion: completion)
    }
}

/// Push 动画
public class YJUIPushVCAnimatedTransitioning: YJUIViewControllerAnimatedTransitioning {
    public override func animateTransition(using transitionContext: UIViewControllerContextTransitioning, fromView: UIView, toView: UIView, completion: @escaping ((_ finished: Bool) -> Void)) {
        toView.frameLeft = fromView.frameRight
        UIView.animate(withDuration: self.transitionDuration, animations: {
            toView.frameLeft = fromView.frameLeft
        }, completion: completion)
    }
}

/// pop 动画
public class YJUIPopVCAnimatedTransitioning: YJUIViewControllerAnimatedTransitioning {
    public override func animateTransition(using transitionContext: UIViewControllerContextTransitioning, fromView: UIView, toView: UIView, completion: @escaping ((_ finished: Bool) -> Void)) {
        fromView.frameLeft = 0
        UIView.animate(withDuration: self.transitionDuration, animations: {
            fromView.frameLeft = UIScreen.main.bounds.size.width;
        }, completion: completion)
    }
}
