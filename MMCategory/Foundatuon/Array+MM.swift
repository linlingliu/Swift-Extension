//
//  Array+MM.swift
//  SwiftExtension
//
//  Created by sameway on 2019/6/6.
//  Copyright © 2019 sameway. All rights reserved.
//

import Foundation

extension Array {
    
    public mutating func safe_replaceElememt(at index:Int,with element:Element) {
        if index > count - 1 || index < 0 {
            return
        }
        replaceSubrange(index ..< index + 1, with: [element])
    }
    subscript(safe index:Int) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
    
    //在开始插入一个元素
    public mutating func mm_prepend(_ newElement:Element){
        if self.count < 0 {
            self = []
        }
        insert(newElement, at: 0)
    }
    
    //根据下标交换2个元素的位置
    //[1, 2, 3, 4, 5].mm_swap(from: 3, to: 0) -> [4, 2, 3, 1, 5]
    public mutating func mm_swap(from index:Int,to otherIndex:Int){
        guard index != otherIndex else {return}
        guard startIndex..<endIndex ~= index else {
            return
        }
        guard startIndex..<endIndex ~= otherIndex else {return}
        swapAt(index, otherIndex)
    }
    
}

public extension Array where Element: Equatable {
    
    //在数组只能够去除给定的元素
    //[1, 2, 2, 3, 4, 5].mm_removeAll(2) -> [1, 3, 4, 5]
    @discardableResult
    mutating func mm_removeAll(_ item:Element) -> [Element] {
        removeAll { (element) -> Bool in
            element == item
        }
        return self
    }
    
    //在数组只能够去除给定数组中的元素
    //[1, 2, 2, 3, 4, 5].mm_removeAll([2,5]) -> [1, 3, 4]
    @discardableResult
    mutating func mm_removeAll(_ item:[Element]) -> [Element] {
        guard !item.isEmpty else {
            return self
        }
        removeAll { (elememt) -> Bool in
            item.contains(elememt)
        }
        return self
    }
    
    //去掉所有重复的元素
    @discardableResult
    mutating func mm_removeDuplicates() -> [Element] {
        self = reduce(into: [Element](), { (itme1, itme2) in
            if !itme1.contains(itme2){
                itme1.append(itme2)
            }
        })
        return self
    }
}
