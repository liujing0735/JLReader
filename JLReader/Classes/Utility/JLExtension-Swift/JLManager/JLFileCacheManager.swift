//
//  JLFileCacheManager.swift
//  JLReader
//
//  Created by JasonLiu on 2018/10/24.
//  Copyright © 2018 JasonLiu. All rights reserved.
//

import UIKit

class JLFileCacheManager: NSObject {
    
    private let cachePath = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).last

    static let shared: JLFileCacheManager = {
        let sharedInstance = JLFileCacheManager.init()
        return sharedInstance
    }()
    private override init() {
        super.init()
    }
    
    func read(fileName: String) -> Data! {
        let path = cachePath! + fileName
        do {
            let data = try NSData(contentsOfFile: path) as Data
            return data
        } catch let error {
            log(error)
        }
        return nil
    }
    
    func write(fileName: String, data: Data) -> Void {
        let path = cachePath! + fileName
        NSData(base64Encoded: data, options: NSData.Base64DecodingOptions.init(rawValue: 0))?.write(toFile: path, atomically: true)
    }
}
