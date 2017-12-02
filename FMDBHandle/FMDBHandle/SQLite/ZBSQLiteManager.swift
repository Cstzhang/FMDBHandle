//
//  ZBSQLiteManager.swift
//  FMDBHandle
//
//  Created by 恒信永利 on 2017/12/1.
//  Copyright © 2017年 zhangzhengbin. All rights reserved.
//
/*
 SQLite管理器
 */
import Foundation
import FMDB

class ZBSQLiteManager {
    //全局数据库单例
    static let shared = ZBSQLiteManager()
    //数据库队列
    let queue:FMDatabaseQueue
    
    //构造函数 加private防止外部访问
    private init(){
       //数据的路径 -path
        let dbName  = "zbDatabase.db"
        var path  = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        path = (path as NSString).appendingPathComponent(dbName)
        print("db path : \(path)")
        //创建数据库队列 同事创建或者打开数据库
        queue = FMDatabaseQueue(path: path)
        
        
    }
    
    
}
