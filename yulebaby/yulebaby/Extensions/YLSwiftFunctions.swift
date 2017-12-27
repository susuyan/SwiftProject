//
//  YLSwiftFunctions.swift
//  yulebaby
//
//  Created by susuyan on 2017/12/20.
//  Copyright © 2017年 susuyan. All rights reserved.
//

import Foundation

public struct yl {

    /// EZSE: Returns app's name
    public static var appDisplayName: String? {
        if let bundleDisplayName = Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String {
            return bundleDisplayName
        } else if let bundleName = Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String {
            return bundleName
        }
        
        return nil
    }
    
    /// EZSE: Returns app's version number
    public static var appVersion: String? {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
    }
    
    /// EZSE: Return app's build number
    public static var appBuild: String? {
        return Bundle.main.object(forInfoDictionaryKey: kCFBundleVersionKey as String) as? String
    }
    
    /// EZSE: Return app's bundle ID
    public static var appBundleID: String? {
        return Bundle.main.bundleIdentifier
    }
    
    /// EZSE: Returns both app's version and build numbers "v0.3(7)"
    public static var appVersionAndBuild: String? {
        if appVersion != nil && appBuild != nil {
            if appVersion == appBuild {
                return "v\(appVersion!)"
            } else {
                return "v\(appVersion!)(\(appBuild!))"
            }
        }
        return nil
    }
    
    /// EZSE: Return device version ""
    public static var deviceVersion: String {
        var size: Int = 0
        sysctlbyname("hw.machine", nil, &size, nil, 0)
        var machine = [CChar](repeating: 0, count: Int(size))
        sysctlbyname("hw.machine", &machine, &size, nil, 0)
        return String(cString: machine)
    }
    
    /// EZSE: Returns true if DEBUG mode is active //TODO: Add to readme
    public static var isDebug: Bool {
        #if DEBUG
            return true
        #else
            return false
        #endif
    }
    
    /// EZSE: Returns true if RELEASE mode is active //TODO: Add to readme
    public static var isRelease: Bool {
        #if DEBUG
            return false
        #else
            return true
        #endif
    }
    
    /// EZSE: Returns true if its simulator and not a device //TODO: Add to readme
    public static var isSimulator: Bool {
        #if (arch(i386) || arch(x86_64)) && os(iOS)
            return true
        #else
            return false
        #endif
    }
    
    /// EZSE: Returns true if its on a device and not a simulator //TODO: Add to readme
    public static var isDevice: Bool {
        #if (arch(i386) || arch(x86_64)) && os(iOS)
            return false
        #else
            return true
        #endif
    }

}
