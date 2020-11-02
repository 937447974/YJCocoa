//
//  UILinkTextView.swift
//  Pods
//
//  Created by 阳君 on 2020/1/6.
//

import UIKit

public extension YJLinkTextView {
    /// UILinkTextView的模型
    struct Model {
        public let attributedText: NSAttributedString
        public let isUserInteractionEnabled: Bool
        public let selectRanges: [NSRange]
    }
}

/// 响应链接的 TextView
open class YJLinkTextView: UITextView {
    
    var selectRects = [CGRect]()
    
    /// 创建模型Model
    public static func model(string str: String, attributes attrs: [NSAttributedString.Key : Any]? = nil) -> Model {
        let attributedText = NSMutableAttributedString(string: str, attributes: attrs)
        let regulaStr = "(((https?|ftp)://)|(www(\\.)){1})[-A-Za-z0-9+&@#/%?=~_|!:,;]+(\\.){1}[-A-Za-z0-9+&@#/:%=~_|.?]+"
        let regex = try! NSRegularExpression(pattern: regulaStr, options: .caseInsensitive)
        let matches = regex.matches(in: str, options: [], range: NSRange(location: 0, length: attributedText.length))
        var selectRanges = [NSRange]()
        for match in matches {
            let range = match.range
            selectRanges.append(range)
            var value = (str as NSString).substring(with: range)
            if !value.hasPrefix("http") { value = "https://" + value }
            attributedText.addAttribute(.link, value: value, range: range)
        }
        return Model(attributedText: attributedText, isUserInteractionEnabled: matches.count > 0, selectRanges: selectRanges)
    }
    
    open override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let view = super.hitTest(point, with: event)
        guard view == self else { return view }
        for rect in self.selectRects {
            if rect.contains(point) {
                return view
            }
        }
        return nil
    }
    
    open override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        self.resignFirstResponder()
        UIMenuController.shared.isMenuVisible = false
        return false
    }
    
    open func reloadData(_ model: Model) {
        self.attributedText = model.attributedText
        self.isUserInteractionEnabled = model.isUserInteractionEnabled
        self.selectRects.removeAll()
        for range in model.selectRanges {
            let beginning = self.beginningOfDocument
            let startPosition = self.position(from: beginning, offset: range.location)!
            let endPosition = self.position(from: beginning, offset: range.location + range.length)!
            let textRange = self.textRange(from: startPosition, to: endPosition)!
            let selectionRects = self.selectionRects(for: textRange)
            for selectionRect in selectionRects {
                self.selectRects.append(selectionRect.rect)
            }
        }
    }
    
}
