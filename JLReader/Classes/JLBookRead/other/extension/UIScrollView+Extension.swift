//
//  UIScrollView+Extension.swift
//  JLReader
//
//  Created by JasonLiu on 2018/5/22.
//  Copyright © 2018年 JasonLiu. All rights reserved.
//

import UIKit

extension UIScrollView {
    
    // MARK: -- 滚动中途停止
    
    /// 停止滚动 可用于中途停止 滚动中途停止等等
    func stopScroll(){
        
        var offset = contentOffset
        
        (contentOffset.y > 0) ? (offset.y -= 1) : (offset.y += 1);
        
        setContentOffset(offset, animated: false)
    }
}
