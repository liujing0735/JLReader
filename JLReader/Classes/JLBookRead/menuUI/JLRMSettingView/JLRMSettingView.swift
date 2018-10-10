//
//  JLRMSettingView.swift
//  JLReader
//
//  Created by JasonLiu on 2018/5/11.
//  Copyright © 2018年 JasonLiu. All rights reserved.
//

import UIKit

class JLRMSettingView: JLRMBaseView {

    /// 颜色
    private(set) var colorView:JLRMColorView!
    
    /// 翻页效果
    private(set) var effectView:JLRMFuncView!
    
    /// 字体
    private(set) var fontView:JLRMFuncView!
    
    /// 字体大小
    private(set) var fontSizeView:JLRMFuncView!
     
    /// 添加控件
    override func addSubviews() {
        
        super.addSubviews()
        
        // 颜色
        colorView = JLRMColorView(frame:CGRect(x: 0, y: 0, width: screenWidth, height: 74),readMenu:readMenu,colors:JLReadBGColors,selectIndex:JLReadConfigure.shared().colorIndex)
        addSubview(colorView)
    
        // funcViewH
        let funcViewH:CGFloat = (height - (isIPhoneXAll ? JLSpace_1 : 0) - colorView.height) / 3
        
        // 翻页效果 labels 排放顺序参照 JLRMNovelEffectType
        effectView = JLRMFuncView(frame:CGRect(x: 0, y: colorView.frame.maxY, width: screenWidth, height: funcViewH), readMenu:readMenu, funcType: .effect, title:"翻书动画", labels:["无效果","平移","仿真","上下"], selectIndex:JLReadConfigure.shared().effectType)
        addSubview(effectView)
        
        // 字体 labels 排放顺序参照 JLRMNovelFontType
        fontView = JLRMFuncView(frame:CGRect(x: 0, y: effectView.frame.maxY, width: screenWidth, height: funcViewH), readMenu:readMenu, funcType: .font, title:"字体", labels:["系统","黑体","楷体","宋体"], selectIndex:JLReadConfigure.shared().fontType)
        addSubview(fontView)
        
        // 字体大小
        fontSizeView = JLRMFuncView(frame:CGRect(x: 0, y: fontView.frame.maxY, width: screenWidth, height: funcViewH), readMenu:readMenu, funcType: .fontSize, title:"字号")
        addSubview(fontSizeView)
    }

}
