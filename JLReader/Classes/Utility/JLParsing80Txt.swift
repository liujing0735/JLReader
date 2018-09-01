//
//  JLParsing80Txt.swift
//  JLReader
//
//  Created by JasonLiu on 2018/7/10.
//  Copyright © 2018年 JasonLiu. All rights reserved.
//

import UIKit

class JLParsing80Txt: NSObject {

    private var gumboDocument: OCGumboDocument! = nil
    private var firstPageUrl: String!   // 首页地址
    private var prevPageUrl: String!    // 上一页地址
    private var nextPageUrl: String!    // 下一页地址
    private var lastPageUrl: String!    // 末页地址
    private var currentPage: Int = 0    // 当前页
    private var totalPage: Int = 0      // 总页数
    
    init(url: String) {
        super.init()
        gumboDocument = gumboDocument(url: url)
    }
    
    func menus() -> [[String: Any]]! {
        if gumboDocument == nil {
            return nil
        }
        
        var array = [[String: Any]]()
        
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
                    var dic = [String: String]()
                    dic["name"] = element.text()
                    dic["html"] = element.attr("href")
                    values.append(dic)
                }
            }
            
            var dic = [String: Any]()
            dic["title"] = span.text()
            dic["value"] = values
            array.append(dic)
        }
        return array
    }
    // 首页
    func firstLists() -> [[String: String]] {
        if firstPageUrl == nil {
            return [[String: String]]()
        }
        gumboDocument = gumboDocument(url: firstPageUrl)
        return lists()
    }
    // 上一页
    func prevLists() -> [[String: String]] {
        if prevPageUrl == nil {
            return [[String: String]]()
        }
        gumboDocument = gumboDocument(url: prevPageUrl)
        return lists()
    }
    // 下一页
    func nextLists() -> [[String: String]] {
        if nextPageUrl == nil {
            return [[String: String]]()
        }
        gumboDocument = gumboDocument(url: nextPageUrl)
        return lists()
    }
    // 最后一页
    func lastLists() -> [[String: String]] {
        if lastPageUrl == nil {
            return [[String: String]]()
        }
        gumboDocument = gumboDocument(url: lastPageUrl)
        return lists()
    }
    
    func lists() -> [[String: String]] {
        if gumboDocument == nil {
            return [[String: String]]()
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
            
            var bookIntroduction: String = (book.query(".list_box")?.find(".book_jj")?.first()?.text())!
            bookIntroduction = bookIntroduction.trimmingCharacters(in: .whitespacesAndNewlines)
            bookIntroduction = bookIntroduction.replacing(pattern: " ", template: "")
            print(bookIntroduction)
            dic["book_introduction"] = bookIntroduction
            
            var bookCont: String = (book.query(".list_box")?.find(".book_cont")?.find(".parag_2013")?.first()?.text())!
            bookCont = bookCont.replacing(pattern: "\n", template: " ")
            print(bookCont)
            let components1 = bookCont.components(separatedBy: " ")
            if components1.count > 2 {
                dic["book_author"] = components1[0]
                dic["book_size"] = components1[1]
            }
            let components2 = bookCont.components(separatedBy: "\n")
            if components2.count > 4 {
                dic["book_today_downloads"] = components1[1]
                dic["book_month_downloads"] = components1[2]
                dic["book_total_downloads"] = components1[3]
            }
            
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
    func downs() -> [String: String]! {
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
    
    func reads(url: String) -> [String]! {
        return nil
    }
    
    /// 作品下载页地址
    ///
    /// - Parameter url: 作品详情页地址
    /// - Returns: 作品下载页地址
    private func downUrl(url: String) -> String {
        return url.replacingOccurrences(of: ".html", with: "/down.html")
    }
    
    /// 作品阅读页地址
    ///
    /// - Parameter url: 作品详情页地址
    /// - Returns: 作品阅读页地址
    private func readUrl(url: String) -> String {
        return url.replacingOccurrences(of: "/txtxz/", with: "/txtml_")
    }

    private func pageUrl(document: OCGumboDocument!) -> Void {
        if document == nil {
            return
        }
        
        firstPageUrl = nil
        prevPageUrl = nil
        nextPageUrl = nil
        lastPageUrl = nil
        currentPage = 0
        totalPage = 0

        let pages = document.query("#pagelink")?.find("a") as! [OCGumboNode]
        for page in pages {
            if page.attr("class") == "first" {
                firstPageUrl = page.attr("href")
            }
            if page.attr("class") == "prev" {
                prevPageUrl = page.attr("href")
            }
            if page.attr("class") == "next" {
                nextPageUrl = page.attr("href")
                print("下一页：\(nextPageUrl)")
            }
            if page.attr("class") == "last" {
                lastPageUrl = page.attr("href")
                totalPage = (page.text()?.toInt)!
            }
        }
        
        let text = document.query("#pagelink")?.find("strong")?.first()?.text()
        if text != nil {
            currentPage = (text?.toInt)!
        }
    }
    
    // MARK:--OCGumboDocument
    func gumboDocument(url: String) -> OCGumboDocument! {
        do {
            let htmlString = try String(contentsOf: URL(string: url)!, encoding: String.Encoding.utf8)
            let document = OCGumboDocument(htmlString: htmlString)
            pageUrl(document: document)
            return document
        } catch let error as NSError {
            print(error.domain)
        }
        return nil
    }
}
