//
//  NSObject+MM.swift
//  SwiftExtension
//
//  Created by sameway on 2019/6/6.
//  Copyright © 2019 sameway. All rights reserved.
//

import Foundation

extension NSObject {
    
    public func mm_setAssociatedObject(key:String, value:Any?) {
        guard let keyhashValue = UnsafeRawPointer(bitPattern: key.hashValue) else {
            return
        }
        objc_setAssociatedObject(self, keyhashValue, value, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    
    public func mm_getAssociatedObject(key:String) -> Any? {
        guard let keyhashValue = UnsafeRawPointer(bitPattern: key.hashValue) else { return nil}
       return objc_getAssociatedObject(self, keyhashValue)
    }
    
}

