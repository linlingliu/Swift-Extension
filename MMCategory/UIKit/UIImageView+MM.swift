//
//  UIImageView+MM.swift
//  SwiftExtension
//
//  Created by sameway on 2019/6/17.
//  Copyright © 2019 sameway. All rights reserved.
//

import UIKit

public extension UIImageView {
    
    //Set image from a URL.
    func download(from url:URL,contentMode:UIView.ContentMode = .scaleAspectFit,placeholder:UIImage? = nil,completionHandler:((UIImage?) -> Void)? = nil) {
        image = placeholder
        self.contentMode = contentMode
        URLSession.shared.dataTask(with: url) { (data, response, _) in
            guard let httpResponse = response as? HTTPURLResponse,
            httpResponse.statusCode == 200,
            let mineType = response?.mimeType,
            mineType.hasPrefix("image"),
            let data = data,
            let image = UIImage(data: data)
            else {
                    completionHandler?(nil)
                    return
            }
            DispatchQueue.main.async {
                self.image = image
                completionHandler?(image)
            }
        }
    }
    
    //Make image view blurry
    func blur(withStyle style:UIBlurEffect.Style = .light) {
        let blurEffect = UIBlurEffect(style: style)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = bounds
        blurEffectView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        addSubview(blurEffectView)
        clipsToBounds = true
    }
    
    func blurred(withStyle style:UIBlurEffect.Style = .light) -> UIImageView {
        let imgView = self
        imgView.blur(withStyle: style)
        return imgView
    }
}
