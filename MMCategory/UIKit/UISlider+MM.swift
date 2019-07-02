//
//  UISlider+MM.swift
//  SwiftExtension
//
//  Created by sameway on 2019/6/17.
//  Copyright © 2019 sameway. All rights reserved.
//

import UIKit

public extension UISlider {
    
    func setValue(_ value: Float, animated: Bool = true, duration: TimeInterval = 1, completion: (() -> Void)? = nil) {
        if animated {
            UIView.animate(withDuration: duration, animations: {
                self.setValue(value, animated: true)
            }, completion: { _ in
                completion?()
            })
        } else {
            setValue(value, animated: false)
            completion?()
        }
    }
}
