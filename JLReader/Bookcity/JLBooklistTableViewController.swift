//
//  JLBooklistTableViewController.swift
//  JLReader
//
//  Created by JasonLiu on 2018/7/11.
//  Copyright © 2018年 JasonLiu. All rights reserved.
//

import UIKit
import MJRefresh


class JLBooklistTableViewController: JLBaseTableViewController, JLLabelDelegate {

    var controllerTitle: String!
    var urlString: String!
    private var parsingHTML: JLParsingHTML!
    private var rowDatas = [[String: String]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = controllerTitle
        addLeftItem(title: "返回")
        // Do any additional setup after loading the view.
        parsingHTML = JLParsingHTML(website: .Web80txt, url: urlString)
        rowDatas = parsingHTML.firstLists()
        
        self.tableView.separatorStyle = .singleLine
        self.tableView.separatorInset = UIEdgeInsets()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: {
            self.rowDatas = self.parsingHTML.firstLists()
            self.tableView.reloadData()
            self.tableView.mj_header.endRefreshing()
        })
        self.tableView.mj_footer = MJRefreshAutoNormalFooter(refreshingBlock: {
            self.rowDatas += self.parsingHTML.nextLists()
            self.tableView.reloadData()
            self.tableView.mj_footer.endRefreshing()
        })
        self.tableView.register(JLBooklistTableViewCell.classForCoder(), forCellReuseIdentifier: "JLBooklistTableViewCell")
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
        return 88
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "JLBooklistTableViewCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as! JLBooklistTableViewCell
        cell.selectionStyle = .none
        
        let dic: [String: String] = rowDatas[indexPath.row]
        cell.reloadData(dic: dic, delegate: self)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let dic: [String: String] = rowDatas[indexPath.row]
        let controller = JLBookdetailTableViewController()
        controller.controllerTitle = dic["book_name"]
        controller.urlString = dic["book_down"]
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    // MARK: -
    func didClickLabel(label: JLLabel) {
        let cell = label.superview as! JLBooklistTableViewCell
        let indexPath = self.tableView.indexPath(for: cell)
        let dic: [String: String] = rowDatas[indexPath!.row]
        log(dic)
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
