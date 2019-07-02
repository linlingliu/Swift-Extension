//
//  UIStoryboard+MM.swift
//  SwiftExtension
//
//  Created by sameway on 2019/6/17.
//  Copyright © 2019 sameway. All rights reserved.
//

import UIKit

public extension UIStoryboard {
    
    //Get main storyboard for application
    static var main:UIStoryboard? {
        let bundle = Bundle.main
        guard let name = bundle.object(forInfoDictionaryKey: "UIMainStoryboardFile") as? String else {return nil}
        return UIStoryboard(name: name, bundle: bundle)
    }
    
    //Instantiate a UIViewController using its class name
    func instantiateViewController<T:UIViewController>(withClass name:T.Type) -> T? {
        return instantiateViewController(withIdentifier: String(describing: name)) as? T
    }
}
