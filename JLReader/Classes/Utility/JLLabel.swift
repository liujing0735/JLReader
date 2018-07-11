//
//  JLLabel.swift
//  JLReader
//
//  Created by JasonLiu on 2018/7/11.
//  Copyright © 2018年 JasonLiu. All rights reserved.
//

import UIKit

protocol JLLabelDelegate {
    func didClickLabel(label: JLLabel) -> Void
}

class JLLabel: UILabel {

    var delegate: JLLabelDelegate!
    var notificationName: String!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.isUserInteractionEnabled = true
        
        let tap = UILongPressGestureRecognizer(target: self, action: #selector(clickLabel))
        tap.minimumPressDuration = 0.01
        self.addGestureRecognizer(tap)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func clickLabel(gesture: UILongPressGestureRecognizer) -> Void {
        let locationPoint = gesture.location(in: self)
        if gesture.state == .began {
            self.isHighlighted = true
        }
        if gesture.state == .changed {
            if locationPoint.x <= self.bounds.size.width && locationPoint.x >= 0 && locationPoint.y <= self.bounds.size.height && locationPoint.y >= 0 {
                self.isHighlighted = true
            }else {
                self.isHighlighted = false
            }
        }
        if gesture.state == .ended {
            if locationPoint.x <= self.bounds.size.width && locationPoint.x >= 0 && locationPoint.y <= self.bounds.size.height && locationPoint.y >= 0 {
                if delegate != nil {
                    delegate.didClickLabel(label: self)
                }
                if notificationName != nil {
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: notificationName!), object: self, userInfo: nil)
                }
            }
            self.isHighlighted = false
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
