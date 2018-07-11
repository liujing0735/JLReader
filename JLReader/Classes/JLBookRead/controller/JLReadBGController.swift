//
//  JLReadBGController.swift
//  JLReader
//
//  Created by JasonLiu on 2018/12/20.
//  Copyright © 2018年 JasonLiu. All rights reserved.
//

import UIKit

class JLReadBGController: UIViewController {

    /// 目标视图(无值则跟阅读背景颜色保持一致)
    weak var targetView:UIView?
    
    /// imageView
    private(set) var imageView:UIImageView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // imageView
        imageView = UIImageView()
        imageView.backgroundColor = JLReadConfigure.shared().readColor()
        imageView.frame = view.bounds
        imageView.layer.transform = CATransform3DMakeRotation(CGFloat.pi, 0, 1, 0)
        view.addSubview(imageView)
        
        // 展示图片
        if targetView != nil { imageView.image = ScreenCapture(targetView) }
    }

    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
    }
}
