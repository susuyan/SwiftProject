//
//  AppConstants.swift
//  yulebaby
//
//  Created by susuyan on 2017/12/19.
//  Copyright © 2017年 susuyan. All rights reserved.
//

import Foundation
import Kingfisher


//MARK: Default Key
extension String {
    static let searchHistoryKey = "searchHistoryKey"
    static let sexTypeKey = "sexTypeKey"
}

//MARK: - Notification Name
extension NSNotification.Name {
    static let USexTypeDidChange = NSNotification.Name("USexTypeDidChange")
}

final class AppConstants {
    
    static let appURLString = "itms-apps://itunes.apple.com/app/id" + "983891256"
    
    struct TestAcount {
        //非通卡
        static let testUsername = "13146022991"
        static let testPassword = "654321"
        //通卡
        static let testUsernameT = ""
        static let testPasswordT = ""
    }
    
    struct Defaults {
        static let searchHistoryKey = "searchHistoryKey"
        static let sexTypeKey = "sexTypeKey"
    }
    
    struct ThirdPatyKey {
        static let UMengAppKey = ""
    }
}

//MARK: Kingfisher
extension Kingfisher where Base: ImageView {
    @discardableResult
    public func setImage(urlString: String?, placeholder: Placeholder? = UIImage(named: "normal_placeholder_h")) -> RetrieveImageTask {
        return setImage(with: URL(string: urlString ?? ""),
                        placeholder: placeholder,
                        options:[.transition(.fade(0.5))])
    }
}

extension Kingfisher where Base: UIButton {
    @discardableResult
    public func setImage(urlString: String?, for state: UIControlState, placeholder: UIImage? = UIImage(named: "normal_placeholder_h")) -> RetrieveImageTask {
        return setImage(with: URL(string: urlString ?? ""),
                        for: state,
                        placeholder: placeholder,
                        options: [.transition(.fade(0.5))])
        
    }
}
