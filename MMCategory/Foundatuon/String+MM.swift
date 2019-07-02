//
//  String+MM.swift
//  SwiftExtension
//
//  Created by sameway on 2019/6/6.
//  Copyright © 2019 sameway. All rights reserved.
//

import Foundation
import UIKit

extension String {
    
    public var mm_parmaters:[String:String] {
        var dic:[String:String] = [:]
        let urlComponents = URLComponents(string: self)
        for obj in urlComponents?.queryItems ?? [] {
            dic[obj.name] = obj.value ?? ""
        }
        return dic
    }
    
    public func mm_toURL() -> URL? {
        return URL(string: self)
    }
    
    //MARK: 时间戳转字符串
    
}

extension String {
    
    //去除首位空格
    public func mm_removeWhiteSpaces() -> String {
        return self.trimmingCharacters(in: .whitespaces)
    }
    //去除左右空格和换行符
    public func mm_removeWhitespacesAndLines() -> String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    //插入字符串
    
    @discardableResult
    public mutating func mm_Insert(_ text:String, at index:Int) -> String {
        if index > count || index < 0 {
            return self
        }
        let insertIndex = self.index(startIndex, offsetBy: index)
        insert(contentsOf: text, at: insertIndex)
        return self
    }
    
    //插入字符
    @discardableResult
    public mutating func mm_Insert(_ text:Character, at index:Int) -> String {
        if index > count || index < 0 {
            return self
        }
        let insertIndex = self.index(startIndex, offsetBy: index)
        insert(text, at: insertIndex)
        return self
    }
    
    //删除字符串
    @discardableResult
    public mutating func mm_remove(_ text:String) -> String {
        if let removeIndex = range(of: text) {
            removeSubrange(removeIndex)
        }
        return self
    }
    
    //删除指定位置的字符串
    @discardableResult
    public mutating func mm_remove(at index:Int, lenght:Int) -> String {
        if index > count || index < 0 || lenght < 0 || index + lenght > 0 {
            return self
        }
        let _startIndex = self.index(startIndex, offsetBy: index)
        let _endIndex = self.index(_startIndex, offsetBy: lenght)
        removeSubrange(_startIndex..._endIndex)
        return self
    }
    
    //删除字符
    @discardableResult
    public mutating func mm_remove(at index: Int) -> String {
        if index > count - 1 || index < 0 {
            return self
        }
        let removeIndex = self.index(startIndex, offsetBy: index)
        remove(at: removeIndex)
        return self
    }
    
    //裁剪字符串
    public func mm_subText(from:Int = 0, to:Int) -> String {
        if from > to  {
            return self
        }
        let _start = self.startIndex
        let _fromIndex = self.index(_start, offsetBy: max(min(from,self.count - 1), 0))
        let _toIndex = self.index(_start, offsetBy: min(max(to,0),self.count - 1))
        return String(self[_fromIndex..._toIndex])
    }
    
    //裁剪字符串
    //str[0,10]
    subscript(_ from:Int, _ to:Int) -> String {
        return self.mm_subText(from: from, to: to)
    }
    
    //替换指定区域的内容
    public func mm_replaceStr(range:NSRange,text:String) -> String {
        var result :String = self
        if let _range = Range.init(range, in: text) {
            result.replaceSubrange(_range, with: text)
        }else{
            debugPrint("裁剪字符串范围错误")
        }
        return result
    }
    
    public var mm_isEmpty:Bool {
        if self.isEmpty {
            return true
        }
        return self.mm_removeWhitespacesAndLines().isEmpty
    }
}

extension String {
    /// 正则是否匹配-谓词方式
    ///
    /// - Parameter str: str
    /// - Returns: 是否
    public func mm_isRegularCorrect(_ str: String) -> Bool {
        
        return NSPredicate(format: "SELF MATCHES %@", str).evaluate(with: self)
    }
}

extension String {
    
    //json转为任意类型
    public func mm_jsonToObject() -> Any? {
        if self.mm_isEmpty {
            return nil
        }
        if let data = self.data(using: .utf8) {
            return try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)
        }
        return nil
    }
    
    //MARK: 计算文字尺寸
    /// 计算文字尺寸
    ///
    /// - Parameters:
    ///   - size: 包含一个最大的值 CGSize(width: max, height: 20.0)
    ///   - font: 字体大小
    /// - Returns: 尺寸
    public func mm_boundingSize(size: CGSize, font: UIFont) -> CGSize {
        return NSString(string: self).boundingRect(with: size, options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: [NSAttributedString.Key.font : font], context: nil).size
    }
}

public extension String {
    
    ///  String decoded from base64 (if applicable).
    ///
    ///        "SGVsbG8gV29ybGQh".base64Decoded = Optional("Hello World!")
    var base64Decoded :String? {
        guard let decodedData = Data(base64Encoded: self) else { return nil }
        return String(data: decodedData, encoding: .utf8)
    }
    
    ///  String encoded in base64 (if applicable).
    ///
    ///        "Hello World!".base64Encoded -> Optional("SGVsbG8gV29ybGQh")
    var base64Encoded : String? {
        let plainData = data(using: .utf8)
        return plainData?.base64EncodedString()
        
    }
    
    ///  Check if string contains one or more letters.
    ///
    ///        "123abc".hasLetters -> true
    ///        "123".hasLetters -> false
    ///
    var hasLetters:Bool {
        return rangeOfCharacter(from: .letters, options: .numeric, range: nil) != nil
    }
    
    ///  Check if string contains one or more numbers.
    ///
    ///        "abcd".hasNumbers -> false
    ///        "123abc".hasNumbers -> true
    ///
    var hasNumber:Bool {
        return rangeOfCharacter(from: .decimalDigits, options: .literal, range: nil) != nil
    }
    
    ///  an array of all words in a string
    ///
    ///        "Swift is amazing".words() -> ["Swift", "is", "amazing"]
    ///
    func words() -> [String] {
        let chararacterSet = CharacterSet.whitespacesAndNewlines.union(.punctuationCharacters)
        let comps = components(separatedBy: chararacterSet)
        return comps.filter {
            !$0.isEmpty
        }
    }
    
    #if os(iOS) || os(macOS)
    ///  Copy string to global pasteboard.
    ///
    ///        "SomeText".copyToPasteboard() // copies "SomeText" to pasteboard
    ///
    func copyToPasteboard() {
        #if os(iOS)
        UIPasteboard.general.string = self
        #elseif os(macOS)
        NSPasteboard.general.clearContents()
        NSPasteboard.general.setString(self, forType: .string)
        #endif
    }
    #endif
}

extension Collection {
    
    //任意类型转json字符串
    public func mm_objectToJson() -> String? {
        if let data = try? JSONSerialization.data(withJSONObject: self, options: .prettyPrinted){
            return String(data: data, encoding: .utf8)
        }
        return nil
    }
}


public extension String {
    var nsString:NSString {
        return NSString(string: self)
    }
    
    ///  NSString lastPathComponent.
    var lastPathComponent: String {
        return (self as NSString).lastPathComponent
    }
    
    ///  NSString pathExtension.
    var pathExtension: String {
        return (self as NSString).pathExtension
    }
    
    ///  NSString deletingLastPathComponent.
    var deletingLastPathComponent: String {
        return (self as NSString).deletingLastPathComponent
    }
    
    ///  NSString deletingPathExtension.
    var deletingPathExtension: String {
        return (self as NSString).deletingPathExtension
    }
    
    /// NSString pathComponents.
    var pathComponents: [String] {
        return (self as NSString).pathComponents
    }
    
    ///  NSString appendingPathComponent(str: String)
    ///
    /// - Parameter str: the path component to append to the receiver.
    /// - Returns: a new string made by appending aString to the receiver, preceded if necessary by a path separator.
    func appendingPathComponent(_ str: String) -> String {
        return (self as NSString).appendingPathComponent(str)
    }
    
    ///  NSString appendingPathExtension(str: String)
    ///
    /// - Parameter str: The extension to append to the receiver.
    /// - Returns: a new string made by appending to the receiver an extension separator followed by ext (if applicable).
    func appendingPathExtension(_ str: String) -> String? {
        return (self as NSString).appendingPathExtension(str)
    }
    
}
