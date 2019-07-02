//
//  UIImage+MM.swift
//  SwiftExtension
//
//  Created by sameway on 2019/6/10.
//  Copyright © 2019 sameway. All rights reserved.
//

import UIKit

public extension UIImage {
    
    var original:UIImage {
        return withRenderingMode(.alwaysOriginal)
    }
    
}

public extension UIImage {
    
    static func mm_imageWithColor(_ color:UIColor) -> UIImage? {
        let rect = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        let result = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return result
    }
}

