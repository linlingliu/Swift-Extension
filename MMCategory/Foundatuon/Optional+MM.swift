//
//  Optional+MM.swift
//  SwiftExtension
//
//  Created by sameway on 2019/6/14.
//  Copyright © 2019 sameway. All rights reserved.
//

import Foundation

public extension Optional {
    
    //         Get self of default value (if self is nil).
    ///        let foo: String? = nil
    ///        print(foo.unwrapped(defaultValue: "bar")) -> "bar"
    ///
    ///        let bar: String? = "bar"
    ///        print(bar.unwrapped(defaultValue: "foo")) -> "bar"
    
    func unwrapped(defaultValue:Wrapped) -> Wrapped {
        return self ?? defaultValue
    }
    
    ///         Gets the wrapped value of an optional. If the optional is `nil`, throw a         custom error.
    ///
    ///        let foo: String? = nil
    ///        try print(foo.unwrapped(or: MyError.notFound)) -> error: MyError.notFound
    ///
    ///        let bar: String? = "bar"
    ///        try print(bar.unwrapped(or: MyError.notFound)) -> "bar"
    
    func unwrapped(or error:Error) throws -> Wrapped {
        guard let wrapped = self else { throw error }
        return wrapped
    }
    
    ///         Runs a block to Wrapped if not nil
    ///
    ///        let foo: String? = nil
    ///        foo.run { unwrappedFoo in
    ///            // block will never run sice foo is nill
    ///            print(unwrappedFoo)
    ///        }
    ///
    ///        let bar: String? = "bar"
    ///        bar.run { unwrappedBar in
    ///            // block will run sice bar is not nill
    ///            print(unwrappedBar) -> "bar"
    ///        }
    
    func run(_ block:(Wrapped) -> Void) {
        _ = map(block)
    }
    
    ///       Assign an optional value to a variable only if the value is not nil.
    ///
    ///     let someParameter: String? = nil
    ///     let parameters = [String:Any]() //Some parameters to be attached to a GET request
    ///     parameters[someKey] ??= someParameter //It won't be added to the parameters dict
    static func ??= (lhs:inout Optional, rhs:Optional) {
        guard let rhs = rhs else { return  }
        lhs = rhs
    }
    
    ///      Assign an optional value to a variable only if the variable is nil.
    ///
    ///     var someText: String? = nil
    ///     let newText = "Foo"
    ///     let defaultText = "Bar"
    ///     someText ?= newText //someText is now "Foo" because it was nil before
    ///     someText ?= defaultText //someText doesn't change its value because it's not nil
    static func ?= (lhs:inout Optional,rhs: @autoclosure () -> Wrapped) {
        if lhs == nil {
            lhs = rhs()
        }
    }
}

public extension Optional where Wrapped:Collection {
    
   //Check if optional is nil or empty collection.
    var isNilOrEmpty:Bool {
        guard let collection = self else { return true }
        return collection.isEmpty
    }
    
    var nonEmpty:Wrapped? {
        guard let collection = self else { return nil }
        guard !collection.isEmpty else {
            return nil
        }
        return collection
    }
    
}

infix operator ??= : AssignmentPrecedence
infix operator ?= : AssignmentPrecedence
