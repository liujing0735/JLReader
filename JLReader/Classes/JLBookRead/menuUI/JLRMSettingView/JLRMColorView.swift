//
//  JLRMColorView.swift
//  JLReader
//
//  Created by JasonLiu on 2018/5/11.
//  Copyright © 2018年 JasonLiu. All rights reserved.
//
import UIKit

class JLRMColorView: JLRMBaseView {
    
    /// 颜色数组
    private(set) var colors:[UIColor] = []
    
    /// 选中索引
    private(set) var selectIndex:NSInteger = 0
    
    /// 初始化方法
    init(frame:CGRect,readMenu:JLReadMenu,colors:[UIColor],selectIndex:NSInteger) {
        
        self.colors = colors
        
        self.selectIndex = selectIndex
        
        super.init(frame: frame, readMenu: readMenu)
    }
    
//    // MARK: -- 无抖动效果
//    
//    /// 选中按钮
//    private var selectButton:UIButton?
//    
//    override func addSubviews() {
//        
//        // 创建颜色按钮
//        let count = colors.count
//        
//        // 设置的index大于颜色数组
//        if selectIndex >= count {selectIndex = 0}
//
//        let PublicButtonWH:CGFloat = 40
//        
//        let spaceW:CGFloat = (screenWidth - 2 * JLSpace_1 - CGFloat(count) * PublicButtonWH) / CGFloat(count - 1)
//        
//        for i in 0..<count {
//            
//            let color = colors[i]
//            
//            let publicButton = UIButton(frame:CGRect(x: JLSpace_1 + CGFloat(i) * (PublicButtonWH + spaceW), y: JLSpace_1, width: PublicButtonWH, height: PublicButtonWH))
//            
//            publicButton.tag = i
//            
//            publicButton.layer.cornerRadius = PublicButtonWH / 2
//            
//            publicButton.backgroundColor = color
//            
//            addSubview(publicButton)
//            
//            publicButton.addTarget(self, action: #selector(JLRMColorView.clickButton(button:)), for: .touchUpInside)
//            
//            if selectIndex == i {
//                
//                selectButton(button: publicButton)
//            }
//        }
//        
//    }
//    
//    /// 点击按钮
//    func clickButton(button:UIButton) {
//        
//        selectButton(button: button)
//        
//        readMenu.delegate?.readMenuClickSetuptColor?(readMenu: readMenu, index: button.tag, color: colors[button.tag])
//    }
//    
//    /// 选中按钮
//    private func selectButton(button:UIButton) {
//        
//        selectButton?.layer.borderColor = UIColor.clear.cgColor
//        selectButton?.layer.borderWidth = 0
//        
//        button.layer.borderColor = JLColor_2.cgColor
//        button.layer.borderWidth = 2.0
//        
//        selectButton = button
//    }
    
    
    // MARK: -- 有抖动效果
    
    /// 选中按钮
    private var selectButton:JLHaloButton?
    
    override func addSubviews() {
        
        // 创建颜色按钮
        let count = colors.count
        
        // 设置的index大于颜色数组
        if selectIndex >= count {selectIndex = 0}

        let PublicButtonWH:CGFloat = JLHaloButton.HaloButtonSize(CGSize(width: 39, height: 39)).width
        
        let spaceW:CGFloat = (screenWidth - 2 * JLSpace_1 - CGFloat(count) * PublicButtonWH) / CGFloat(count - 1)
        
        for i in 0..<count {
            
            let color = colors[i]
            
            let publicButton = JLHaloButton(CGRect(x: JLSpace_1 + CGFloat(i) * (PublicButtonWH + spaceW), y: JLSpace_1, width: PublicButtonWH, height: PublicButtonWH), haloColor:color)
            
            publicButton.tag = i
            
            publicButton.imageView.backgroundColor = color
            
            addSubview(publicButton)
            
            publicButton.addTarget(self, action: #selector(clickButton(button:)), for: .touchUpInside)
            
            if selectIndex == i {
                
                selectButton(button: publicButton)
            }
        }
        
    }
    
    /// 点击按钮
    @objc func clickButton(button:JLHaloButton) {
        
        selectButton(button: button)
        
        readMenu.delegate?.readMenuClickSetuptColor?(readMenu: readMenu, index: button.tag, color: colors[button.tag])
    }
    
    /// 选中按钮
    private func selectButton(button:JLHaloButton) {
        
        selectButton?.imageView.layer.borderColor = UIColor.clear.cgColor
        selectButton?.imageView.layer.borderWidth = 0
        
        button.imageView.layer.borderColor = JLColor_2.cgColor
        button.imageView.layer.borderWidth = 2.0
        
        selectButton = button
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
}
