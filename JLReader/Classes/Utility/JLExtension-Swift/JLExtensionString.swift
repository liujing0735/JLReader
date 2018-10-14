//
//  JLExtensionString.swift
//  JLReader
//
//  Created by JasonLiu on 2018/9/4.
//  Copyright © 2018年 JasonLiu. All rights reserved.
//

import UIKit

extension String {
    
    var toURL: URL {
        let urlString = self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        return URL(string: urlString!)!
    }
    
    var toInt: Int {
        return Int(self)!
    }
    
    /// 截取子字符串
    ///
    /// - Parameters:
    ///   - start: 起始位置
    ///   - length: 字符长度
    /// - Returns: 子字符串
    func subString(start: Int = 0, length: Int = 0) -> String {
        var len = length
        if len == -1 {
            len = self.count - start
        }
        let st = self.index(startIndex, offsetBy: start)
        let en = self.index(st, offsetBy: len)
        return String(self[st ..< en])
    }
    
    /// 分割字符串
    ///
    /// - Returns: 单字符数组
    func strings() -> [String] {
        var array: [String] = []
        for i in 0 ..< self.count {
            array.append(self.subString(start: i, length: 1))
        }
        return array
    }
    
    var md5: String {
        let str = self.cString(using: String.Encoding.utf8)
        let strLen = CC_LONG(self.lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        
        CC_MD5(str!, strLen, result)
        
        let hash = NSMutableString()
        for i in 0 ..< digestLen {
            hash.appendFormat("%02x", result[i])
        }
        result.deinitialize(count: digestLen)
        
        return String(format: hash as String)
    }
}
