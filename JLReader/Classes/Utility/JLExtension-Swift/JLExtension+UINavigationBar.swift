//
//  JLExtension+UINavigationBar.swift
//  JLReader
//
//  Created by JasonLiu on 2018/9/4.
//  Copyright © 2018年 JasonLiu. All rights reserved.
//

import UIKit

var navigationBarWidth: CGFloat {
    get {
        return screenWidth
    }
}

var navigationBarHeight: CGFloat {
    get {
        if #available(iOS 11.0, *) {
            if isIPhoneXAll {
                return 44 + 44
            }
        }
        return 20 + 44
    }
}

class JLNavigationBar: UINavigationBar {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if #available(iOS 11.0, *) {
            for subview in self.subviews {
                let className = String(describing: subview)
                if className.contains("UIBarBackground") {
                    var frame = subview.frame
                    frame.origin.y = 0
                    if isIPhoneXAll {
                        frame.size.height = 44 + 44
                    }else {
                        frame.size.height = 20 + 44
                    }
                    subview.frame = frame
                }else if className.contains("UINavigationBarContentView") {
                    var frame = subview.frame
                    if isIPhoneXAll {
                        frame.origin.y = 44
                    }else {
                        frame.origin.y = 20
                    }
                    frame.size.height = 44
                    subview.frame = frame
                }
            }
        }
    }
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
}

private var titleColorKey = "titleColorKey"
private var titleFontKey = "titleFontKey"
private var gradientColorsKey = "gradientColorsKey"
private var gradientViewKey = "gradientViewKey"
private var gradientAlphaKey = "gradientAlphaKey"
extension UINavigationBar {

    var titleColor: UIColor {
        set {
            objc_setAssociatedObject(self, &titleColorKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            setTitleText()
        }
        get {
            if let rs = objc_getAssociatedObject(self, &titleColorKey) as? UIColor {
                if rs == .clear {
                    return .clear
                }
                return rs.withAlphaComponent(gradientAlpha)
            }
            return UIColor.black//.withAlphaComponent(gradientAlpha)
        }
    }
    
    var titleFont: UIFont {
        set {
            objc_setAssociatedObject(self, &titleFontKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            setTitleText()
        }
        get {
            if let rs = objc_getAssociatedObject(self, &titleFontKey) as? UIFont {
                return rs
            }
            return UIFont.systemFont(ofSize: 21)
        }
    }
    
    var gradientView: UIView! {
        set {
            objc_setAssociatedObject(self, &gradientViewKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            if let rs = objc_getAssociatedObject(self, &gradientViewKey) as? UIView {
                return rs
            }
            return nil
        }
    }

    var gradientColors: [UIColor] {
        set {
            objc_setAssociatedObject(self, &gradientColorsKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            
            var cgColors: [CGColor] = []
            for color in newValue {
            cgColors.append(color.cgColor)
            }
            let gradientLayer = CAGradientLayer(frame: self.bounds)
            gradientLayer.colors = cgColors
            gradientView = UIView(frame: self.bounds)
            gradientView.alpha = gradientAlpha
            gradientView.layer.insertSublayer(gradientLayer, at: 0)
            // KVC
            self.setValue(gradientView, forKey: "backgroundView")
        }
        get {
            if let rs = objc_getAssociatedObject(self, &gradientColorsKey) as? [UIColor] {
                return rs
            }
            return [.blue, .purple]
        }
    }
    
    var gradientAlpha: CGFloat {
        set {
            objc_setAssociatedObject(self, &gradientAlphaKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_ASSIGN)
            
            if gradientView != nil {
                gradientView.alpha = newValue
            }
        }
        get {
            if let rs = objc_getAssociatedObject(self, &gradientAlphaKey) as? CGFloat {
                return rs
            }
            return 1.0
        }
    }
    
    func setTitleText() {
        self.titleTextAttributes = [NSAttributedString.Key.foregroundColor: titleColor, NSAttributedString.Key.font: titleFont]
    }
    
    func clearColor() {
        clearBackground()
        clearShadow()
    }
    
    func clearBackground() {
        self.isTranslucent = true
        self.setBackgroundImage(UIImage(), for: .default)
    }
    
    func clearShadow() {
        self.shadowImage = UIImage()
    }
}
