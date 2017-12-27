//
//  UserManager.swift
//  yulebaby
//
//  Created by susuyan on 2017/12/19.
//  Copyright © 2017年 susuyan. All rights reserved.
//

import Foundation
import SwiftyJSON

final class UserManager: NSObject {
    
    enum FileError: Error {
        case fileRemoveError
        case fileStoreError
    }
    
    static let shareInstance = UserManager()
    fileprivate let userPathName = "User.data"
    
    private override init() {
        
    }
    
    var user: UserModel {
        //将 User 接档
        let userPath =  FileHelper().userDocumentsPathWithFile(userPathName)
        let userData = NSKeyedUnarchiver.unarchiveObject(withFile: userPath.path)
        
        return UserModel(fromJson: JSON(userData ?? [:]))
    }
    
    var isLogin: Bool {
        //判断是否登录
        if self.user.key != nil {
            return true
        }else {
            return false
        }
        
    }
    
    func storeUserData(_ user: UserModel){
        //将 User 归档
        let userPath =  FileHelper().userDocumentsPathWithFile(userPathName)
        do {
            let data = try JSONEncoder().encode(user)

            NSKeyedArchiver.archiveRootObject(data, toFile: userPath.path)
            log.info("存储 User Success")
        } catch  {
            log.error("存储 User Failure path：\(userPath)")
        }
    }
    
    func clearUserData(){
        //清除 User
        let userPath =  FileHelper().userDocumentsPathWithFile(userPathName)
        do {
          try FileManager.default.removeItem(atPath: userPath.path)
            
            log.info("移除 User Success")

        } catch {
            log.error("移除 User Failur path：\(userPath)")
        }
        
    }
    
}
