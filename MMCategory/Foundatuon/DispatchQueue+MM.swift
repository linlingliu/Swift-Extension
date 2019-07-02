//
//  DispatchQueue+MM.swift
//  SwiftExtension
//
//  Created by sameway on 2019/6/6.
//  Copyright © 2019 sameway. All rights reserved.
//

import Foundation

extension DispatchQueue {
    
   public class func synchronized(_ lock:AnyObject,closure:()->()) {
        objc_sync_enter(lock)
        closure()
        objc_sync_exit(lock)
    }
    
    public class func asyncAfterOnMain(deayTime:Double, callBack:(()-> Void)?) {
        DispatchQueue.main.asyncAfter(deadline: .now() + deayTime) {
            callBack?()
        }
    }
    
    private static var _identifiers:[String] = []
    public class func mm_once(_ identifier:String, callback:@escaping ()->Void){
        objc_sync_enter(self)
        defer {objc_sync_exit(self)}
        if _identifiers.contains(identifier) {
            return
        }
        _identifiers.append(identifier)
        DispatchQueue.main.async {
            callback()
        }
    }
    
    func mm_safeAsync(_ block:@escaping ()->()) {
        if self == DispatchQueue.main && Thread.isMainThread {
            block()
        }else {
            async {
                block()
            }
        }
    }
}
