//
//  ViewController.swift
//  FMDBHandle
//
//  Created by 恒信永利 on 2017/12/1.
//  Copyright © 2017年 zhangzhengbin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print(ZBSQLiteManager.shared)
        let array:[
            [String:AnyObject]] = [["idstr":"001" as AnyObject,"text":"wb 101" as AnyObject],
                                   ["idstr":"002" as AnyObject,"text":"wb 102" as AnyObject],
                                   ["idstr":"003" as AnyObject,"text":"wb 103" as AnyObject],
                                   ["idstr":"004" as AnyObject,"text":"wb 104" as AnyObject],
                                   ["idstr":"005" as AnyObject,"text":"wb 105" as AnyObject],
                                   ["idstr":"006" as AnyObject,"text":"wb 106" as AnyObject],
                                   ["idstr":"007" as AnyObject,"text":"wb 107" as AnyObject],
                                   ["idstr":"008" as AnyObject,"text":"微博 108" as AnyObject]]
        
        ZBSQLiteManager.shared.updateStatus(userId: "1", array: array)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

