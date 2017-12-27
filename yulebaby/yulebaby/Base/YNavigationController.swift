//
//  YNavigationController.swift
//  yulebaby
//
//  Created by susuyan on 2017/12/20.
//  Copyright © 2017年 susuyan. All rights reserved.
//

import UIKit

class YNavigationController: UINavigationController {

    @IBInspectable open var clearBackTitle: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        interactivePopGestureRecognizer?.delegate = self
        
        delegate = self
    }

    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if animated {
            interactivePopGestureRecognizer?.isEnabled = false
        }
        
        controlClearBackTitle()
        
        super.pushViewController(viewController, animated: animated)
    }
    
    override open func show(_ viewController: UIViewController, sender: Any?) {
        controlClearBackTitle()
        super.show(viewController, sender: sender)
    }
    
    override func popToRootViewController(animated: Bool) -> [UIViewController]? {
        if animated {
            interactivePopGestureRecognizer?.isEnabled = false
        }
        
        return super.popToRootViewController(animated: animated)
    }
    
    override func popToViewController(_ viewController: UIViewController, animated: Bool) -> [UIViewController]? {
        if animated {
            interactivePopGestureRecognizer?.isEnabled = false
        }
        
        return super.popToViewController(viewController, animated: false)
    }
}

extension YNavigationController {
    func controlClearBackTitle() {
        if clearBackTitle {
            topViewController?.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        }
    }
}

extension YNavigationController: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer == interactivePopGestureRecognizer {
            if self.viewControllers.count < 2 || self.visibleViewController == self.viewControllers[0] {
                return false
            }
        }
        
        return true
    }
}

extension YNavigationController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        interactivePopGestureRecognizer?.isEnabled = true
    }
}


