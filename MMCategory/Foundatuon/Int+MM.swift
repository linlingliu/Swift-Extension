//
//  Int+MM.swift
//  SwiftExtension
//
//  Created by sameway on 2019/6/14.
//  Copyright © 2019 sameway. All rights reserved.
//

import CoreGraphics
import Darwin

public extension Int {
    
    var double:Double {
        return Double(self)
    }
    
    var float :Float {
        return Float(self)
    }
    
    var cgFloat :CGFloat {
        return CGFloat(self)
    }
    
    //CountableRange 0..<Int.
    var countableRange :CountableRange<Int> {
        return 0..<self
    }
    
    //Radian value of degree input.
    var degreeToRadians :Double {
        return Double.pi * Double(self) / 180.0
    }
    
    //Degree value of radian input
    var radiansToDegree:Double {
        return Double(self) * 180 / Double.pi
    }
    
    //String formatted for values over ±1000 (example: 1k, -2k, 100k, 1kk, -5kk..)
    var kFormatted:String {
        var sign :String {
            return self >= 0 ? "" : "-"
        }
        
        let abs = Swift.abs(self)
        if abs == 0 {
            return "0K"
        }else if abs >= 0 && abs < 1000000 {
            return String(format: "\(sign)%ik", abs/1000)
        }
        return String(format: "\(sign)%ikk", abs/100000)
    }
    
    
    
}
