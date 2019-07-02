//
//  UISearchBar+MM.swift
//  SwiftExtension
//
//  Created by sameway on 2019/6/17.
//  Copyright © 2019 sameway. All rights reserved.
//

import UIKit

public extension UISearchBar {
    
    ////Text field inside search bar (if applicable).
    var textField :UITextField? {
        let subViews = subviews.flatMap{
            $0.subviews
        }
        guard let textField = (subViews.filter { $0 is UITextField }).first as? UITextField else {
            return nil
        }
        return textField
    }
    
    var trimmedText:String? {
        return text?.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
}
