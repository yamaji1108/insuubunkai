//
//  UIImageView+AnimatedGIF.swift
//  insuubunkai
//
//  Created by 山田拓也 on 2019/08/12.
//  Copyright © 2019 山田拓也. All rights reserved.
//

import Foundation
import UIKit
import ImageIO

extension UIImageView {
    
    func animateGIF(data: Data,
                    animationRepeatCount: UInt = 1,
                    completion: (() -> Void)? = nil) {
        guard let animatedGIFImage = UIImage.animatedGIF(data: data) else {
            return
        }
        
        self.image = animatedGIFImage.images?.last
        self.animationImages = animatedGIFImage.images
        self.animationDuration = animatedGIFImage.duration
        self.animationRepeatCount = Int(animationRepeatCount)
        self.startAnimating()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + animatedGIFImage.duration * Double(animationRepeatCount)) {
            completion?()
        }
    }
}
