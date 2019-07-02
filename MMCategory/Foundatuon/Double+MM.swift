//
//  Double+MM.swift
//  SwiftExtension
//
//  Created by sameway on 2019/6/14.
//  Copyright © 2019 sameway. All rights reserved.
//

import CoreGraphics
import Darwin

//MARK: - Properties

public extension Double {
    
    var int:Int {
        return Int(self)
    }
    
    var flaot:Float {
        return Float(self)
    }
    var cgFloat :CGFloat {
        return CGFloat(self)
    }
}

//MARK: - Operators
precedencegroup PowerPrecedence {higherThan : MultiplicationPrecedence}
infix operator ** : PowerPrecedence

//4.4 ** 0.5 = 2.0976176963
func **(lhs:Double,rhs:Double) -> Double {
    return pow(lhs, rhs)
}

prefix operator √

public prefix func √ (double:Double) -> Double {
    return sqrt(double)
}
