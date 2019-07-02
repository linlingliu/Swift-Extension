//
//  UIDevice+MM.swift
//  SwiftExtension
//
//  Created by sameway on 2019/6/11.
//  Copyright © 2019 sameway. All rights reserved.
//

import UIKit

extension UIDevice {
    static func mm_ststemVersion() -> String {
        return UIDevice.current.systemVersion
    }
    
    static func mm_isSimulator() -> Bool {
        #if targetEnvironment(simulator)
        return true
        #else
        return false
        #endif
    }
    
    //设备型号
    static func mm_machineModel() -> String? {
        if let key = "hw.machine".cString(using: String.Encoding.utf8) {
            var size: Int = 0
            sysctlbyname(key, nil, &size, nil, 0)
            //            var machine = [CChar](repeating: 0, count: Int(size))
            //            sysctlbyname(key, &machine, &size, nil, 0)
            //            return String(cString: machine)
            var machine = Data(count: size - 1)
            _ = machine.withUnsafeMutableBytes { (bytes) -> UnsafeMutablePointer<Int>? in
                sysctlbyname(key, bytes.baseAddress, &size, nil, 0)
                return nil
            }
            return String(data: machine, encoding: .utf8)
        }
        return nil
    }
    
    static func mm_machineModelName() -> String? {
        guard let model = mm_machineModel() else { return nil }
        let dict = [
            "Watch1,1" : "Apple Watch 38mm case",
            "Watch1,2" : "Apple Watch 38mm case",
            "Watch2,6" : "Apple Watch Series 1 38mm case",
            "Watch2,7" : "Apple Watch Series 1 42mm case",
            "Watch2,3" : "Apple Watch Series 2 38mm case",
            "Watch2,4" : "Apple Watch Series 2 42mm case",
            "Watch3,1" : "Apple Watch Series 3 38mm case (GPS+Cellular)",
            "Watch3,2" : "Apple Watch Series 3 42mm case (GPS+Cellular)",
            "Watch3,3" : "Apple Watch Series 3 38mm case (GPS)",
            "Watch3,4" : "Apple Watch Series 3 42mm case (GPS)",
            "Watch4,1" : "Apple Watch Series 4 40mm case (GPS)",
            "Watch4,2" : "Apple Watch Series 4 44mm case (GPS)",
            "Watch4,3" : "Apple Watch Series 4 40mm case (GPS+Cellular)",
            "Watch4,4" : "Apple Watch Series 4 44mm case (GPS+Cellular)",
            
            "iPod1,1" : "iPod touch 1",
            "iPod2,1" : "iPod touch 2",
            "iPod3,1" : "iPod touch 3",
            "iPod4,1" : "iPod touch 4",
            "iPod5,1" : "iPod touch 5",
            "iPod7,1" : "iPod touch 6",
            
            "iPhone1,1" : "iPhone 1G",
            "iPhone1,2" : "iPhone 3G",
            "iPhone2,1" : "iPhone 3GS",
            "iPhone3,1" : "iPhone 4 (GSM)",
            "iPhone3,2" : "iPhone 4",
            "iPhone3,3" : "iPhone 4 (CDMA)",
            "iPhone4,1" : "iPhone 4S",
            "iPhone5,1" : "iPhone 5",
            "iPhone5,2" : "iPhone 5",
            "iPhone5,3" : "iPhone 5c",
            "iPhone5,4" : "iPhone 5c",
            "iPhone6,1" : "iPhone 5S (GSM)",
            "iPhone6,2" : "iPhone 5S (Global)",
            "iPhone7,1" : "iPhone 6 Plus",
            "iPhone7,2" : "iPhone 6",
            "iPhone8,1" : "iPhone 6s",
            "iPhone8,2" : "iPhone 6s Plus",
            "iPhone8,3" : "iPhone SE (GSM+CDMA)",
            "iPhone8,4" : "iPhone SE (GSM)",
            "iPhone9,1" : "iPhone 7",
            "iPhone9,2" : "iPhone 7 Plus",
            "iPhone9,3" : "iPhone 7",
            "iPhone9,4" : "iPhone 7 Plus",
            "iPhone10,1": "iPhone 8",
            "iPhone10,2": "iPhone 8 Plus",
            "iPhone10,3": "iPhone X Global",
            "iPhone10,4": "iPhone 8",
            "iPhone10,5": "iPhone 8 Plus",
            "iPhone10,6": "iPhone X GSM",
            "iPhone11,2": "iPhone XS",
            "iPhone11,4": "iPhone XS Max",
            "iPhone11,6": "iPhone XS Max Global",
            "iPhone11,8": "iPhone XR",
            
            "iPad1,1" : "iPad",
            "iPad1,2" : "iPad 3G",
            "iPad2,1" : "2nd Gen iPad",
            "iPad2,2" : "2nd Gen iPad GSM",
            "iPad2,3" : "2nd Gen iPad CDMA",
            "iPad2,4" : "2nd Gen iPad New Revision",
            "iPad2,5" : "iPad mini",
            "iPad2,6" : "iPad mini GSM+LTE",
            "iPad2,7" : "iPad mini CDMA+LTE",
            "iPad3,1" : "3rd Gen iPad",
            "iPad3,2" : "3rd Gen iPad CDMA",
            "iPad3,3" : "3rd Gen iPad GSM",
            "iPad3,4" : "4th Gen iPad",
            "iPad3,5" : "4th Gen iPad GSM+LTE",
            "iPad3,6" : "4th Gen iPad CDMA+LTE",
            "iPad4,1" : "iPad Air (WiFi)",
            "iPad4,2" : "iPad Air (GSM+CDMA)",
            "iPad4,3" : "1st Gen iPad Air (China)",
            "iPad4,4" : "iPad mini Retina (WiFi)",
            "iPad4,5" : "iPad mini Retina (GSM+CDMA)",
            "iPad4,6" : "iPad mini Retina (China)",
            "iPad4,7" : "iPad mini 3 (WiFi)",
            "iPad4,8" : "iPad mini 3 (GSM+CDMA)",
            "iPad4,9" : "iPad mini 3 (China)",
            "iPad5,1" : "iPad mini 4 (WiFi)",
            "iPad5,2" : "iPad mini 4 (WiFi+Cellular)",
            "iPad5,3" : "iPad Air 2 (WiFi)",
            "iPad5,4" : "iPad Air 2 (Cellular)",
            "iPad6,3" : "iPad Pro (9.7 inch, WiFi)",
            "iPad6,4" : "iPad Pro (9.7 inch, WiFi+LTE)",
            "iPad6,7" : "iPad Pro (12.9 inch, WiFi)",
            "iPad6,8" : "iPad Pro (12.9 inch, WiFi+LTE)",
            "iPad6,11": "iPad (2017)",
            "iPad6,12": "iPad (2017)",
            "iPad7,1" : "iPad Pro 2nd Gen (WiFi)",
            "iPad7,2" : "iPad Pro 2nd Gen (WiFi+Cellular)",
            "iPad7,3" : "iPad Pro 10.5-inch",
            "iPad7,4" : "iPad Pro 10.5-inch",
            "iPad7,5" : "iPad 6th Gen (WiFi)",
            "iPad7,6" : "iPad 6th Gen (WiFi+Cellular)",
            "iPad8,1" : "iPad Pro 3rd Gen (11 inch, WiFi)",
            "iPad8,2" : "iPad Pro 3rd Gen (11 inch, 1TB, WiFi)",
            "iPad8,3" : "iPad Pro 3rd Gen (11 inch, WiFi+Cellular)",
            "iPad8,4" : "iPad Pro 3rd Gen (11 inch, 1TB, WiFi+Cellular)",
            "iPad8,5" : "iPad Pro 3rd Gen (12.9 inch, WiFi)",
            "iPad8,6" : "iPad Pro 3rd Gen (12.9 inch, 1TB, WiFi)",
            "iPad8,7" : "iPad Pro 3rd Gen (12.9 inch, WiFi+Cellular)",
            "iPad8,8" : "iPad Pro 3rd Gen (12.9 inch, 1TB, WiFi+Cellular)",
            "iPad11,1": "iPad mini 5 (WiFi)",
            "iPad11,2": "iPad mini 5 (WiFi+Cellular)",
            "iPad11,3": "iPad Air 2 (WiFi)",
            "iPad11,4": "iPad Air 2 (WiFi+Cellular)",
            
            "AppleTV2,1" : "Apple TV 2",
            "AppleTV3,1" : "Apple TV 3",
            "AppleTV3,2" : "Apple TV 3",
            "AppleTV5,3" : "Apple TV 4",
            "AppleTV6,2" : "Apple TV 5 4K",
            
            "i386" : "Simulator x86",
            "x86_64" : "Simulator x64",
        ]
        
        return dict[model]
    }
}

public extension UIDevice {
    
    //磁盘总空间
    static func diskSpace() -> Double? {
        guard let attrs = try? FileManager.default.attributesOfFileSystem(forPath: NSHomeDirectory()) else { return nil }
        return attrs[.systemSize] as? Double
    }
    
    //可用磁盘空间
    static func diskSpaceFree() -> Double? {
        guard let attrs = try? FileManager.default.attributesOfFileSystem(forPath: NSHomeDirectory()) else { return nil }
        return attrs[.systemFreeSize] as? Double
    }
    
    //已用空间
    static func diskSpaceUsed() -> Double? {
        guard let totla = diskSpace(),let free = diskSpaceFree() else { return nil }
        let used = totla - free
        if used > 0 {
            return used
        }
        return nil
    }
}
