//
//  UserDefaults+MM.swift
//  SwiftExtension
//
//  Created by sameway on 2019/6/17.
//  Copyright © 2019 sameway. All rights reserved.
//

import Foundation

public extension UserDefaults {
    
    subscript(key:String) -> Any? {
        get {
            return object(forKey: key)
        }
        set {
            set(newValue, forKey: key)
        }
    }
    
    //Retrieves a Codable object from UserDefaults.
    
    func object<T:Codable>(_ type:T.Type,with key:String,usingDecoder decoder:JSONDecoder = JSONDecoder()) -> T? {
        guard let data = value(forKey: key) as? Data else { return nil }
        return try? decoder.decode(type.self, from: data)
    }
    
    //Allows storing of Codable objects to UserDefaults.
    func set<T:Codable>(object:T,forKey key:String,usingEncoder encoder:JSONEncoder = JSONEncoder()) {
        let data = try? encoder.encode(object)
        set(data, forKey: key)
    }
}
