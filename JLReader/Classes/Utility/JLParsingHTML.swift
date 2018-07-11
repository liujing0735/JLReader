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

protocol JLParsingHTMLDelegate {
    func downloadProgress(parsing: JLParsingHTML, completed: Int64, total: Int64) -> Void
    func downloadSuccess(parsing: JLParsingHTML, fileURL: URL) -> Void
    func downloadFailure(parsing: JLParsingHTML, fileURL: URL) -> Void
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
    
    func menus() -> [[String: Any]]! {
        switch website {
        case .Web80txt:
            do {
                if parsing80Txt != nil {
                    return parsing80Txt.menus()
                }
            }
        }
        return nil
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
    
    func downloadFile(url: String) {
        
        let destination: DownloadRequest.DownloadFileDestination = { _, response in
            let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            //let fileURL = documentsURL.appendingPathComponent(response.suggestedFilename!)
            let fileName: String = "txt/" + (url.components(separatedBy: "/").last)!
            let fileURL = documentsURL.appendingPathComponent(fileName)
            
            return (fileURL, [.createIntermediateDirectories, .removePreviousFile])
        }
        
        let urlString = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let urlRequest = URLRequest(url: URL(string: urlString!)!)
        Alamofire.download(urlRequest, to: destination)
            .downloadProgress { progress in
                print("已下载：\(progress.completedUnitCount/1024)KB")
                print("总大小：\(progress.totalUnitCount/1024)KB")
            }
            .response { response in
                if response.error != nil {
                    print("download failure: \(String(describing: response.error?.localizedDescription))")
                }
                if let filePath = response.destinationURL?.path {
                    print("文件路径 str：\(filePath)")
                    //self.readTXT(path: filePath)
                }
        }
    }
}

