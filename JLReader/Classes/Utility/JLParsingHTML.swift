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
    
    init(website: JLWebsite, url: String) {
        super.init()
        switch website {
        case .Web80txt:
            do {
                if url.hasPrefix(website.rawValue) {
                    parsing80Txt = JLParsing80Txt(url: url)
                }else {
                    parsing80Txt = JLParsing80Txt(url: website.rawValue + url)
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
    
    func lists() -> [[String: String]]! {
        switch website {
        case .Web80txt:
            do {
                if parsing80Txt != nil {
                    return parsing80Txt.lists()
                }
            }
        }
        return nil
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
                if let filePath = response.destinationURL?.path {
                    print("文件路径 str：\(filePath)")
                    //self.readTXT(path: filePath)
                }
            }
            .responseJSON { response in
                switch response.result {
                case .success:
                    print("success")
                case .failure:
                    //response.resumeData
                    print("failure")
                }
        }
    }
}
