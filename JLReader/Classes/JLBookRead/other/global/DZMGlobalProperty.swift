//
//  JLGlobalProperty.swift
//  JLReader
//
//  Created by JasonLiu on 2018/5/11.
//  Copyright © 2018年 JasonLiu. All rights reserved.
//

import UIKit

// MARK: -- 屏幕属性

/// 导航栏高度
let NavgationBarHeight:CGFloat = isIPhoneXAll ? 88 : 64

/// TabBar高度
let TabBarHeight:CGFloat = 49

/// iPhone X 顶部刘海高度
let TopLiuHeight:CGFloat = 30

/// StatusBar高度
let StatusBarHeight:CGFloat = isIPhoneXAll ? 44 : 20


// MARK: -- 颜色支持

/// 灰色
let JLColor_1:UIColor = RGB(51, g: 51, b: 51)

/// 粉红色
let JLColor_2:UIColor = RGB(253, g: 85, b: 103)

/// 阅读上下状态栏颜色
let JLColor_3:UIColor = RGB(127, g: 136, b: 138)

/// 小说阅读上下状态栏字体颜色
let JLColor_4:UIColor = RGB(127, g: 136, b: 138)

/// 小说阅读颜色
let JLColor_5:UIColor = RGB(145, g: 145, b: 145)

/// LeftView文字颜色
let JLColor_6:UIColor = RGB(200, g: 200, b: 200)


/// 阅读背景颜色支持
let JLReadBGColor_1:UIColor = RGB(238, g: 224, b: 202)
let JLReadBGColor_2:UIColor = RGB(205, g: 239, b: 205)
let JLReadBGColor_3:UIColor = RGB(206, g: 233, b: 241)
let JLReadBGColor_4:UIColor = RGB(251, g: 237, b: 199)  // 牛皮黄
let JLReadBGColor_5:UIColor = RGB(51, g: 51, b: 51)

/// 菜单背景颜色
let JLMenuUIColor:UIColor = UIColor.black.withAlphaComponent(0.85)

// MARK: -- 字体支持
let JLFont_10:UIFont = UIFont.systemFont(ofSize: 10)
let JLFont_12:UIFont = UIFont.systemFont(ofSize: 12)
let JLFont_18:UIFont = UIFont.systemFont(ofSize: 18)


// MARK: -- 间距支持
let JLSpace_1:CGFloat = 15
let JLSpace_2:CGFloat = 25
let JLSpace_3:CGFloat = 1
let JLSpace_4:CGFloat = 10
let JLSpace_5:CGFloat = 20
let JLSpace_6:CGFloat = 5

// MARK: 拖拽触发光标范围
let JLCursorOffset:CGFloat = -20


// MARK: -- Key

/// 是夜间还是日间模式   true:夜间 false:日间
let JLKey_IsNighOrtDay:String = "isNightOrDay"

/// ReadView 手势开启状态
let JLKey_ReadView_Ges_isOpen:String = "isOpen"

// MARK: 通知名称

/// ReadView 手势通知
let JLNotificationName_ReadView_Ges = "ReadView_Ges"
