//
//  JLBaseTableViewController.swift
//  JLAlarmClock
//
//  Created by JasonLiu on 2018/2/3.
//  Copyright © 2018年 JasonLiu. All rights reserved.
//

import UIKit

class JLBaseTableViewController: JLBaseViewController,UITableViewDelegate,UITableViewDataSource {
    
    var barAnimation: Bool {
        set {
            _barAnimation = newValue
            if _barAnimation {
                self.baseNavigationBar.clearColor()
                self.view.bringSubviewToFront(self.baseNavigationBar)
            }
            updateTableViewFrame()
        }
        get {
            return _barAnimation
        }
    }
    private var _barAnimation: Bool = false
    
    var tableView: UITableView!
    var tableViewStyle: UITableView.Style {
        set {
            if _tableViewStyle != newValue {
                _tableViewStyle = newValue
                setupTableView()
                setupTapGesture()
            }
        }
        get {
            return _tableViewStyle
        }
    }
    private var _tableViewStyle: UITableView.Style = .plain
    
    func hideKeyboard() {
        //
    }
    
    private func setupTableView() {
        if self.tableView != nil {
            self.tableView.removeFromSuperview()
        }
        self.tableView = UITableView(frame: CGRect(), style: self.tableViewStyle)
        self.tableView.tableFooterView = UIView()
        //self.tableView.separatorInset = UIEdgeInsets()
        self.view.addSubview(self.tableView)
        
        updateTableViewFrame()
    }
    
    private func setupTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tapGesture.numberOfTapsRequired = 1
        tapGesture.cancelsTouchesInView = false
        if self.tableView != nil {
            self.tableView.addGestureRecognizer(tapGesture)
        }
    }
    
    private func updateTableViewFrame() {
        if #available(iOS 11.0, *) {
            var y: CGFloat = 0
            if !barAnimation {
                if isIPhoneX {
                    y = 44 + 44
                }else {
                    y = 20 + 44
                }
            }
            self.tableView.frame = CGRect(x: 0, y: y, width: screenWidth, height: screenHeight - y)
        }else {
            var y: CGFloat = 0
            var h: CGFloat = 0
            if !barAnimation {
                y = 20 + 44
                h = y
                if self.parent is UITabBarController {
                    h = y + 49
                }
            }
            self.tableView.frame = CGRect(x: 0, y: y, width: screenWidth, height: screenHeight - h)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupTableView()
        setupTapGesture()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if barAnimation {
            let y = scrollView.contentOffset.y
            if y >= 0 {
                self.barAlpha = min(1, y/160)
            }
        }
    }
    
    // MARK: - UITableViewDelegate,UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return false
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
