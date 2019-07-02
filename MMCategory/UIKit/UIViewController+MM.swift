//
//  UIViewController+MM.swift
//  SwiftExtension
//
//  Created by sameway on 2019/6/10.
//  Copyright © 2019 sameway. All rights reserved.
//

import UIKit

extension UIViewController {
    /// 关闭自动调节
    ///
    /// - Parameter scrollview: 滚动视图
    public func mm_setAdjustsScrollviewInsets(_ scrollview: UIScrollView) {
        
        if #available(iOS 11.0, *) {
            scrollview.contentInsetAdjustmentBehavior = .never
        } else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
    }
    
    func addNotificationObserver(name:Notification.Name,selector:Selector) {
        NotificationCenter.default.addObserver(self, selector: selector, name: name, object: nil)
    }
    
    func removeNotificationObserver(name:Notification.Name) {
        NotificationCenter.default.removeObserver(self, name: name,object: nil)
    }
    func removeNotificationObserver() {
        NotificationCenter.default.removeObserver(self)
    }
    
    func addChildViewController(_ child: UIViewController, toContainerView containerView: UIView) {
        addChild(child)
        containerView.addSubview(child.view)
        child.didMove(toParent: self)
    }
    
    ///  Helper method to remove a UIViewController from its parent.
    func removeViewAndControllerFromParentViewController() {
        guard parent != nil else { return }
        
        willMove(toParent: nil)
        removeFromParent()
        view.removeFromSuperview()
    }
    
    @discardableResult
    func showAlert(title: String?, message: String?, buttonTitles: [String]? = nil, highlightedButtonIndex: Int? = nil, completion: ((Int) -> Void)? = nil) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        var allButtons = buttonTitles ?? [String]()
        if allButtons.count == 0 {
            allButtons.append("OK")
        }
        
        for index in 0..<allButtons.count {
            let buttonTitle = allButtons[index]
            let action = UIAlertAction(title: buttonTitle, style: .default, handler: { (_) in
                completion?(index)
            })
            alertController.addAction(action)
            // Check which button to highlight
            if let highlightedButtonIndex = highlightedButtonIndex, index == highlightedButtonIndex {
                if #available(iOS 9.0, *) {
                    alertController.preferredAction = action
                }
            }
        }
        present(alertController, animated: true, completion: nil)
        return alertController
    }}
