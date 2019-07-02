//
//  NSAttributedString+MM.swift
//  SwiftExtension
//
//  Created by sameway on 2019/6/17.
//  Copyright © 2019 sameway. All rights reserved.
//

import UIKit

public extension NSAttributedString {
    
    var bolded:NSAttributedString {
        return applying(attributes: [.font: UIFont.boldSystemFont(ofSize: UIFont.systemFontSize)])
    }
    
    var underlined :NSAttributedString {
        return applying(attributes: [.underlineStyle:NSUnderlineStyle.single.rawValue])
    }
    
    //Struckthrough string
    var struckthrough:NSAttributedString {
         return applying(attributes: [.strikethroughStyle: NSNumber(value: NSUnderlineStyle.single.rawValue as Int)])
    }
    
    func colored(color:UIColor) -> NSAttributedString {
        return applying(attributes: [.foregroundColor: color])
    }
    
}
public extension NSAttributedString {
    
    //Applies given attributes to the new instance of NSAttributedString initialized with self object
    fileprivate func applying(attributes:[NSAttributedString.Key:Any]) -> NSAttributedString {
        let copy = NSMutableAttributedString(attributedString: self)
        let range = (string as NSString).range(of: string)
        copy.addAttributes(attributes, range: range)
        return copy
    }
    
    //Apply attributes to substrings matching a regular expression
    func applying(attributes:[NSAttributedString.Key:Any],toRangesMatching pattern:String) -> NSAttributedString {
        guard let pattern = try? NSRegularExpression(pattern: pattern, options: []) else { return self }
        
        let matches = pattern.matches(in: string, options: [], range: NSRange(0..<length))
        let result = NSMutableAttributedString(attributedString: self)
        
        for match in matches {
            result.addAttributes(attributes, range: match.range)
        }
        
        return result
    }
    
    func applying<T:StringProtocol>(attributes:[NSAttributedString.Key:Any],toOccurrencesOf target:T) -> NSAttributedString {
        let pattern = "\\Q\(target)\\E"
        return applying(attributes: attributes,toRangesMatching: pattern)
    }
}

public extension NSAttributedString {
    
    //Add a NSAttributedString to another NSAttributedString.
    static func += (lhs:inout NSAttributedString,rhs:NSAttributedString) {
        let string = NSMutableAttributedString(attributedString: lhs)
        string.append(rhs)
        lhs = string
    }
    
    static func + (lhs: NSAttributedString, rhs: NSAttributedString) -> NSAttributedString {
        let string = NSMutableAttributedString(attributedString: lhs)
        string.append(rhs)
        return NSAttributedString(attributedString: string)
    }
}
