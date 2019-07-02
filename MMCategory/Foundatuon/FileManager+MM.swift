//
//  FileManager+MM.swift
//  SwiftExtension
//
//  Created by sameway on 2019/6/17.
//  Copyright © 2019 sameway. All rights reserved.
//

import Foundation

public extension FileManager {
    
    //Read from a JSON file at a given path.
    func jsonFromFile(atPath path:String,readingOptions:JSONSerialization.ReadingOptions = .allowFragments) throws -> [String:Any]? {
        let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
        let json = try JSONSerialization.jsonObject(with: data, options: readingOptions)
        return json as? [String:Any]
    }
    
    //Read from a JSON file with a given filename.
    func jsonFromFile(withFileName fileName:String,at bundleClass:AnyClass? = nil,readOptions:JSONSerialization.ReadingOptions = .allowFragments) throws -> [String:Any]? {
        //https://stackoverflow.com/questions/24410881/reading-in-a-json-file-using-swift
        let name = fileName.components(separatedBy: ".")[0]
        let bundle = bundleClass != nil ? Bundle(for: bundleClass!) : Bundle.main
        if let path = bundle.path(forResource: name, ofType: "json") {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            let json = try JSONSerialization.jsonObject(with: data, options: readOptions)
            return json as? [String:Any]
        }
        return nil
    }
    
    func createTemporaryDictionary() throws -> URL {
        let temporaryDictionaryURL:URL
        if #available(iOS 10.0, *) {
            temporaryDictionaryURL = temporaryDirectory
        }else {
            temporaryDictionaryURL = URL(fileURLWithPath: NSTemporaryDirectory(), isDirectory: true)
        }
        return try url(for: .itemReplacementDirectory, in: .userDomainMask, appropriateFor: temporaryDictionaryURL, create: true)
    }
}
