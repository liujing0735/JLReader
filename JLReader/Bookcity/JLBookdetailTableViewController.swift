//
//  JLBookdetailTableViewController.swift
//  JLReader
//
//  Created by JasonLiu on 2018/8/23.
//  Copyright © 2018年 JasonLiu. All rights reserved.
//

import UIKit
import MJRefresh
import Kingfisher

class JLBookdetailTableViewController: JLBaseTableViewController {

    var controllerTitle: String!
    var urlString: String!
    private var parsingHTML: JLParsingHTML!
    private var detailDic: [String: String]!
    
    private var headerView = UIImageView()
    private var effectView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
    
    func reloadData() {
        let dic = detailDic
        if dic != nil {
            let bookImage: String = (dic?["book_img"])!
            let bookName: String = (dic?["book_name"])!
            let bookState: String = (dic?["book_updated_state"])!
            let bookIntroduction: String = (dic?["book_introduction"])!
            let bookAuthor: String = (dic?["book_author"])!
            
            headerView.kf.setImage(with: ImageResource(downloadURL: URL(string: bookImage)!, cacheKey: bookImage.md5))
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = controllerTitle
        addLeftItem(title: "返回")
        // Do any additional setup after loading the view.
        parsingHTML = JLParsingHTML(website: .Web80txt, url: urlString)
        detailDic = parsingHTML.detail()

        let frame = CGRect(x: 0, y: 0, width: screenWidth, height: 200)
        effectView.frame = frame
        headerView.frame = frame
        headerView.contentMode = .scaleAspectFill
        headerView.clipsToBounds = true
        headerView.addSubview(effectView)
        self.tableView.tableHeaderView = headerView
        self.tableView.separatorStyle = .none
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let width = screenWidth
        let yOffset = scrollView.contentOffset.y
        if yOffset < 0 {
            let offset = 200 + abs(yOffset)
            let scale = offset / 200
            effectView.frame = CGRect(x: 0, y: 0, width: width * scale, height: offset)
            headerView.frame = CGRect(x: 0, y: yOffset, width: width * scale, height: offset)
        }
    }
    
    // MARK: - UITableViewDelegate,UITableViewDataSource
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "TableViewCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: identifier)
        }
        cell?.selectionStyle = .none
        
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
