//
//  Global+MM.swift
//  SwiftExtension
//
//  Created by sameway on 2019/6/12.
//  Copyright © 2019 sameway. All rights reserved.
//

import UIKit
import Kingfisher

let screenWidth = UIScreen.main.bounds.width
let screenHeight = UIScreen.main.bounds.height
public let ScreenMaxLength:CGFloat = max(screenWidth,screenHeight)
public let IsIPad = (UI_USER_INTERFACE_IDIOM() == .pad)
public let IsPhone = (UI_USER_INTERFACE_IDIOM() == .phone)
public let IsIPhoneX = (IsPhone && (ScreenMaxLength == 812.0 || ScreenMaxLength == 896.0))


var topVC : UIViewController? {
    var resultVC :UIViewController?
    resultVC = _topVC(UIApplication.shared.keyWindow?.rootViewController)
    while resultVC?.presentedViewController != nil {
        resultVC = _topVC(resultVC?.presentedViewController)
    }
    return resultVC
}

//log
func MLog<T>(_ message:T,file:String = #file,function:String = #function,lineNumber:Int = #line) {
    #if DEBUG
    let fileName = (file as NSString).lastPathComponent
    print("[\(fileName);function:\(function);line:\(lineNumber)]-\(message)")
    #endif
}

//
var isIphoneX: Bool {
    return UI_USER_INTERFACE_IDIOM() == .phone
        && (max(UIScreen.main.bounds.height, UIScreen.main.bounds.width) == 812
            || max(UIScreen.main.bounds.height, UIScreen.main.bounds.width) == 896)
}

//MARK: Kingfisher

extension KingfisherWrapper where Base:UIImageView {
    func mm_setImage(urlString:String?,placeholder:UIImage? = UIImage(named: "normal")) {
        guard let url = URL(string: urlString ?? "") else { return }
        let resource = ImageResource(downloadURL: url)
        base.kf.setImage(with: resource, placeholder: placeholder, options: [.transition(.fade(0.5))])
    }
}

extension KingfisherWrapper where Base:UIButton {
    func mm_setImage(urlString:String?,placeholder:UIImage? = UIImage(named: "normal")) {
        guard let url = URL(string: urlString ?? "") else { return }
        let resource = ImageResource(downloadURL: url)
        base.kf.setImage(with: resource, for: .normal)
    }
}

//MARK:私有方法
private func _topVC(_ vc:UIViewController?) -> UIViewController? {
    if vc is UINavigationController {
        return _topVC((vc as? UINavigationController)?.topViewController)
    }else if vc is UITabBarController {
        return _topVC((vc as? UITabBarController)?.selectedViewController)
    }else {
        return vc
    }
}
