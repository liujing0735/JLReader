//
//  JLBaseViewController.swift
//  JLAlarmClock
//
//  Created by JasonLiu on 2018/2/3.
//  Copyright © 2018年 JasonLiu. All rights reserved.
//

import UIKit

@objc protocol JLBaseDelegate {
    @objc optional func leftItemClick(sender: Any)
    @objc optional func rightItemClick(sender: Any)
    @objc optional func hideKeyboard()
}

class JLBaseViewController: UIViewController,JLBaseDelegate {
    
    var itemTitleColor: UIColor = UIColor.black
    
    var barTintColor: UIColor = UIColor.black
    var barTitleColor: UIColor = UIColor.black
    var barBackgroundColor: UIColor = rgb(r: 249, g: 249, b: 249)
    var barAlpha: CGFloat {
        set {
            _barAlpha = newValue
            if baseNavigationBar != nil {
                baseNavigationBar.gradientAlpha = newValue
            }
            if _leftButton != nil {
                _leftButton.setTitleColor(itemTitleColor.withAlphaComponent(newValue), for: .normal)
            }
            if _rightButton != nil {
                _rightButton.setTitleColor(itemTitleColor.withAlphaComponent(newValue), for: .normal)
            }
        }
        get {
            return _barAlpha
        }
    }
    private var _barAlpha: CGFloat = 1.0
    
    var baseNavigationBar: JLNavigationBar!
    var baseNavigationItem: UINavigationItem!
    private var leftButton: UIButton {
        get {
            if _leftButton == nil {
                _leftButton = leftItemButton()
            }
            return _leftButton
        }
    }
    private var rightButton: UIButton {
        get {
            if _rightButton == nil {
                _rightButton = rightItemButton()
            }
            return _rightButton
        }
    }
    private var _leftButton: UIButton!
    private var _rightButton: UIButton!

    override var title: String? {
        set {
            _title = newValue
            self.baseNavigationItem.title = newValue
        }
        get {
            return _title
        }
    }
    var _title: String!
    
    private func updateViewFrame() {
        if #available(iOS 11.0, *) {
            if isIPhoneXAll {
                self.baseNavigationBar.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 44 + 44)
            }else {
                self.baseNavigationBar.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 44 + 20)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white
        self.baseNavigationBar = JLNavigationBar()
        self.baseNavigationBar.tintColor = barTintColor
        self.baseNavigationBar.barTintColor = barBackgroundColor
        self.baseNavigationBar.titleColor = barTitleColor
        self.baseNavigationBar.titleFont = UIFont.systemFont(ofSize: 21)
        self.baseNavigationItem = UINavigationItem()
        self.baseNavigationBar.pushItem(self.baseNavigationItem, animated: true)
        self.view.addSubview(self.baseNavigationBar)
        
        updateViewFrame()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /// 返回父视图控制器
    func backParentViewController() {
        let controllers: [UIViewController]! = self.navigationController?.children
        if controllers.count > 0 {
            self.navigationController?.popViewController(animated: true)
        }else {
            self.dismiss(animated: true, completion: {
                
            })
        }
    }
    
    /// 返回根视图控制器
    func backRootViewController() {
        let controllers: [UIViewController]! = self.navigationController?.children
        if controllers.count > 0 {
            self.navigationController?.popToRootViewController(animated: true)
        }else {
            self.dismiss(animated: true, completion: {
                
            })
        }
    }

    func leftItemClick(sender: Any) {
        backParentViewController()
    }
    
    func rightItemClick(sender: Any) {
        //
    }
    
    private func leftItemButton() -> UIButton {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        button.setTitleColor(itemTitleColor, for: .normal)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.addTarget(self, action: #selector(leftItemClick(sender:)), for: .touchUpInside)
        return button
    }
    
    private func rightItemButton() -> UIButton {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        button.setTitleColor(itemTitleColor, for: .normal)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.addTarget(self, action: #selector(rightItemClick(sender:)), for: .touchUpInside)
        return button
    }
    
    func addLeftItem(title: String) {
        leftButton.setTitle(title, for: .normal)
        if leftButton.currentImage != nil {
            leftButton.setImage(nil, for: .normal)
        }
        if self.baseNavigationItem.leftBarButtonItem == nil {
            self.baseNavigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftButton)
        }
    }
    
    func addRightItem(title: String) {
        rightButton.setTitle(title, for: .normal)
        if rightButton.currentImage != nil {
            rightButton.setImage(nil, for: .normal)
        }
        if self.baseNavigationItem.rightBarButtonItem == nil {
            self.baseNavigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightButton)
        }
    }
    
    func addLeftItem(img: UIImage) {
        leftButton.setImage(img, for: .normal)
        if leftButton.currentTitle != nil {
            leftButton.setTitle(nil, for: .normal)
        }
        if self.baseNavigationItem.leftBarButtonItem == nil {
            self.baseNavigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftButton)
        }
    }
    
    func addRightItem(img: UIImage) {
        rightButton.setImage(img, for: .normal)
        if rightButton.currentTitle != nil {
            rightButton.setTitle(nil, for: .normal)
        }
        if self.baseNavigationItem.rightBarButtonItem == nil {
            self.baseNavigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightButton)
        }
    }
    
    func removeLeftItem() {
        self.baseNavigationItem.leftBarButtonItem = nil
    }
    
    func removeRightItem() {
        self.baseNavigationItem.rightBarButtonItem = nil
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
