//
//  JLCursorView.swift
//  JLReader
//
//  Created by JasonLiu on 2018/12/11.
//  Copyright © 2018年 JasonLiu. All rights reserved.
//

import UIKit

class JLCursorView: UIView {

    /// 光标圆圈显示位置: true -> 圆圈在上面 , false -> 圆圈在下面
    var isTorB:Bool = true {
        
        didSet{ setNeedsDisplay() }
    }
    
    /// 光标颜色
    var color:UIColor = JLColor_2 {
        
        didSet{ setNeedsDisplay() }
    }
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        backgroundColor = UIColor.clear
    }
    
    override func draw(_ rect: CGRect) {

        let ctx = UIGraphicsGetCurrentContext()

        color.set()

        let rectW:CGFloat = bounds.width / 2

        ctx?.addRect(CGRect(x: (bounds.width - rectW) / 2, y: (isTorB ? 1 : 0), width: rectW, height: bounds.height - 1))
        
        ctx?.fillPath()

        if isTorB {
            
            ctx?.addEllipse(in: CGRect(x: 0, y: 0, width: bounds.width, height: bounds.width))
            
        }else{
            
            ctx?.addEllipse(in: CGRect(x: 0, y: bounds.height - bounds.width, width: bounds.width, height: bounds.width))
        }
        
        color.set()


        ctx?.fillPath()
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
}
