//
//  UITextField+MM.swift
//  SwiftExtension
//
//  Created by sameway on 2019/6/11.
//  Copyright © 2019 sameway. All rights reserved.
//

import UIKit

extension UITextField {
    
    @IBInspectable var mm_paddingLeft:CGFloat {
        get {
            guard let v = leftView else {
                return 0
            }
            return v.MM_Width
        }
        set {
            let paddingView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: newValue, height: frame.height))
            leftView = paddingView
            leftViewMode = .always
        }
    }
    
    var trimmedText:String  {
        return text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
    }
    
    func mm_addPaddingLeftIcon(_ image:UIImage,padding:CGFloat) {
        let imageView = UIImageView(image: image)
        imageView.contentMode = .center
        leftView = imageView
        leftView?.frame.size = CGSize(width: image.size.width + padding, height: image.size.height)
        leftViewMode = .always
    }
    
}
