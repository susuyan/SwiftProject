//
//  FileHelper.swift
//  yulebaby
//
//  Created by susuyan on 2017/12/18.
//  Copyright © 2017年 susuyan. All rights reserved.
//

import Foundation

class FileHelper {
    
    lazy var fileManager = FileManager.default
    
    //创建文件路径
    func userDocumentsPathWithFile(_ filename: String) -> URL {
        
        let docPath = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        
        let path = docPath.appendingPathComponent(filename)
        
        return path
        
    }
    
}
