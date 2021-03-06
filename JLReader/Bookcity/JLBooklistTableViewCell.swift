//
//  JLBooklistTableViewCell.swift
//  JLReader
//
//  Created by JasonLiu on 2018/7/11.
//  Copyright © 2018年 JasonLiu. All rights reserved.
//

import UIKit
import Kingfisher

class JLBooklistTableViewCell: UITableViewCell {
    
    var bookImageView: UIImageView!
    var bookNameLabel: UILabel!
    var bookStateLabel: UILabel!
    var bookIntroductionLabel: UILabel!
    var bookAuthorLabel: JLLabel!
    
    func reloadData(dic: [String: Any]) -> Void {
        reloadData(dic: dic, delegate: nil)
    }
    
    func reloadData(dic: [String: Any], delegate: JLLabelDelegate!) -> Void {
        let bookImage = dic["book_cover_img"] as! String
        let bookName = dic["book_name"] as! String
        let bookState = dic["book_updated_state"] as! String
        let bookIntroduction = dic["book_introduction"] as! String
        let bookAuthor = dic["book_author"] as! String
        
        bookImageView.kf.setImage(with: ImageResource(downloadURL: URL(string: bookImage)!, cacheKey: bookImage.md5))
        bookNameLabel.text = bookName
        bookStateLabel.text = bookState
        bookIntroductionLabel.text = bookIntroduction
        bookAuthorLabel.text = bookAuthor.components(separatedBy: ":")[1]
        if delegate != nil {
            bookAuthorLabel.delegate = delegate
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        bookImageView = UIImageView(frame: CGRect(x: 10, y: 19, width: 40, height: 50))
        self.addSubview(bookImageView)
        
        bookNameLabel = UILabel(frame: CGRect(x: 60, y: 10, width: 200, height: 10))
        bookNameLabel.font = UIFont.systemFont(ofSize: 13)
        self.addSubview(bookNameLabel)
        
        bookStateLabel = UILabel(frame: CGRect(x: screenWidth-50-10, y: 10, width: 50, height: 10))
        bookStateLabel.font = UIFont.systemFont(ofSize: 13)
        bookStateLabel.textColor = .blue
        bookStateLabel.textAlignment = .right
        self.addSubview(bookStateLabel)
        
        bookIntroductionLabel = UILabel(frame: CGRect(x: 60, y: 25, width: screenWidth-60-10, height: 38))
        bookIntroductionLabel.font = UIFont.systemFont(ofSize: 10)
        bookIntroductionLabel.textColor = .lightGray
        bookIntroductionLabel.numberOfLines = 0
        self.addSubview(bookIntroductionLabel)
        
        bookAuthorLabel = JLLabel(frame: CGRect(x: 60, y: 68, width: screenWidth-60-10, height: 10))
        bookAuthorLabel.textColor = .purple
        bookAuthorLabel.font = UIFont.systemFont(ofSize: 12)
        bookAuthorLabel.highlightedTextColor = .red
        self.addSubview(bookAuthorLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
