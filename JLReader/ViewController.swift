//
//  ViewController.swift
//  JLReader
//
//  Created by JasonLiu on 2018/7/5.
//  Copyright © 2018年 JasonLiu. All rights reserved.
//

import UIKit

class ViewController: DZMViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //gumboDocument = gumboDocument(url: "http://www.80txt.com/txtxz/52314/down.html")
        

        //downloadFile(url: "https://nt.80txt.com/52314/极品乖乖女之嫁个腹黑王爷.txt")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func readTXT(url: URL) -> Void {
        if !(url.path.hasSuffix(".txt")) && !(url.path.hasSuffix(".TXT")) {
            return
        }
        DZMReadParser.ParserLocalURL(url: url) {[weak self] (readModel) in
            let readController = DZMReadController()
            readController.readModel = readModel
            self?.navigationController?.pushViewController(readController, animated: true)
        }
    }
    
    func readTXT(path: String) -> Void {
        if !(path.hasSuffix(".txt")) && !(path.hasSuffix(".TXT")) {
            return
        }
        let url = URL(fileURLWithPath: path)
        readTXT(url: url)
    }
    
    func readEpub(path: String) -> Void {
        
    }
    

}


