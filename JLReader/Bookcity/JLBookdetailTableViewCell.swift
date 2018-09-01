//
//  JLBookdetailTableViewCell.swift
//  JLReader
//
//  Created by JasonLiu on 2018/8/23.
//  Copyright © 2018年 JasonLiu. All rights reserved.
//

import UIKit

class JLBookdetailTableViewCell: UITableViewCell {

    var bookImageView: UIImageView!
    var bookNameLabel: UILabel!
    var bookStateLabel: UILabel!
    var bookIntroductionLabel: UILabel!
    var bookAuthorLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
