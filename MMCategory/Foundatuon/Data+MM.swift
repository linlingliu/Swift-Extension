//
//  Data+MM.swift
//  SwiftExtension
//
//  Created by sameway on 2019/6/17.
//  Copyright © 2019 sameway. All rights reserved.
//

import Foundation

public extension Data {
    
    //Return data as an array of bytes.
    var bytes: [UInt8] {
        return [UInt8](self)
    }
    
    //String by encoding Data using the given encoding (if applicable).
    
    func string(encoding:String.Encoding) -> String? {
        return String(data: self, encoding: encoding)
    }
    
    //Returns a Foundation object from given JSON data.
    
    func jsonObject(options:JSONSerialization.ReadingOptions = []) throws -> Any {
        return try JSONSerialization.jsonObject(with: self, options: options)
    }
}
