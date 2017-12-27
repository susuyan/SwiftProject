//
//  UIViewController+InteractiveNavigation.swift
//  yulebaby
//
//  Created by susuyan on 2017/12/21.
//  Copyright © 2017年 susuyan. All rights reserved.
//

import UIKit

private var interactiveNavigationBarHiddenAssociationKey: UInt8 = 0

extension UIApplication {
    override open var next: UIResponder? {
        UIViewController.awake
        return super.next
    }
}

extension UIViewController {
    static let awake : Void  = {
        replaceInteractiveMethods()
        return
    }()
    
    @IBInspectable public var interactiveNavigationBarHidden: Bool {
        get {
            var associateValue = objc_getAssociatedObject(self, &interactiveNavigationBarHiddenAssociationKey)
            if associateValue == nil {
                associateValue = false
            }
            return associateValue as! Bool;
        }
        set {
            objc_setAssociatedObject(self, &interactiveNavigationBarHiddenAssociationKey, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    fileprivate static func replaceInteractiveMethods() {
        method_exchangeImplementations(
            class_getInstanceMethod(self, #selector(UIViewController.viewWillAppear(_:)))!,
            class_getInstanceMethod(self, #selector(UIViewController.YL_interactiveViewWillAppear(_:)))!)
    }
    
    @objc func YL_interactiveViewWillAppear(_ animated: Bool) {
        YL_interactiveViewWillAppear(animated)
        let excludeVCs = [
            "CKSMSComposeRemoteViewController",
            "CKSMSComposeController",
            ]
        let vcName = NSStringFromClass(type(of: self))
        if excludeVCs.contains(vcName) { return }
        navigationController?.setNavigationBarHidden(interactiveNavigationBarHidden, animated: animated)
    }
    
}



