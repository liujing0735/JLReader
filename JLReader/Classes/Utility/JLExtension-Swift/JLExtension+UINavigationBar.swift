//
//  JLExtension+UINavigationBar.swift
//  JLReader
//
//  Created by JasonLiu on 2018/9/4.
//  Copyright © 2018年 JasonLiu. All rights reserved.
//

import UIKit

extension UINavigationBar {
    
    func gradient(colors: [Any]) {
        var size = self.bounds.size
        if isIPhoneX {
            size.height += 44
        }else {
            size.height += 20
        }
        setBackgroundImage(JLImage(size: size, colors: colors), for: .default)
    }
}
