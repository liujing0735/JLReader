//
//  JLExtensionSwift.swift
//  JLExtension-Swift
//
//  Created by JasonLiu on 2017/5/19.
//  Copyright © 2017年 JasonLiu. All rights reserved.
//

import UIKit

// 设备屏幕宽
let screenWidth: CGFloat = UIScreen.main.bounds.size.width

// 设备屏幕高
let screenHeight: CGFloat = UIScreen.main.bounds.size.height

// iPhone X
let isIPhoneX: Bool = (screenWidth == 375 && screenHeight == 812)

// 时间戳
var timeStampInt: Int  = Int(Date().timeIntervalSince1970)

// 时间戳
let timeStampString: String = timeStampInt.toString

func rgb(r: Float, g: Float, b: Float) -> UIColor {
    return rgba(r: r, g: g, b: b, a: 1.0)
}

func rgba(r: Float, g: Float, b: Float, a: Float) -> UIColor {
    if #available(iOS 10.0, *) {
        return UIColor(displayP3Red: CGFloat(r/255.0), green: CGFloat(g/255.0), blue: CGFloat(b/255.0), alpha: CGFloat(a))
    } else {
        // Fallback on earlier versions
        return UIColor.init(red: CGFloat(r/255.0), green: CGFloat(g/255.0), blue: CGFloat(b/255.0), alpha: CGFloat(a))
    }
}

func log(_ items: Any..., separator: String = " ", terminator: String = "\n", line: Int = #line, file: String = #file, functoin: String = #function) {
    print("\n在源文件\(String(file.components(separatedBy: "/").last!)) 第\(line)行 \(functoin)函数中: \(items)", separator, terminator)
}
