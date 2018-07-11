//
//  JLBookcityTableViewController.swift
//  JLReader
//
//  Created by JasonLiu on 2018/7/10.
//  Copyright © 2018年 JasonLiu. All rights reserved.
//

import UIKit

class JLBookcityTableViewController: JLBaseTableViewController {
    
    private var parsingHTML: JLParsingHTML!
    private var rowDatas: [[String: Any]]!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "书城"
        
        parsingHTML = JLParsingHTML(website: .Web80txt)
        rowDatas = parsingHTML.menus()
            
        self.tableViewStyle = .grouped
        self.tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0.01))
        self.tableView.separatorStyle = .singleLine
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

    private func reloadData() {
        rowDatas = parsingHTML.menus()
        //print(rowDatas)
        self.tableView.reloadData()
    }

    // MARK: - UITableViewDelegate,UITableViewDataSource
    override func numberOfSections(in tableView: UITableView) -> Int {
        return rowDatas.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return rowDatas[section]["title"] as? String
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (rowDatas[section]["value"] as! [[String : String]]).count
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
        cell?.accessoryType = .disclosureIndicator
        
        let value = (rowDatas[indexPath.section]["value"] as! [[String : String]])[indexPath.row]
        cell?.textLabel?.text = value["name"]
        
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let value = (rowDatas[indexPath.section]["value"] as! [[String : String]])[indexPath.row]
        let controller = JLBooklistTableViewController()
        controller.controllerTitle = value["name"]
        controller.urlString = value["html"]
        self.navigationController?.pushViewController(controller, animated: true)
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
