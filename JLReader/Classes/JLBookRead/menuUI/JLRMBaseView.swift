//
//  JLRMBaseView.swift
//  JLReader
//
//  Created by JasonLiu on 2018/5/11.
//  Copyright © 2018年 JasonLiu. All rights reserved.
//

import UIKit

class JLRMBaseView: UIControl {

    /// 菜单
    weak var readMenu:JLReadMenu!
    
    /// 初始化方法
    convenience init(readMenu:JLReadMenu) {
        
        self.init(frame:CGRect.zero,readMenu:readMenu)
    }
    
    /// 初始化方法
    init(frame:CGRect,readMenu:JLReadMenu) {
        
        self.readMenu = readMenu
        
        super.init(frame: frame)
        
        addSubviews()
    }
    
    /// 初始化方法
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        addSubviews()
    }
    
    /// 添加子控件
    func addSubviews() {
        
        backgroundColor = JLMenuUIColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
