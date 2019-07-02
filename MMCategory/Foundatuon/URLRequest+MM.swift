//
//  URLRequest+MM.swift
//  SwiftExtension
//
//  Created by sameway on 2019/6/17.
//  Copyright © 2019 sameway. All rights reserved.
//

import Foundation

public extension URLRequest {
    
    init?(urlString:String) {
        guard let url = URL(string: urlString) else { return nil }
        self.init(url:url)
    }
}
