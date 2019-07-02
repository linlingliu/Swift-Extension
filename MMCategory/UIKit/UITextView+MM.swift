//
//  UITextView+MM.swift
//  SwiftExtension
//
//  Created by sameway on 2019/6/10.
//  Copyright © 2019 sameway. All rights reserved.
//

import UIKit

extension UITextView {
    
    public var _placeholderView:UITextView? {
        set {
            mm_setAssociatedObject(key: "kUITextViewPlaceholderViewKey", value: newValue)
        }
        get {
           return mm_getAssociatedObject(key: "kUITextViewPlaceholderViewKey") as? UITextView
        }
    }
    
    public var mm_placeholder:String?  {
        set {
            mm_setAssociatedObject(key: "kUITextViewPlaceholderKey", value: newValue)
            self.mm_createPlaceholderView()
            self._placeholderView?.text = newValue
        }
        get {
            return mm_getAssociatedObject(key: "kUITextViewPlaceholderKey") as? String
        }
        
    }
    
    public var mm_limitTextLength:Int? {
        set {
            mm_setAssociatedObject(key: "kUITextViewLimitTextLengthKey", value: newValue)
            NotificationCenter.default.removeObserver(self)
            NotificationCenter.default.addObserver(self, selector: #selector(_textChangeNotification(no:)), name: UITextView.textDidChangeNotification, object: nil)
        }
        get {
            return mm_getAssociatedObject(key: "kUITextViewLimitTextLengthKey") as? Int
        }
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        self._placeholderView?.frame = CGRect(x: 0.0, y: 0.0, width: self.bounds.width, height: 100.0)
        self._placeholderView?.textColor = UIColor.lightGray
        // 字体
        self._placeholderView?.font = self.font
        self._placeholderView?.backgroundColor = self.backgroundColor
        self._placeholderView?.typingAttributes = self.typingAttributes
    }
    
    open override func didMoveToSuperview() {
        super.didMoveToSuperview()
        if self.superview == nil {
            NotificationCenter.default.removeObserver(self)
            self._placeholderView?.removeFromSuperview()
            self._placeholderView = nil
        }
    }
    
    public func mm_createPlaceholderView() {
        if self._placeholderView != nil {
            return
        }
        let textView = UITextView()
        textView.isUserInteractionEnabled = false
        textView.isScrollEnabled = false
        textView.setContentOffset(CGPoint.zero, animated: false)
        textView.backgroundColor = self.backgroundColor
        textView.font = self.font
        self.insertSubview(textView, at: 0)
        NotificationCenter.default.removeObserver(self)
        NotificationCenter.default.addObserver(self, selector: #selector(_textChangeNotification(no:)), name: UITextView.textDidChangeNotification, object: nil)
        self._placeholderView = textView
        
    }
    
    @objc private func _textChangeNotification(no:NSNotification) {
        guard let currentView = no.object as? UITextView else {
            return
        }
        let inputString:String = currentView.text ?? ""
        self._placeholderView?.isHidden = !inputString.isEmpty
        if let maxCount = self.mm_limitTextLength,maxCount > 0 {
            if inputString.count > maxCount && currentView.markedTextRange == nil {
                currentView.text = inputString.mm_subText(to: maxCount - 1)
            }
        }
    }
}
