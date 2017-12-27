//
//  BundleExtensions.swift
//  yulebaby
//
//  Created by susuyan on 2017/12/20.
//  Copyright © 2017年 susuyan. All rights reserved.
//

import Foundation

public extension Bundle {
    
    /// EZSE: load xib
    //  Usage: Set some UIView subclass as xib's owner class
    //  Bundle.loadNib("ViewXibName", owner: self) //some UIView subclass
    //  self.addSubview(self.contentView)
    public class func loadNib(_ name: String, owner: AnyObject!) {
        _ = Bundle.main.loadNibNamed(name, owner: owner, options: nil)?[0]
    }
    
    /// EZSE: load xib
    /// Usage: let view: ViewXibName = Bundle.loadNib("ViewXibName")
    public class func loadNib<T>(_ name: String) -> T? {
        return Bundle.main.loadNibNamed(name, owner: nil, options: nil)?[0] as? T
    }
   
}
