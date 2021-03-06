//
//  AppDelegate.swift
//  JLReader
//
//  Created by JasonLiu on 2018/7/5.
//  Copyright © 2018年 JasonLiu. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        firstLaunch()
        
        let bookcaseTable = JLBookcaseTableViewController()
        bookcaseTable.tabBarItem.title = "书架"
        bookcaseTable.tabBarItem.image = UIImage(named: "item_book_case")

        let bookcityTable = JLBookcityTableViewController()
        bookcityTable.tabBarItem.title = "书城"
        bookcityTable.tabBarItem.image = UIImage(named: "item_book_city")
        
        let tabBar = JLBaseTabBarController()
        tabBar.viewControllers = [bookcaseTable,bookcityTable]
        
        let navigation = UINavigationController(rootViewController: tabBar)
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigation
        window?.makeKeyAndVisible()
        
        //log("宽：\(screenWidth) , 高：\(screenHeight)")
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    private func firstLaunch() {
        if !UserDefaults.standard.bool(forKey: "firstLaunch") {
            UserDefaults.standard.set(true, forKey: "firstLaunch")
            
            createBookInfoTable()
        }
    }

    private func createBookInfoTable() {
        let sqlMgr = JLSQLiteManager.shared
        if sqlMgr.open() {
            let column: [String: JLSQLiteDataType] = [
                "book_id": .Integer,
                "book_name": .Text,
                "book_author": .Text,
                "book_identifier": .Text,
                "book_cover_img": .Text,
                "book_latest_chapter": .Text,
                "book_updated_state": .Text,
                "book_updated_date": .Text,
                "book_online_url": .Text,
                "book_local_url": .Text,
                "update_time": .Real]
            let constraint: [String: [JLSQLiteConstraint]] = [
                "book_id": [.AutoPrimaryKey],
                "book_identifier": [.NotNullUnique],
                "update_time": [.DefaultTimestamp]]
            sqlMgr.createTable(tbName: "book_info_table", tbColumn: column, tbConstraint: constraint) { (error) in
                
                if error != nil {
                    log((error?.errmsg)!)
                }
            }
            sqlMgr.close()
        }
    }
}

