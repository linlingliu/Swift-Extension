//
//  UIScrollView+MM.swift
//  SwiftExtension
//
//  Created by sameway on 2019/6/10.
//  Copyright © 2019 sameway. All rights reserved.
//

import UIKit

extension UIScrollView {
    
    open override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let tapView = super.hitTest(point, with: event)
        if let tapView = tapView {
            self.isScrollEnabled = !(tapView.isKind(of: UISlider.self))
        }
        return tapView
    }
}

extension UIScrollView {
    
    private var _originalFrame:CGRect? {
        set {
            mm_setAssociatedObject(key: "UIScrollIVewFrameKey", value: newValue)
        }
        get {
            return mm_getAssociatedObject(key: "UIScrollIVewFrameKey") as? CGRect
        }
    }
    
    public func mm_snpshotImage(reallySize:CGSize? = nil,blcok:((UIImage?)->Void)?) {
        if Thread.isMainThread {
            let clipSize:CGSize = reallySize ?? self.contentSize
            UIGraphicsBeginImageContextWithOptions(clipSize, false, UIScreen.main.scale)
            if let context = UIGraphicsGetCurrentContext() {
                self._originalFrame = self.frame
                var newframe = self.frame
                newframe.size.width = clipSize.width
                newframe.size.height = clipSize.height
                self.frame = newframe
                self.contentOffset = CGPoint.zero
                self.contentInset = UIEdgeInsets.zero
                self.alpha = 1.0
                self.isHidden = false
                self.transform = CGAffineTransform.identity
                self.layer.render(in: context)
                let img = UIGraphicsGetImageFromCurrentImageContext()
                UIGraphicsEndImageContext()
                if let originalFrame = self._originalFrame {
                    self.frame = originalFrame
                }
                blcok?(img)
            }else {
                blcok?(nil)
            }
            
        }else {
            DispatchQueue.main.async {
                self.mm_snpshotImage(reallySize: reallySize, blcok: blcok)
            }
        }
    }
}
