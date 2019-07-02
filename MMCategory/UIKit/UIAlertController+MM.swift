//
//  UIAlertController+MM.swift
//  SwiftExtension
//
//  Created by sameway on 2019/6/11.
//  Copyright © 2019 sameway. All rights reserved.
//

import UIKit

#if canImport(AudioToolbox)
import AudioToolbox
#endif

extension UIAlertController {
    
    //添加按钮
    @discardableResult
    func addAction(title:String,style:UIAlertAction.Style = .default,isEnabled:Bool = true,handler:((UIAlertAction)->Void)? = nil) -> UIAlertAction{
        let action = UIAlertAction(title: title, style: style, handler: handler)
        action.isEnabled = isEnabled
        addAction(action)
        return action
    }
    
    //显示
    func show(animated:Bool = true,vibrate:Bool = false,completion:(()->Void)? = nil){
        UIApplication.shared.keyWindow?.rootViewController?.present(self, animated: animated, completion: completion)
        if vibrate {
            #if canImport(AudioToolbox)
            AudioServicesPlayAlertSound(kSystemSoundID_Vibrate)
            #endif
        }
    }
}

extension UIAlertController {
    convenience init(title:String = "提示",message:String? = nil,style:UIAlertController.Style = .alert,defaultButtonTitle:String = "确定",tintColor:UIColor? = nil) {
        self.init(title: title, message: message, preferredStyle: style)
        let defaultAction = UIAlertAction(title: defaultButtonTitle, style: .default, handler: nil)
        addAction(defaultAction)
        if let color = tintColor {
            view.tintColor = color
        }
    }
}
