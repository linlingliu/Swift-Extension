//
//  UINavigationController+MM.swift
//  SwiftExtension
//
//  Created by sameway on 2019/6/17.
//  Copyright © 2019 sameway. All rights reserved.
//

import UIKit

public extension UINavigationController {
    
    //Pop ViewController with completion handler.
    func popViewController(animated:Bool = true,_ completion:(()->Void)? = nil) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        popViewController(animated: animated)
        CATransaction.commit()
    }
    
    //Push ViewController with completion handler.
    func pushViewController(_ viewController:UIViewController,animated:Bool = true,_ completion:(()->Void)?) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        pushViewController(viewController, animated: animated)
        CATransaction.commit()
    }
}
