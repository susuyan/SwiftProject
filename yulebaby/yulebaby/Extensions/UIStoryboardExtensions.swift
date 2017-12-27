//
//  UIStoryboardExtensions.swift
//  yulebaby
//
//  Created by susuyan on 2017/12/20.
//  Copyright © 2017年 susuyan. All rights reserved.
//

import UIKit

extension UIStoryboard {

    static var y_home: UIStoryboard {
        return UIStoryboard(name: "Home", bundle: nil)
    }
    
    static var y_main: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: nil)
    }
    
    static var y_service: UIStoryboard {
        return UIStoryboard(name: "Service", bundle: nil)
    }
    
    static var y_mine: UIStoryboard {
        return UIStoryboard(name: "Mine", bundle: nil)
    }

    
    /// EZSE: Get the application's main storyboard
    /// Usage: let storyboard = UIStoryboard.mainStoryboard
    public static var mainStoryboard: UIStoryboard? {
        let bundle = Bundle.main
        guard let name = bundle.object(forInfoDictionaryKey: "UIMainStoryboardFile") as? String else {
            return nil
        }
        return UIStoryboard(name: name, bundle: bundle)
    }
    
    /// EZSE: Get view controller from storyboard by its class type
    /// Usage: let profileVC = storyboard!.instantiateVC(ProfileViewController) /* profileVC is of type ProfileViewController */
    /// Warning: identifier should match storyboard ID in storyboard of identifier class
    public func instantiateVC<T>(_ identifier: T.Type) -> T? {
        let storyboardID = String(describing: identifier)
        if let vc = instantiateViewController(withIdentifier: storyboardID) as? T {
            return vc
        } else {
            return nil
        }
    }
}
