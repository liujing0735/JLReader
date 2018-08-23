//
//  JLBookdetailTableViewController.swift
//  JLReader
//
//  Created by JasonLiu on 2018/8/23.
//  Copyright © 2018年 JasonLiu. All rights reserved.
//

import UIKit

class JLBookdetailTableViewController: JLBaseTableViewController {

    var controllerTitle: String!
    var urlString: String!
    private var parsingHTML: JLParsingHTML!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = controllerTitle
        addLeftItem(title: "返回")
        // Do any additional setup after loading the view.
        parsingHTML = JLParsingHTML(website: .Web80txt, url: urlString)
        
        self.tableViewStyle = .grouped
        self.tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0.01))
        self.tableView.separatorStyle = .none
        self.tableView.delegate = self
        self.tableView.dataSource = self
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
