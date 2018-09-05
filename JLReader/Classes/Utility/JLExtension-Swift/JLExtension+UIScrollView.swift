//
//  JLExtension+UIScrollView.swift
//  JLReader
//
//  Created by JasonLiu on 2018/9/5.
//  Copyright © 2018年 JasonLiu. All rights reserved.
//

import UIKit

extension UIScrollView {
    
    // MARK: -- 滚动中途停止
    func stopScroll(){
        
        var offset = contentOffset
        
        (contentOffset.y > 0) ? (offset.y -= 1) : (offset.y += 1);
        
        setContentOffset(offset, animated: false)
    }
}
