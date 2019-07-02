//
//  UIView+MM.swift
//  SwiftExtension
//
//  Created by sameway on 2019/6/10.
//  Copyright © 2019 sameway. All rights reserved.
//

import UIKit

extension UIView {
    
    /// x
    public var mm_x: CGFloat {
        set {
            
            var newFrame = self.frame
            newFrame.origin.x = newValue
            self.frame = newFrame
        }
        get { return self.frame.origin.x }
    }
    /// y
    public var mm_y: CGFloat {
        set {
            
            var newFrame = self.frame
            newFrame.origin.y = newValue
            self.frame = newFrame
        }
        get { return self.frame.origin.y }
    }
    /// width
    public var mm_width: CGFloat {
        set {
            
            var newFrame = self.frame
            newFrame.size.width = newValue
            self.frame = newFrame
        }
        get { return self.frame.size.width }
    }
    /// height
    public var mm_height: CGFloat {
        set {
            
            var newFrame = self.frame
            newFrame.size.height = newValue
            self.frame = newFrame
        }
        get { return self.frame.size.height }
    }
    /// size
    public var mm_size: CGSize {
        set {
            
            var newFrame = self.frame
            newFrame.size = newValue
            self.frame = newFrame
        }
        get { return self.frame.size }
    }
    
    /// center
    public var mm_center: CGPoint {
        set {
            
            var newCenter = self.center
            newCenter = newValue
            self.center = newCenter
        }
        get { return self.center }
    }
    /// 中心点x
    public var mm_centerX: CGFloat {
        set {
            
            var newCenter = self.center
            newCenter.x = newValue
            self.center = newCenter
        }
        get { return self.center.x }
    }
    /// 中心点y
    public var mm_centerY: CGFloat {
        set {
            
            var newCenter = self.center
            newCenter.y = newValue
            self.center = newCenter
        }
        get {
            return self.center.y
        }
    }
}

extension UIView {
    
    //MARK:设置为圆形控价
    public func mm_setCirlcleShape() {
        self.contentMode = .scaleAspectFill
        self.layer.cornerRadius = frame.height / 2.0
        self.clipsToBounds = true
    }
    
    //设置圆角
    public func mm_setCornerRadius(_ radius:CGFloat) {
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
    }
    
    //设置特定的圆角
    public func mm_setCorner(byRoundingCorner corners:UIRectCorner,radii:CGFloat) {
        let maskPath = UIBezierPath(roundedRect: CGRect.init(x: 0.0, y: 0.0, width: self.bounds.width, height: self.bounds.height), byRoundingCorners: corners, cornerRadii: CGSize(width: radii, height: radii))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = CGRect.init(x: 0.0, y: 0.0, width: UIScreen.main.bounds.width, height: self.bounds.height)
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer
    }
    
    public func mm_addTarget(action: Selector) {
        
        self.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer.init(target: self, action: action)
        self.addGestureRecognizer(tap)
    }
    
    public func mm_tapDismissKeyboard() {
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapDismissAction))
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: OperationQueue.main) { [weak self] (note) in
            
            self?.addGestureRecognizer(tap)
        }
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardDidHideNotification, object: nil, queue: OperationQueue.main) { [weak self] (note) in
            
            self?.removeGestureRecognizer(tap)
        }
    }
    @objc private func tapDismissAction() {
        
        self.endEditing(true)
    }
    
}

extension UIView {
    
    //返回视图快照
    @objc var mm_snapshotImage:UIImage? {
        UIGraphicsBeginImageContextWithOptions(bounds.size, isOpaque, UIScreen.main.scale)
        defer {
            UIGraphicsEndImageContext()
        }
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        layer.render(in: context)
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    /// 高性能的异步绘制圆角方法
    ///
    /// 原理是创建一个空白的图片，然后替换当前视图layer的contents
    ///
    /// 如果另外设置了backgroundColor属性，backgroundColor呈现的的背景颜色不会有圆角效果，需要搭配cornerRadius属性呈现圆角背景色
    ///
    /// 此方法指定的bgColor会在backgroundColor上层显示
    ///
    /// - Parameters:
    ///   - radius: 圆角半径
    ///   - corners: 圆角作用范围
    ///   - borderWidth: 边框宽度
    ///   - borderColor: 边框颜色
    ///   - bgColor: 背景颜色0
    func mm_roundedCorner(radius: CGFloat, corners: UIRectCorner = [.allCorners], borderWidth: CGFloat? = nil, borderColor: UIColor? = nil, bgColor: UIColor) {
        let size = bounds.size
        DispatchQueue.global().async {
            UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
            guard let context = UIGraphicsGetCurrentContext() else { return }
            defer { UIGraphicsEndImageContext() }
            if let borderWidth = borderWidth {
                context.setLineWidth(borderWidth)
            }
            
            if let borderColor = borderColor {
                context.setStrokeColor(borderColor.cgColor)
            } else {
                context.setStrokeColor(UIColor.clear.cgColor)
            }
            
            context.setFillColor(bgColor.cgColor)
            
            let halfBorderWidth = borderWidth ?? 0 / 2.0
            let width = size.width
            let height = size.height
            
            context.move(to: CGPoint(x: width - halfBorderWidth, y: radius + halfBorderWidth))
            if corners.contains(.bottomRight) || corners.contains(.allCorners) {
                // 右下角角度
                context.addArc(tangent1End: CGPoint(x: width - halfBorderWidth, y: height - halfBorderWidth),
                               tangent2End: CGPoint(x: width - radius - halfBorderWidth, y: height - halfBorderWidth), radius: radius)
            } else {
                context.addLine(to: CGPoint(x: width - halfBorderWidth, y: height - halfBorderWidth))
            }
            
            if corners.contains(.bottomLeft) || corners.contains(.allCorners) {
                //左下角角度
                context.addArc(tangent1End: CGPoint(x: halfBorderWidth, y: height - halfBorderWidth),
                               tangent2End: CGPoint(x: halfBorderWidth, y: height - radius - halfBorderWidth), radius: radius)
            } else {
                context.addLine(to: CGPoint(x: halfBorderWidth, y: height - halfBorderWidth))
            }
            
            if corners.contains(.topLeft) || corners.contains(.allCorners) {
                //左上角角度
                context.addArc(tangent1End: CGPoint(x: halfBorderWidth, y: halfBorderWidth),
                               tangent2End: CGPoint(x: width - halfBorderWidth, y: halfBorderWidth), radius: radius)
            } else {
                context.addLine(to: CGPoint(x: halfBorderWidth, y: halfBorderWidth ))
            }
            
            if corners.contains(.topRight) || corners.contains(.allCorners) {
                //右上角角度
                context.addArc(tangent1End: CGPoint(x: width - halfBorderWidth, y: halfBorderWidth),
                               tangent2End: CGPoint(x: width - halfBorderWidth, y: radius + halfBorderWidth), radius: radius)
            } else {
                context.addLine(to: CGPoint(x: width - halfBorderWidth, y: halfBorderWidth))
            }
            
            context.drawPath(using: .fillStroke)
            
            if let img = UIGraphicsGetImageFromCurrentImageContext() {
                DispatchQueue.main.async {
                    self.layer.contents = img.cgImage
                }
            }
        }
    }
    
    func mm_addShadow(ofColor color: UIColor = UIColor(red: 0.07, green: 0.47, blue: 0.57, alpha: 1.0), radius: CGFloat = 3, offset: CGSize = .zero, opacity: Float = 0.5) {
        layer.shadowColor = color.cgColor
        layer.shadowOffset = offset
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
        layer.masksToBounds = false
    }
    
}
