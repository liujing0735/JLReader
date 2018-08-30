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
    private var firstPageUrl: String!
    private var prevPageUrl: String!
    private var nextPageUrl: String!
    private var lastPageUrl: String!
    private var currentPage: Int = 0
    private var totalPage: Int = 0
    
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
            
            let updatedState = book.query(".list_box")?.find(".title_box")?.find(".book_rg")?.find(".strong")?.first()?.text()
            print(updatedState!)
            dic["book_updated_state"] = updatedState!
            
            let latestChapter = book.query(".list_box")?.find(".title_box")?.find(".book_rg")?.find("b")?.first()?.text()
            print(latestChapter!)
            dic["book_latest_chapter"] = latestChapter!
            
            let updatedDate = book.query(".list_box")?.find(".title_box")?.find(".book_rg")?.find(".newDate")?.first()?.text()
            print(updatedDate!)
            dic["book_updated_date"] = updatedDate!
            
            var introduction: String = (book.query(".list_box")?.find(".book_jj")?.first()?.text())!
            introduction = introduction.trimmingCharacters(in: .whitespacesAndNewlines)
            introduction = introduction.replacing(pattern: " ", template: "")
            print(introduction)
            dic["book_introduction"] = introduction
            
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
                dic["book_today_down"] = components1[1]
                dic["book_month_down"] = components1[2]
                dic["book_total_down"] = components1[3]
            }
            
            let bookImg = book.query(".book_pic")?.find("img")?.first()?.attr("src")
            print(bookImg!)
            dic["book_img"] = bookImg!
            
            books.append(dic)
        }
        
        return books
    }
    
    func detail() -> [String: String] {
        if gumboDocument == nil {
            return [String: String]()
        }
        
        var dic = [String: String]()
        
        let bookName = gumboDocument.query("#show_container")?.find("#soft_info_para")?.find("h1")?.first()?.text()
        dic["book_name"] = bookName!.replacing(pattern: "TXT全集下载", template: "")
        
        let detail = gumboDocument.query("#show_container")?.find(".soft_info_r")?.first()
        let bookImg = detail?.query("img")?.first()?.attr("src")
        dic["book_img"] = bookImg
        
        let lis = detail?.query("li") as! [OCGumboNode]
        for li in lis {
            let text: String = li.text() ?? ""
            let author = "小说作者："
            if text.contains(author) {
                let range = text.range(of: author)
                dic["book_author"] = String(text.suffix(from: (range?.upperBound)!))
                dic["book_author_url"] = li.query("a")?.first()?.attr("href")
            }
            let size = "小说大小："
            if text.contains(size) {
                let range = text.range(of: size)
                dic["book_size"] = String(text.suffix(from: (range?.upperBound)!))
            }
            let todayDown = "今日点击："
            if text.contains(todayDown) {
                let range = text.range(of: todayDown)
                dic["book_today_down"] = String(text.suffix(from: (range?.upperBound)!))
            }
            let weekDown = "本周点击："
            if text.contains(weekDown) {
                let range = text.range(of: weekDown)
                dic["book_week_down"] = String(text.suffix(from: (range?.upperBound)!))
            }
            let monthDown = "本月点击："
            if text.contains(monthDown) {
                let range = text.range(of: monthDown)
                dic["book_month_downloads"] = String(text.suffix(from: (range?.upperBound)!))
            }
            let totalDown = "总点击数："
            if text.contains(totalDown) {
                let range = text.range(of: totalDown)
                dic["book_total_down"] = String(text.suffix(from: (range?.upperBound)!))
            }
            let updatedState = "写作进度："
            if text.contains(updatedState) {
                let range = text.range(of: updatedState)
                dic["book_updated_state"] = String(text.suffix(from: (range?.upperBound)!))
            }
            let updatedDate = "更新时间："
            if text.contains(updatedDate) {
                let range = text.range(of: updatedDate)
                dic["book_updated_date"] = String(text.suffix(from: (range?.upperBound)!))
            }
            let recommend = "推荐信息："
            if text.contains(recommend) {
                let range = text.range(of: recommend)
                dic["book_recommend"] = String(text.suffix(from: (range?.upperBound)!))
                dic["book_recommend_url"] = li.query("a")?.first()?.attr("href")
            }
            let latestChapter = "最新章节："
            if text.contains(latestChapter) {
                let range = text.range(of: latestChapter)
                dic["book_latest_chapter"] = String(text.suffix(from: (range?.upperBound)!))
            }
        }
        
        let intros = gumboDocument.query("#mainSoftIntro")?.find("p") as! [OCGumboNode]
        for intro in intros {
            let text = intro.text()
            let introductions = text!.components(separatedBy: "\n")
            if introductions.count >= 3 {
                dic["book_introduction"] = introductions[1].replacing(pattern: " ", template: "")
            }else {
                dic["book_introduction"] = text?.replacing(pattern: " ", template: "")
            }
        }
        return dic
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
    
    private func downUrl(url: String) -> String {
        return url.replacingOccurrences(of: ".html", with: "/down.html")
    }

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
                print("下一页：\(String(describing: nextPageUrl))")
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
