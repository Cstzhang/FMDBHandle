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
        //打开数据库
        creatTable()
    }

}

//MARK: -创建数据表以及私有方法
private extension ZBSQLiteManager{
    //创建数据表
    func creatTable() -> () {
        // 1 sql
        guard let path  = Bundle.main.path(forResource: "status.sql", ofType: nil),
              let sql  = try? String(contentsOfFile: path) else{
              return
        }
        // 2 执行sql fmdb内部队列 串行队列,同步执行 保证同一时间只有一个任务操作数据库，保证数据库的读写安全
        queue.inDatabase { (db) in
            //只有创建表的时候使用执行多条语句，可以一次创建多个数据表
            //执行增删改查的时候不能使用Statements，否则可能被注入
            if db.executeStatements(sql) == true {
                print("创建表成功")
            }else{
                print("创表失败")
            }
        }
        
        
    }
    
}

//MARK: -数据操作
extension ZBSQLiteManager{
 
    /// 新增/修改微博数据,数据属性的时候可能出现重叠
    ///
    /// - Parameters:
    ///   - userId: 当前用户登录的id
    ///   - array:  从网络获取的 '字典数据'
    func updateStatus(userId:String,array:[[String:AnyObject]])  {
        //1，准备sql
        /*
         statusId 当前微博id
         userId 用户id
         status 微博内容
         */
        let sql  = "INSERT OR REPLACE INTO T_status (statusId,userId,status) VALUES (?,?,?);"
        //2, 执行sql
        queue.inTransaction { (db, rollback) in
            //遍历数组，插入数据
            for dict in array{
                guard let statusId  = dict["idstr"] as? String,
                let jsonData  = try? JSONSerialization.data(withJSONObject: dict, options: []) else{
                    continue
                }
                //执行sql
                if db.executeUpdate(sql, withArgumentsIn: [statusId,userId,jsonData]) == false{
                    
                    //FIXME: -rollback
                    break
                }
                
                
            }
            
            
        }
        
        
        
        
        
        
        
        
    }
    
    
    
    
    
}
