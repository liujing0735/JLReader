//
//  JLParsingHTML.swift
//  JLReader
//
//  Created by JasonLiu on 2018/7/10.
//  Copyright © 2018年 JasonLiu. All rights reserved.
//

import UIKit
import Alamofire

enum JLWebsite: String {
    case Web80txt = "https://www.80txt.com"
}

class JLParsingHTML: NSObject {
    
    private var website: JLWebsite = .Web80txt
    private var parsing80Txt: JLParsing80Txt!
    
    init(website: JLWebsite) {
        super.init()
        self.website = website
        parsing80Txt = JLParsing80Txt(url: self.website.rawValue)
    }
    
    init(website: JLWebsite, url: String!) {
        super.init()
        switch website {
        case .Web80txt:
            do {
                if url != nil {
                    if url.hasPrefix(website.rawValue) {
                        parsing80Txt = JLParsing80Txt(url: url)
                    }else {
                        parsing80Txt = JLParsing80Txt(url: website.rawValue + url)
                    }
                }else {
                    parsing80Txt = JLParsing80Txt(url: website.rawValue)
                }
            }
        }
    }
    
    func menus() -> [[String: Any]] {
        switch website {
        case .Web80txt:
            do {
                if parsing80Txt != nil {
                    return parsing80Txt.menus()
                }
            }
        }
        return [[:]]
    }
    
    func detail() -> [String: String] {
        switch website {
        case .Web80txt:
            do {
                if parsing80Txt != nil {
                    return parsing80Txt.detail()
                }
            }
        }
        return [:]
    }
    
    // 首页
    func firstLists() -> [[String: String]] {
        switch website {
        case .Web80txt:
            do {
                if parsing80Txt != nil {
                    return parsing80Txt.firstLists()
                }
            }
        }
        return [[String: String]]()
    }
    // 上一页
    func prevLists() -> [[String: String]] {
        switch website {
        case .Web80txt:
            do {
                if parsing80Txt != nil {
                    return parsing80Txt.prevLists()
                }
            }
        }
        return [[String: String]]()
    }
    // 下一页
    func nextLists() -> [[String: String]] {
        switch website {
        case .Web80txt:
            do {
                if parsing80Txt != nil {
                    return parsing80Txt.nextLists()
                }
            }
        }
        return [[String: String]]()
    }
    // 最后一页
    func lastLists() -> [[String: String]] {
        switch website {
        case .Web80txt:
            do {
                if parsing80Txt != nil {
                    return parsing80Txt.lastLists()
                }
            }
        }
        return [[String: String]]()
    }
    
    func downloadUrl() -> [String: String]! {
        switch website {
        case .Web80txt:
            do {
                if parsing80Txt != nil {
                    return parsing80Txt.downloadUrl()
                }
            }
        }
        return [String: String]()
    }
    
    func downloadFile(url: String, complete:((_ filePath: String, _ readModel: JLReadModel) ->Void)?) {
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        //let fileURL = documentsURL.appendingPathComponent(response.suggestedFilename!)
        let fileName: String = url.components(separatedBy: "/").last!
        let fileURL = documentsURL.appendingPathComponent("txt/" + fileName)
        
        let destination: DownloadRequest.DownloadFileDestination = { _, response in
            return (fileURL, [.createIntermediateDirectories, .removePreviousFile])
        }
        
        let urlRequest = URLRequest(url: url.toURL)
        Alamofire.download(urlRequest, to: destination)
            .downloadProgress { progress in
                print("\(fileName)已下载：\(progress.completedUnitCount/1024)KB")
                print("\(fileName)总大小：\(progress.totalUnitCount/1024)KB")
            }
            .response { response in
                if response.error != nil {
                    print("download failure: \(String(describing: response.error?.localizedDescription))")
                }
                if let filePath = response.destinationURL?.absoluteString {
                    print("文件路径 str：\(filePath)")
                    JLReadParser.ParserLocalURL(url: URL(string: filePath)!) {(readModel) in
                        if complete != nil {complete!(filePath, readModel)}
                    }
                }
            }
    }
}

