//
//  UIImage+AnimatedGIF.swift
//  insuubunkai
//
//  Created by 山田拓也 on 2019/08/12.
//  Copyright © 2019 山田拓也. All rights reserved.
//

import Foundation
import UIKit
import ImageIO

extension UIImage {
    
    static func animatedGIF(data: Data) -> UIImage? {
        guard let source = CGImageSourceCreateWithData(data as CFData, nil) else {
            return nil
        }
        
        let count = CGImageSourceGetCount(source)
        
        var images: [UIImage] = []
        var duration = 0.0
        for i in 0..<count {
            guard let imageRef = CGImageSourceCreateImageAtIndex(source, i, nil) else {
                continue
            }
            
            guard let properties = CGImageSourceCopyPropertiesAtIndex(source, i, nil) as? [String: Any] else {
                continue
            }
            
            guard let gifDictionary = properties[kCGImagePropertyGIFDictionary as String] as? [String: Any] else {
                continue
            }
            
            guard let delayTime = gifDictionary[kCGImagePropertyGIFDelayTime as String] as? Double else {
                continue
            }
            
            duration += delayTime
            
            // pre-render
            let image = UIImage(cgImage: imageRef, scale: UIScreen.main.scale, orientation: .up)
            UIGraphicsBeginImageContextWithOptions(image.size, false, 0.0)
            image.draw(in: CGRect(x: 0.0, y: 0.0, width: image.size.width, height: image.size.height))
            let renderedImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            if let renderedImage = renderedImage {
                images.append(renderedImage)
            }
        }
        
        return UIImage.animatedImage(with: images, duration: duration)
    }
}
