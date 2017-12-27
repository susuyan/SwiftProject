//
//  YTabBarController.swift
//  yulebaby
//
//  Created by susuyan on 2017/12/21.
//  Copyright © 2017年 susuyan. All rights reserved.
//

import UIKit

class YTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.white

    }

    
    var isTabBarVisible: Bool {
        return self.tabBar.frame.origin.y < view.frame.maxY
    }
    
    func setTabBarHidden(hidden: Bool, animated: Bool) {
        guard isTabBarVisible == hidden else {
            return
        }
        
        let height = self.tabBar.frame.size.height
        let offsetY = (hidden ? height : -height)
        
        let duration = (animated ? 0.25 : 0.0)
        
        UIView.animate(withDuration: duration, animations: { [weak self] in
            guard let strongSelf = self else {
                return
            }
            let frame = strongSelf.tabBar.frame
            strongSelf.tabBar.frame = frame.offsetBy(dx: 0, dy: offsetY)
            
            
            }, completion: nil)
    }
}
