//
//  JLBookcaseTableViewCell.swift
//  JLReader
//
//  Created by JasonLiu on 2018/10/13.
//  Copyright © 2018年 JasonLiu. All rights reserved.
//

import UIKit
import Kingfisher

class JLBookcaseTableViewCell: UITableViewCell {
    
    var bookImageView: UIImageView!
    var bookNameLabel: UILabel!
    var bookLatestChapterLabel: UILabel!
    var bookUpdatedDateLabel: UILabel!
    
    func reloadData(dic: [String: Any]) -> Void {
        let bookImage = dic["book_cover_img"] as! String
        let bookName = dic["book_name"] as! String
        let bookLatestChapter = dic["book_latest_chapter"] as! String
        let bookUpdatedDate = dic["book_updated_date"] as! String
        
        bookImageView.kf.setImage(with: ImageResource(downloadURL: URL(string: bookImage)!, cacheKey: bookImage.md5))
        bookNameLabel.text = bookName
        bookLatestChapterLabel.text = "最新：" + bookLatestChapter
        bookUpdatedDateLabel.text = bookUpdatedDate
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        bookImageView = UIImageView(frame: CGRect(x: 10, y: 10, width: 80, height: 100))
        self.addSubview(bookImageView)
        
        bookNameLabel = UILabel(frame: CGRect(x: 100, y: 20, width: screenWidth-100-10, height: 10))
        bookNameLabel.font = UIFont.systemFont(ofSize: 13)
        bookNameLabel.textColor = .black
        self.addSubview(bookNameLabel)
        
        bookLatestChapterLabel = UILabel(frame: CGRect(x: 100, y: 20+35, width: screenWidth-100-10, height: 10))
        bookLatestChapterLabel.font = UIFont.systemFont(ofSize: 13)
        bookLatestChapterLabel.textColor = .darkGray
        bookLatestChapterLabel.numberOfLines = 0
        self.addSubview(bookLatestChapterLabel)
        
        bookUpdatedDateLabel = UILabel(frame: CGRect(x: 100, y: 20+35+35, width: screenWidth-100-10, height: 10))
        bookUpdatedDateLabel.font = UIFont.systemFont(ofSize: 13)
        bookUpdatedDateLabel.textColor = .lightGray
        self.addSubview(bookUpdatedDateLabel)
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
