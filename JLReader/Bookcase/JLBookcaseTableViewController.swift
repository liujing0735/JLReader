//
//  JLBookcaseTableViewController.swift
//  JLReader
//
//  Created by JasonLiu on 2018/7/10.
//  Copyright © 2018年 JasonLiu. All rights reserved.
//

import UIKit
import MJRefresh

class JLBookcaseTableViewController: JLBaseTableViewController {
    
    private var parsingHTML: JLParsingHTML!
    private var rowDatas = [[String: Any]]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "书架"
        
        self.tableView.separatorStyle = .singleLine
        self.tableView.separatorInset = UIEdgeInsets()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: {
            let sqlMgr = JLSQLiteManager.shared
            if sqlMgr.open() {
                sqlMgr.select(tbName: "book_info_table") { (result, error) in
                    self.rowDatas = result
                }
                sqlMgr.close()
            }
            self.tableView.reloadData()
            self.tableView.mj_header.endRefreshing()
        })
//        self.tableView.mj_footer = MJRefreshAutoNormalFooter(refreshingBlock: {
//            self.tableView.reloadData()
//            self.tableView.mj_footer.endRefreshing()
//        })
        self.tableView.register(JLBookcaseTableViewCell.classForCoder(), forCellReuseIdentifier: "JLBookcaseTableViewCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tableView.mj_header.beginRefreshing()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - UITableViewDelegate,UITableViewDataSource
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowDatas.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "JLBookcaseTableViewCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as! JLBookcaseTableViewCell
        cell.selectionStyle = .none
        
        let dic: [String: Any] = rowDatas[indexPath.row]
        cell.reloadData(dic: dic)
        return cell
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
