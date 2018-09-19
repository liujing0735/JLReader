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
    
    private var tableHeaderView: UIView!
    private var headerImageView: UIImageView!
    private var visualEffectView: UIVisualEffectView!
    private var bookImageView: UIImageView!
    private var bookNameLabel: UILabel!
    private var bookAuthorLabel: UILabel!
    private var bookStateLabel: UILabel!
    
    func reloadData() {
        let dic = detailDic
        if dic != nil {
            let bookImage: String = (dic?["book_img"])!
            let bookName: String = (dic?["book_name"])!
            let bookState: String = (dic?["book_updated_state"])!
            //let bookIntroduction: String = (dic?["book_introduction"])!
            let bookAuthor: String = (dic?["book_author"])!
            
            headerImageView.kf.setImage(with: ImageResource(downloadURL: URL(string: bookImage)!, cacheKey: bookImage.md5))
            bookImageView.kf.setImage(with: ImageResource(downloadURL: URL(string: bookImage)!, cacheKey: bookImage.md5))
            bookNameLabel.text = bookName
            bookAuthorLabel.text = bookAuthor
            bookStateLabel.text = bookState
        }
    }
    
    func createTableHeaderView() {
        tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 160 + 50))
        
        let frame = CGRect(x: 0, y: 0, width: screenWidth, height: 160)
        visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
        visualEffectView.frame = frame
        
        headerImageView = UIImageView()
        headerImageView.frame = frame
        headerImageView.contentMode = .scaleAspectFill
        headerImageView.clipsToBounds = true
        headerImageView.addSubview(visualEffectView)
        tableHeaderView.addSubview(headerImageView)
        
        bookImageView = UIImageView()
        bookImageView.frame = CGRect(x: 40, y: 50, width: 104, height: 128)
        tableHeaderView.addSubview(bookImageView)
        
        bookNameLabel = UILabel()
        bookNameLabel.frame = CGRect(x: 40 + 104 + 10, y: 50, width: screenWidth - (40 + 104 + 10 + 40), height: 21)
        tableHeaderView.addSubview(bookNameLabel)
        
        bookAuthorLabel = UILabel()
        bookAuthorLabel.frame = CGRect(x: 40 + 104 + 10, y: 50 + 40, width: screenWidth - (40 + 104 + 10 + 40), height: 21)
        bookAuthorLabel.textColor = .purple
        tableHeaderView.addSubview(bookAuthorLabel)
        
        bookStateLabel = UILabel()
        bookStateLabel.frame = CGRect(x: 40 + 104 + 10, y: 50 + 40 + 40, width: screenWidth - (40 + 104 + 10 + 40), height: 21)
        bookStateLabel.textColor = .blue
        tableHeaderView.addSubview(bookStateLabel)
        
        self.tableView.tableHeaderView = tableHeaderView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = controllerTitle
        addLeftItem(title: "返回")
        // Do any additional setup after loading the view.
        parsingHTML = JLParsingHTML(website: .Web80txt, url: urlString)
        detailDic = parsingHTML.detail()
        
        self.baseNavigationBar.gradientColors = [.blue, .purple]
        self.baseNavigationBar.titleColor = .clear
        self.baseNavigationBar.gradientAlpha = 0.0
        self.barAnimation = true

        createTableHeaderView()
        
        self.tableView.separatorStyle = .none
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(JLBookdetailTableViewCell.classForCoder(), forCellReuseIdentifier: "JLBookdetailTableViewCell")
        self.tableView.register(JLBookdetailRecommendTableViewCell.classForCoder(), forCellReuseIdentifier: "JLBookdetailRecommendTableViewCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        super.scrollViewDidScroll(scrollView)
        
        let width = screenWidth
        let yOffset = scrollView.contentOffset.y
        if yOffset < 0 {
            let offset = 160 + abs(yOffset)
            let scale = offset / 160
            visualEffectView.frame = CGRect(x: 0, y: 0, width: width * scale, height: offset)
            headerImageView.frame = CGRect(x: -(width * scale - width) / 2, y: yOffset, width: width * scale, height: offset)
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
