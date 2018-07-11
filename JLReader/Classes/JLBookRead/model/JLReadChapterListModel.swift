//
//  JLReadChapterListModel.swift
//  JLReader
//
//  Created by JasonLiu on 2018/5/12.
//  Copyright © 2018年 JasonLiu. All rights reserved.
//

import UIKit

class JLReadChapterListModel: NSObject,NSCoding {
    
    /// 小说ID
    var bookID:String!
    
    /// 章节ID
    var id:String!
    
    /// 章节名称
    var name:String!
    
    /// 优先级 (一般章节段落都带有排序的优先级 从 0 开始)
    var priority:NSNumber!
    
    // MARK: -- 操作
    func readChapterModel(isUpdateFont:Bool = false) ->JLReadChapterModel? {
        
        if JLReadChapterModel.IsExistReadChapterModel(bookID: bookID, chapterID: id) {
            
            return JLReadChapterModel.readChapterModel(bookID: bookID, chapterID: id, isUpdateFont: isUpdateFont)
        }
        
        return nil
    }
    
    // MARK: -- NSCoding
    
    override init() {
        
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init()
        
        priority = aDecoder.decodeObject(forKey: "priority") as! NSNumber
        
        bookID = aDecoder.decodeObject(forKey: "bookID") as! String
        
        id = aDecoder.decodeObject(forKey: "id") as! String
        
        name = aDecoder.decodeObject(forKey: "name") as! String
    }
    
    func encode(with aCoder: NSCoder) {
        
        aCoder.encode(priority, forKey: "priority")
        
        aCoder.encode(bookID, forKey: "bookID")
        
        aCoder.encode(id, forKey: "id")
        
        aCoder.encode(name, forKey: "name")
    }
}
