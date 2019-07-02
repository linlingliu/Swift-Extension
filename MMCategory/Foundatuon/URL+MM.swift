//
//  URL+MM.swift
//  SwiftExtension
//
//  Created by sameway on 2019/6/11.
//  Copyright © 2019 sameway. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

public extension URL {
    
    //Dictionary of the URL's query parameters
    var queryParameters: [String:String]? {
        guard let components = URLComponents(url: self, resolvingAgainstBaseURL: false),
         let queryItem = components.queryItems else { return nil }
        var items:[String:String] = [:]
        for queryItem in queryItem {
            items[queryItem.name] = queryItem.value
        }
        return items
    }
}

public extension URL {
    
    /// SwifterSwift: URL with appending query parameters.
    ///
    ///        let url = URL(string: "https://google.com")!
    ///        let param = ["q": "Swifter Swift"]
    ///        url.appendingQueryParameters(params) -> "https://google.com?q=Swifter%20Swift"
    func appendingQueryParameters(_ parameters:[String:String]) -> URL {
        var urlComponents = URLComponents(url: self, resolvingAgainstBaseURL: false)!
        var items = urlComponents.queryItems ?? []
        items += parameters.map({ (key,value) -> URLQueryItem in
            URLQueryItem(name: key, value: value)
        })
        urlComponents.queryItems = items
        return urlComponents.url!
    }
    
    ///        var url = URL(string: "https://google.com")!
    ///        let param = ["q": "Swifter Swift"]
    ///        url.appendQueryParameters(params)
    ///        print(url) // prints "https://google.com?q=Swifter%20Swift"
    mutating func appendQueryParameters(_ parameters:[String:String]) {
        self = appendingQueryParameters(parameters)
    }
    
    ///    var url = URL(string: "https://google.com?code=12345")!
    ///    queryValue(for: "code") -> "12345"
    func queryValue(for key:String) -> String? {
        return URLComponents(string: absoluteString)?.queryItems?.first(where: { (item) -> Bool in
            item.name == key
        })?.value
    }
}

public extension URL {
    /// Generate a thumbnail image from given url. Returns nil if no thumbnail could be created. This function may take some time to complete. It's recommended to dispatch the call if the thumbnail is not generated from a local resource.
    ///
    ///     var url = URL(string: "https://video.golem.de/files/1/1/20637/wrkw0718-sd.mp4")!
    ///     var thumbnail = url.thumbnail()
    ///     thumbnail = url.thumbnail(fromTime: 5)
    ///
    ///     DisptachQueue.main.async {
    ///         someImageView.image = url.thumbnail()
    ///     }
    func thumbnail(fromTime time:Float64 = 0) -> UIImage? {
        let imageGenerator = AVAssetImageGenerator(asset: AVAsset(url: self))
        let time = CMTimeMakeWithSeconds(time, preferredTimescale: 1)
        var actualTime = CMTimeMake(value: 0, timescale: 0)
        guard let cgImage = try? imageGenerator.copyCGImage(at: time, actualTime: &actualTime) else { return nil }
        return UIImage(cgImage: cgImage)
        
    }
}

public extension URL {
    /// Documents目录Url
    static var documentsDirectoryUrl: URL {
        return try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
    }
    
    /// Caches目录Url
    static var cachesDirectoryUrl: URL {
        return try! FileManager.default.url(for: .cachesDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
    }
    
    /// Library目录Url
    static var libraryDirectoryUrl: URL {
        return try! FileManager.default.url(for: .libraryDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
    }
    
    /// tmp目录Url
    static var tmpDirectorUrl: URL {
        return URL(fileURLWithPath: NSTemporaryDirectory(), isDirectory: true)
    }
    
}
