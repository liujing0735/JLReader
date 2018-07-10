//
//  ViewController.swift
//  JLReader
//
//  Created by JasonLiu on 2018/7/5.
//  Copyright © 2018年 JasonLiu. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: DZMViewController {
    
    private var gumboDocument: OCGumboDocument! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        gumboDocument = gumboDocument(url: "http://www.80txt.com/txtxz/52314/down.html")
        
        print(menu())
        print(list())
        print(down())
        downloadFile(url: "https://nt.80txt.com/52314/极品乖乖女之嫁个腹黑王爷.txt")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func readTXT(url: URL) -> Void {
        if !(url.path.hasSuffix(".txt")) && !(url.path.hasSuffix(".TXT")) {
            return
        }
        DZMReadParser.ParserLocalURL(url: url) {[weak self] (readModel) in
            let readController = DZMReadController()
            readController.readModel = readModel
            self?.navigationController?.pushViewController(readController, animated: true)
        }
    }
    
    func readTXT(path: String) -> Void {
        if !(path.hasSuffix(".txt")) && !(path.hasSuffix(".TXT")) {
            return
        }
        let url = URL(fileURLWithPath: path)
        readTXT(url: url)
    }
    
    func readEpub(path: String) -> Void {
        
    }
    
    // MARK:--OCGumboDocument
    func gumboDocument(url: String) -> OCGumboDocument! {
        do {
            let htmlString = try String(contentsOf: URL(string: url)!, encoding: String.Encoding.utf8)
            let document = OCGumboDocument(htmlString: htmlString)
            return document
        } catch let error as NSError {
            print(error.domain)
        }
        return nil
    }
    
    func menu() -> [String: [[String: String]]]! {
        if gumboDocument == nil {
            return nil
        }
        
        var dic = [String: [[String: String]]]()
        
        let menus = gumboDocument.query("#menu")?.find("#nav") as! [OCGumboNode]
        for nav in menus {
            let span = nav.query("span")?.first() as! OCGumboElement
            //print(span.text()!)
            
            var values = [[String: String]]()
            
            let li = nav.query("li") as! [OCGumboNode]
            for node in li {
                let a = node.query("a") as! [OCGumboNode]
                for element in a {
                    //print(element.text()! + element.attr("href")!)
                    values.append([element.text()!: element.attr("href")!])
                }
            }
            dic[span.text()!] = values
        }
        return dic
    }
    
    func list() -> [[String: String]]! {
        if gumboDocument == nil {
            return nil
        }
        
        var books = [[String: String]]()
        
        let list = gumboDocument.query("#list_art_2013") as! [OCGumboNode]
        for book in list {
            var dic = [String: String]()
            
            let bookName = book.query(".list_box")?.find(".title_box")?.find(".book_bg")?.find("a")?.first()?.text()
            print(bookName!)
            dic["book_name"] = bookName!.components(separatedBy: " ")[0]
            
            let bookDown = book.query(".list_box")?.find(".title_box")?.find(".book_bg")?.find("a")?.first()?.attr("href")
            print(bookDown!)
            dic["book_down"] = bookDown!
            
            let bookState = book.query(".list_box")?.find(".title_box")?.find(".book_rg")?.find(".strong")?.first()?.text()
            print(bookState!)
            dic["book_state"] = bookState!
            
            let bookLatestChapter = book.query(".list_box")?.find(".title_box")?.find(".book_rg")?.find("b")?.first()?.text()
            print(bookLatestChapter!)
            dic["book_latest_chapter"] = bookLatestChapter!
            
            let bookUpdatedDate = book.query(".list_box")?.find(".title_box")?.find(".book_rg")?.find(".newDate")?.first()?.text()
            print(bookUpdatedDate!)
            dic["book_updated_date"] = bookUpdatedDate!
            
            let bookIntroduction = book.query(".list_box")?.find(".book_jj")?.first()?.text()
            print(bookIntroduction!)
            dic["book_introduction"] = bookIntroduction!
            
            let bookCont = book.query(".list_box")?.find(".book_cont")?.find(".parag_2013")?.first()?.text()
            print(bookCont!)
            dic["book_cont"] = bookCont!
            
            let bookImg = book.query(".book_pic")?.find("img")?.first()?.attr("src")
            print(bookImg!)
            dic["book_img"] = bookImg!
            
            books.append(dic)
        }
        
        return books
    }
    
    // http://www.80txt.com/txtxz/52314.html
    // http://www.80txt.com/txtxz/52314/down.html
    // http://www.80txt.com/txtml_52314.html
    
    func down() -> [String: String]! {
        if gumboDocument == nil {
            return nil
        }
        
        var dic = [String: String]()
        
        let downs = gumboDocument.query(".down_url_txt")?.find(".wanpan_url") as! [OCGumboNode]
        for down in downs {
            let urlExplain = down.query(".pan_sm")?.find("strong")?.first()?.text()
            let urlAddresses = down.query(".pan_url")?.find("a") as! [OCGumboNode]
            for urlAddress in urlAddresses {
                let url = urlAddress.attr("href")
                if (url?.hasSuffix(".txt"))! {
                    dic[urlExplain!] = url
                }
            }
        }
        
        return dic
    }
    
    func downUrl(url: String) -> String {
        return url.replacingOccurrences(of: ".html", with: "/down.html")
    }
    
    func read(url: String) -> [String]! {
        return nil
    }
    
    func readUrl(url: String) -> String {
        return url.replacingOccurrences(of: "/txtxz/", with: "/txtml_")
    }
    // http://dt.80txt.com/52314/极品乖乖女之嫁个腹黑王爷.txt
    // http://nt.80txt.com/52314/极品乖乖女之嫁个腹黑王爷.txt
    // http://txt.80txt.com/52314/极品乖乖女之嫁个腹黑王爷.txt
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
                    self.readTXT(path: filePath)
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


