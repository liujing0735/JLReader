//
//  JLRMStatusView.swift
//  JLReader
//
//  Created by JasonLiu on 2018/5/11.
//  Copyright © 2018年 JasonLiu. All rights reserved.
//

import UIKit

class JLRMStatusView: JLRMBaseView {
    
    /// 电池
    private(set) var batteryView:JLBatteryView!
    
    /// 时间
    private(set) var timeLabel:UILabel!
    
    /// 标题
    private(set) var titleLabel:UILabel!
    
    /// 计时器
    private(set) var timer:Timer?
    
    override func addSubviews() {
        
        super.addSubviews()
        
        // 背景颜色
        backgroundColor = JLColor_1.withAlphaComponent(0.4)
        
        // 电池
        batteryView = JLBatteryView()
        batteryView.tintColor = JLColor_3
        addSubview(batteryView)
        
        // 时间
        timeLabel = UILabel()
        timeLabel.textAlignment = .center
        timeLabel.font = JLFont_12
        timeLabel.textColor = JLColor_3
        addSubview(timeLabel)
        
        // 标题
        titleLabel = UILabel()
        titleLabel.font = JLFont_12
        titleLabel.textColor = JLColor_3
        addSubview(titleLabel)
        
        // 初始化调用
        didChangeTime()
        
        // 添加定时器
        addTimer()
    }
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        // 适配间距
        let space = isIPhoneXAll ? JLSpace_1 : 0
        
        // 电池
        batteryView.origin = CGPoint(x: width - JLBatterySize.width - space, y: (height - JLBatterySize.height)/2)
        
        // 时间
        let timeLabelW:CGFloat = JLSizeW(50)
        timeLabel.frame = CGRect(x: batteryView.frame.minX - timeLabelW, y: 0, width: timeLabelW, height: height)
        
        // 标题
        titleLabel.frame = CGRect(x: space, y: 0, width: timeLabel.frame.minX - space, height: height)
    }

    // MARK: -- 时间相关
    
    /// 添加定时器
    func addTimer() {
        
        if timer == nil {
            
            timer = Timer.scheduledTimer(timeInterval: 15, target: self, selector: #selector(didChangeTime), userInfo: nil, repeats: true)
            
            RunLoop.current.add(timer!, forMode: RunLoop.Mode.common)
        }
    }
    
    /// 删除定时器
    func removeTimer() {
        
        if timer != nil {
            
            timer!.invalidate()
            
            timer = nil
        }
    }
    
    /// 时间变化
    @objc func didChangeTime() {
        
        timeLabel.text = GetCurrentTimerString(dateFormat: "HH:mm")
        
        batteryView.batteryLevel = UIDevice.current.batteryLevel
    }
    
    /// 销毁
    deinit {
        
        removeTimer()
    }
}
