//
//  UIApplication+MM.swift
//  SwiftExtension
//
//  Created by sameway on 2019/6/11.
//  Copyright © 2019 sameway. All rights reserved.
//

import UIKit

public extension UIApplication {
    
    
    //对外提供的方法

    static func incrementNetworkActivity(count:Int = 1){
        UIApplication.shared.incrementNetworkActivity(count: count)
    }
    
    static func decrementNetworkActivity(count:Int = 1){
        UIApplication.shared.decrementNetworkActivity(count: count)
    }
    
    func incrementNetworkActivity(count:Int = 1){
        changeNetworkActivity(num: count)
    }
    
    func decrementNetworkActivity(count:Int = 1){
        changeNetworkActivity(num: -count)
    }
    
    private struct NetworkIndicatorInfo {
        var count:Int = 0
        var timer:Timer?
        init(count:Int) {
            self.count = count
        }
    }
    
    private var networkActivityInfo:NetworkIndicatorInfo? {
        get {
           return mm_getAssociatedObject(key: "knetworkActivityInfoKey") as? NetworkIndicatorInfo
        }
        set {
            mm_setAssociatedObject(key: "knetworkActivityInfoKey", value: newValue)
        }
    }
    
    
    private func changeNetworkActivity(num:Int) {
        let lock = DispatchSemaphore(value: 1)
        lock.wait()
        var count = num
        if let oldInfo = self.networkActivityInfo {
            count += oldInfo.count
            oldInfo.timer?.invalidate()
        }
        var newInfo = NetworkIndicatorInfo(count: count)
        let timer = Timer(timeInterval: 1.0 / 30, target: self, selector: #selector(delaySetActivity(timer:)), userInfo: newInfo.count > 0, repeats: false)
        RunLoop.main.add(timer, forMode: .common)
        newInfo.timer = timer
        self.networkActivityInfo = newInfo
        lock.signal()
    }
    
    @objc private func delaySetActivity(timer:Timer){
        guard let visiable = timer.userInfo as? Bool,  isNetworkActivityIndicatorVisible != visiable else { return  }
        isNetworkActivityIndicatorVisible = visiable
        timer.invalidate()
    }
}
