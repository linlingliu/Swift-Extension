//
//  UILabel+MM.swift
//  SwiftExtension
//
//  Created by sameway on 2019/6/11.
//  Copyright © 2019 sameway. All rights reserved.
//

import UIKit

extension UILabel {
    
    convenience init(text:String,font:UIFont = UIFont.systemFont(ofSize: 17.0),textColor:UIColor = UIColor.black) {
        self.init()
        self.font = font
        self.text = text
        self.textColor = textColor
    }
    
    func mm_labelHeight(fitWidth:CGFloat) -> CGFloat {
        guard let str:NSString = self.text as NSString? else { return 0 }
        let size = str.boundingRect(with: CGSize(width: fitWidth, height: CGFloat.greatestFiniteMagnitude), options: .usesLineFragmentOrigin, attributes: [.font:self.font!], context: nil)
       return size.height
    }
}
