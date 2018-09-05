//
//  JLExtensionDictionary.swift
//  JLReader
//
//  Created by JasonLiu on 2018/9/4.
//  Copyright © 2018年 JasonLiu. All rights reserved.
//

import UIKit

extension Dictionary {
    
    func anyForKey(key: String) -> Any! {
        let dict: Dictionary<String, Any> = self as! Dictionary<String, Any>
        let keys: [String] = [String](dict.keys)
        if keys.contains(key) {
            return dict[key]
        }
        return nil
    }
    
    func dateForKey(key: String, format: String = "yyyy-MM-dd HH:mm:ss") -> Date {
        let value = anyForKey(key: key)
        if value != nil {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = format
            let date: Date = dateFormatter.date(from: value as! String)!
            return date
        }
        return Date()
    }
    
    func stringForKey(key: String) -> String {
        let value = anyForKey(key: key)
        if value != nil {
            if value is String {
                return value as! String
            }
            if value is Int {
                return "\(value as! Int)"
            }
        }
        return ""
    }
    
    func intForKey(key: String) -> Int {
        let value = anyForKey(key: key)
        if value != nil {
            if value is String {
                return Int(value as! String)!
            }
            if value is Int {
                return value as! Int
            }
        }
        return 0
    }
    
    func boolForKey(key: String) -> Bool {
        let value = anyForKey(key: key)
        if value != nil {
            if value is Int {
                return Bool(exactly: value as! NSNumber)!
            }
            if value is Bool {
                return value as! Bool
            }
        }
        return false
    }
}
