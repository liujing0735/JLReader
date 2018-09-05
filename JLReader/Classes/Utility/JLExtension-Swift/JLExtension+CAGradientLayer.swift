//
//  JLExtension+CAGradientLayer.swift
//  JLReader
//
//  Created by JasonLiu on 2018/9/4.
//  Copyright © 2018年 JasonLiu. All rights reserved.
//

import UIKit

extension CAGradientLayer {
    
    convenience init(frame: CGRect) {
        self.init()
        self.frame = frame
    }
    
    convenience init(colors: [Any], locations: [NSNumber]! = nil, startPoint: CGPoint = CGPoint(x: 0.5, y: 0), endPoint: CGPoint = CGPoint(x: 0.5, y: 1)) {
        self.init()
        self.colors = colors
        self.locations = locations
        self.startPoint = startPoint
        self.endPoint = endPoint
    }
}
