//
//  YJUIViewControllerTransitioning.swift
//  Pods
//
//  Created by 阳君 on 2019/6/19.
//

import UIKit

/// UIViewController Present Dismiss 转场动画
@objcMembers
open class YJUIViewControllerTransitioning: NSObject {
    
    /// push 动画
    public var pushAT: YJUIViewControllerAnimatedTransitioning?
    /// pop 动画
    public var popAT: YJUIViewControllerAnimatedTransitioning?
    /// pop 的视图
    public weak var popVC: UIViewController? {
        willSet {
            newValue?.view.addGestureRecognizer(self.popGesture)
        }
    }
    /// pop 的手势
    public private(set) lazy var popGesture: UIPanGestureRecognizer = {
        let gesture = UIPanGestureRecognizer()
        gesture.addTarget(self, action: #selector(YJUIViewControllerTransitioning.panGestureRecognizerAction(pan:)))
        return gesture
    }()
    var popIT: UIPercentDrivenInteractiveTransition?

    /// 属性设置
    /// - parameter pushAT: push 动画
    /// - parameter popAT: pop 动画
    /// - parameter popVC: pop 的视图
    open func setPushAT(_ pushAT: YJUIViewControllerAnimatedTransitioning, popAT: YJUIViewControllerAnimatedTransitioning, popVC: UIViewController) {
        self.pushAT = pushAT
        self.popAT = popAT
        self.popVC = popVC
    }
    
    @objc
    func panGestureRecognizerAction(pan: UIPanGestureRecognizer) {
        var process = pan.translation(in: self.popVC!.view).x / self.popVC!.view.frameWidth
        process = min(1.0, max(0, process))
        switch pan.state {
        case .began:
            self.popIT = UIPercentDrivenInteractiveTransition()
            if let nc = self.popVC?.navigationController, nc.viewControllers.count > 1 {
                nc.popViewController(animated: true)
            } else {
                self.popVC?.dismiss(animated: true, completion: nil)
            }
        case.changed:
            self.popIT?.update(process)
        case .ended, .cancelled:
            if (process > 0.5) {
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
    
    ///  动画时间，默认0.5
    public var transitionDuration: TimeInterval = 0.5
    
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return self.transitionDuration
    }
    
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromView = transitionContext.view(forKey: .from),
            let toView = transitionContext.view(forKey: .to) else {
                return
        }
        self.animateTransition(using: transitionContext, fromView: fromView, toView: toView) { _ in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
    
    ///
    ///  @abstract 执行动画
    ///  @discusstion 子类实现
    ///
    ///  @param transitionContext id <UIViewControllerContextTransitioning>
    ///  @param fromView 当前 UIView
    ///  @param toView 将要显示的 UIView
    ///  @param completion 完成回调
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning, fromView: UIView, toView: UIView, completion: @escaping ((_ finished: Bool) -> Void)) {}
    
}


/// Present 动画
public class YJUIPresentVCAnimatedTransitioning: YJUIViewControllerAnimatedTransitioning {
    public override func animateTransition(using transitionContext: UIViewControllerContextTransitioning, fromView: UIView, toView: UIView, completion: @escaping ((_ finished: Bool) -> Void)) {
        transitionContext.containerView.addSubview(toView)
        toView.frameTop = UIScreen.main.bounds.size.height
        UIView.animate(withDuration: self.transitionDuration, animations: {
            toView.frameTop = 0
        }, completion: completion)
    }
}

/// Dismiss 动画
public class YJUIDismissVCAnimatedTransitioning: YJUIViewControllerAnimatedTransitioning {
    public override func animateTransition(using transitionContext: UIViewControllerContextTransitioning, fromView: UIView, toView: UIView, completion: @escaping ((_ finished: Bool) -> Void)) {
        transitionContext.containerView.insertSubview(toView, belowSubview: fromView)
        UIView.animate(withDuration: self.transitionDuration, animations: {
            fromView.frameTop = UIScreen.main.bounds.size.height;
        }, completion: completion)
    }
}

/// Push 动画
public class YJUIPushVCAnimatedTransitioning: YJUIViewControllerAnimatedTransitioning {
    public override func animateTransition(using transitionContext: UIViewControllerContextTransitioning, fromView: UIView, toView: UIView, completion: @escaping ((_ finished: Bool) -> Void)) {
        transitionContext.containerView.addSubview(toView)
        toView.frameLeft = fromView.frameRight
        UIView.animate(withDuration: self.transitionDuration, animations: {
            toView.frameLeft = fromView.frameLeft
        }, completion: completion)
    }
}

/// pop 动画
public class YJUIPopVCAnimatedTransitioning: YJUIViewControllerAnimatedTransitioning {
    public override func animateTransition(using transitionContext: UIViewControllerContextTransitioning, fromView: UIView, toView: UIView, completion: @escaping ((_ finished: Bool) -> Void)) {
        transitionContext.containerView.insertSubview(toView, belowSubview: fromView)
        fromView.frameLeft = 0
        UIView.animate(withDuration: self.transitionDuration, animations: {
            fromView.frameLeft = UIScreen.main.bounds.size.width;
        }, completion: completion)
    }
}
