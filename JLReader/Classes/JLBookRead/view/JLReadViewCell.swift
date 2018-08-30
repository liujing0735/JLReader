//
//  JLReadViewCell.swift
//  JLReader
//
//  Created by JasonLiu on 2018/5/15.
//  Copyright © 2018年 JasonLiu. All rights reserved.
//

import UIKit

class JLReadViewCell: UITableViewCell {
    
    /// 阅读View 显示使用
    private(set) var readView:JLReadView!
    
    /// 当前的显示的内容
    var content:String! {
        
        didSet{
            
            if !content.isEmpty { // 有值
                
                readView.content = content
            }
        }
    }
    
    class func cellWithTableView(_ tableView:UITableView) ->JLReadViewCell {
        
        let ID = "JLReadViewCell"
        
        var cell = tableView.dequeueReusableCell(withIdentifier: ID) as? JLReadViewCell
        
        if (cell == nil) {
            
            cell = JLReadViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: ID)
        }
        
        return cell!
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        backgroundColor = UIColor.clear
        
        addSubViews()
    }
    
    func addSubViews() {
        
        // 阅读View
        readView = JLReadView()
        
        readView.backgroundColor = UIColor.clear
        
        contentView.addSubview(readView)
    }
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        // 布局
        readView.frame = GetReadViewFrame()
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
}
