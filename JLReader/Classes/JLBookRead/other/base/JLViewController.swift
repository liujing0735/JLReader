//
//  JLViewController.swift
//  JLReader
//
//  Created by JasonLiu on 2018/5/11.
//  Copyright © 2018年 JasonLiu. All rights reserved.
//

import UIKit

class JLViewController: UIViewController {

    /// 状态栏是否显示白色
    var isStatusBarLightContent:Bool = false {
        
        didSet{
            if isStatusBarLightContent != oldValue {
                //setStatusBarStyle()
                setNeedsStatusBarAppearanceUpdate()
            }
        }
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // backgroundColor
        view.backgroundColor = UIColor.white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
      
        // 设置状态栏颜色
        //setStatusBarStyle()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        if isStatusBarLightContent {
            return .lightContent
        }
        return .default
    }
    
    /// 设置状态栏颜色
//    private func setStatusBarStyle() {
//        if isStatusBarLightContent {
//            UIApplication.shared.setStatusBarStyle(.lightContent, animated: true)
//        }else{
//            UIApplication.shared.setStatusBarStyle(.default, animated: true)
//        }
//    }

    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
    }
}
