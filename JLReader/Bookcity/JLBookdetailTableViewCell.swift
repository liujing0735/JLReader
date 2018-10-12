//
//  JLBookdetailTableViewCell.swift
//  JLReader
//
//  Created by JasonLiu on 2018/8/23.
//  Copyright © 2018年 JasonLiu. All rights reserved.
//

import UIKit

class JLBookdetailTableViewCell: UITableViewCell {

    var bookIntroductionLabel: UILabel!
    
    func reloadData(dict: [String: String]!) {
        
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        bookIntroductionLabel = UILabel()
        bookIntroductionLabel.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 200)
        bookIntroductionLabel.textColor = .lightGray
        bookIntroductionLabel.font = UIFont.systemFont(ofSize: 10)
        self.addSubview(bookIntroductionLabel)
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
