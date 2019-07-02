//
//  Character+MM.swift
//  SwiftExtension
//
//  Created by sameway on 2019/6/13.
//  Copyright © 2019 sameway. All rights reserved.
//

import Foundation

public extension Character {
    
    //是否是数字
    var isNumber : Bool {
        return Int(String(self)) != nil
    }
    
    ///        是否是字母
    ///        Character("4").isLetter -> false
    ///        Character("a").isLetter -> true
    var isLetter : Bool {
        return String(self).rangeOfCharacter(from: .letters, options: .numeric, range: nil) != nil
    }
    
    //是否是小写
    var isLowercased: Bool {
        return String(self) == String(self).lowercased()
    }
    
    //是否是大写
    
    var isUppercased: Bool {
        return String(self) == String(self).uppercased()
    }
    
    //是否是空格
    var isWhiteSpace:Bool  {
        return String(self) == " "
    }
    
    ///        是否是表情
    ///        Character("😀").isEmoji -> true
    ///
    var isEmoji: Bool {
        // http://stackoverflow.com/questions/30757193/find-out-if-character-in-string-is-emoji
        let scalarValue = String(self).unicodeScalars.first!.value
        switch scalarValue {
        case 0x1F600...0x1F64F, // Emoticons
        0x1F300...0x1F5FF, // Misc Symbols and Pictographs
        0x1F680...0x1F6FF, // Transport and Map
        0x1F1E6...0x1F1FF, // Regional country flags
        0x2600...0x26FF, // Misc symbols
        0x2700...0x27BF, // Dingbats
        0xE0020...0xE007F, // Tags
        0xFE00...0xFE0F, // Variation Selectors
        0x1F900...0x1F9FF, // Supplemental Symbols and Pictographs
        127000...127600, // Various asian characters
        65024...65039, // Variation selector
        9100...9300, // Misc items
        8400...8447: // Combining Diacritical Marks for Symbols
            return true
        default:
            return false
        }
    }
    
    var int:Int? {
        return Int(String(self))
    }
    
    var string :String {
        return String(self)
    }
    
    var lowercased:Character {
        return String(self).lowercased().first!
    }
    
    var uppercased :Character {
        return String(self).uppercased().first!
    }
}

// MARK:复制

public extension Character {
    
    //* 复制
    //Character("-") * 10 -> "----------"
    static func * (lhs:Character, rhs:Int) -> String {
        guard rhs > 0 else {
            return ""
        }
        return String(repeating: String(lhs), count: rhs)
    }
}
