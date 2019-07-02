//
//  Bundle+MM.swift
//  SwiftExtension
//
//  Created by sameway on 2019/6/11.
//  Copyright © 2019 sameway. All rights reserved.
//

import UIKit

extension Bundle {
    
    static var appBundleName:String {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as! String
    }
    
    /// 应用ID
    static var appBundleID: String {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleIdentifier") as! String
    }
    
    /// 应用版本号
    static var appVersion: String {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
    }
    
    /// 应用构建版本号
    static var appBuildVersion: String {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as! String
    }
    
}
