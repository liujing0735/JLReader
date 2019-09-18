//
//  JLDownloadManager.swift
//  JLReader
//
//  Created by JasonLiu on 2018/10/14.
//  Copyright © 2018年 JasonLiu. All rights reserved.
//

import UIKit
import Alamofire

class JLDownloadManager: NSObject {
    
    let fileCacheManager: JLFileCacheManager = {
        let manager: JLFileCacheManager = JLFileCacheManager.shared
        return manager
    }()
    
    let sessionManager: SessionManager = {
        let config: URLSessionConfiguration = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 15
        let manager: SessionManager = SessionManager(configuration: config)
        return manager
    }()
    
    static let shared: JLDownloadManager = {
        let sharedInstance = JLDownloadManager.init()
        return sharedInstance
    }()
    private override init() {
        super.init()
    }
    
    func download(url: String, path: URL!, complete:(( _ fileKey: String, _ filePath: String) ->Void)?) -> Void {
        if let filePath = path {
            let destination: DownloadRequest.DownloadFileDestination = { _, response in
                return (filePath, [.createIntermediateDirectories, .removePreviousFile])
            }
            
            if let data = fileCacheManager.read(fileName: url.md5) {
                Alamofire.download(resumingWith: data, to: destination)
                    .response { (response) in
                        if response.error != nil {
                            if let resumeData = response.resumeData {
                                self.fileCacheManager.write(fileName: url.md5, data: resumeData)
                            }
                        }
                        if let filePath = response.destinationURL?.absoluteString {
                            print("文件路径 str：\(filePath)")
                            if complete != nil {
                                complete!(url.md5, filePath)
                            }
                        }
                }
            }else {
                let urlRequest = URLRequest(url: url.toURL)
                Alamofire.download(urlRequest, to: destination)
                    .response { (response) in
                        if response.error != nil {
                            if let resumeData = response.resumeData {
                                self.fileCacheManager.write(fileName: url.md5, data: resumeData)
                            }
                        }
                        if let filePath = response.destinationURL?.absoluteString {
                            print("文件路径 str：\(filePath)")
                            if complete != nil {
                                complete!(url.md5, filePath)
                            }
                        }
                }
            }
        }
        
        
    }
}
