//
//  Timer+MM.swift
//  SwiftExtension
//
//  Created by sameway on 2019/6/6.
//  Copyright © 2019 sameway. All rights reserved.
//

import Foundation

extension NSObject {
    
    fileprivate var mm_timers:[String:DispatchSourceTimer?]? {
        set {
            mm_setAssociatedObject(key: "mm_timers", value: newValue)
        }
        get {
            return mm_getAssociatedObject(key: "k_timers") as? [String: DispatchSourceTimer?]
        }
    }
    
    //MARK: 启动定时器
    /// 启动定时器
    ///
    /// - Parameters:
    ///   - timerIdentifier: 唯一的标记符, 如果同一个对象只有一个定时器 可以不传
    ///   - timeInterval: 时间间隔
    ///   - repeats: 是否重复 true一直运行 false运行一次
    ///   - isDealy: 是否延迟时间间隔运行
    ///   - block: 回调
    
    public func mm_startTimer(timerIdentifier:String? = nil,timeInterval:TimeInterval,repeats:Bool,isDealy:Bool = true, block:@escaping (DispatchSourceTimer?)->Void) {
        let timer = DispatchSource.makeTimerSource(flags: [], queue: DispatchQueue.main)
        timer.schedule(wallDeadline: .now(), repeating: timeInterval)
        var count:Int = 0
        timer.setEventHandler {
            [unowned self] in
            if !repeats && count == 1 {
                self.mm_stopTimer(timerIdentifier: timerIdentifier)
            }
            count += 1
            if let k_timers = self.mm_timers {
                let key = timerIdentifier ?? "timer"
                block(k_timers[key] as? DispatchSourceTimer)
            }else{
                block(nil)
            }
        }
        if isDealy {
            DispatchQueue.asyncAfterOnMain(deayTime: timeInterval) {
                timer.resume()
            }
        }else{
            timer.resume()
        }
        var timers = self.mm_timers ?? [:]
        timers[timerIdentifier ?? "timer"] = timer
        self.mm_timers = timers
    }
    
    //停止定时器
    
    public func mm_stopTimer(timerIdentifier:String? = nil) {
        let key = timerIdentifier ?? "timer"
        var timers = self.mm_timers ?? [:]
        if let timer = timers[key] {
            timer?.cancel()
            timers[key] = nil
        }
        timers.removeValue(forKey: key)
        self.mm_timers = timers
        if timers.isEmpty {
            self.mm_timers = nil
        }
    }
}
