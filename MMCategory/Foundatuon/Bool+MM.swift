//
//  Bool+MM.swift
//  SwiftExtension
//
//  Created by sameway on 2019/6/13.
//  Copyright © 2019 sameway. All rights reserved.
//

import Foundation

public extension Bool {
    
    var int:Int {
        return self ? 1 : 0
    }
    
    var string:String {
        return self ? "true" : "false"
    }
    
}
