//
//  JLExtension+UIImage.swift
//  JLReader
//
//  Created by JasonLiu on 2018/9/5.
//  Copyright © 2018年 JasonLiu. All rights reserved.
//

import UIKit

extension UIImage {
    
}

func JLGradientImage(size: CGSize, cgColors: [Any], locations: [NSNumber]! = nil, startPoint: CGPoint = CGPoint(x: 0.5, y: 0), endPoint: CGPoint = CGPoint(x: 0.5, y: 1)) -> UIImage? {
    let frame = CGRect(origin: CGPoint(x: 0, y: 0), size: size)
    let layer = CAGradientLayer(cgColors: cgColors, locations: locations, startPoint: startPoint, endPoint: endPoint)
    layer.frame = frame
    return JLGradientImage(layer: layer)
}

func JLGradientImage(layer: CALayer) -> UIImage {
    UIGraphicsBeginImageContext(layer.frame.size)
    layer.render(in: UIGraphicsGetCurrentContext()!)
    let outputImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return outputImage!
}
