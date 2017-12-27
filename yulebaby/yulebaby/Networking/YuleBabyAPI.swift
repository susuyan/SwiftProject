//
//  YuleBabyAPI.swift
//  TestNetwork
//
//  Created by susuyan on 2017/12/13.
//  Copyright © 2017年 susuyan. All rights reserved.
//

import UIKit

import Moya
import Alamofire

enum YuleBabyAPI {
    //定义有参范式
    case login(username:String, password: String)
    case logout
    case reserveHome
    
}

extension YuleBabyAPI :TargetType {
    var base: String { return "http://m.beibeiyue.com/s"}
    var baseURL: URL { return URL(string: base)! }
    
    var parameters: [String: Any]? {
        switch self {
            
        case .login(let username, let password):
            return [
                "username": username as AnyObject,
                "password": password as AnyObject,
                "deviceType": "0",
                "deviceNumber": UIDevice.current.identifierForVendor?.uuidString as AnyObject,
                "msgToken": ""
            ]
            
        default:
            return nil
        }
    }
    
    var path: String {
        switch self {
        case .login:
            return "/login"
        case .logout:
            return "/logout"
        case .reserveHome:
            return "/reserveHome"
        }
    }
    
    var method: Moya.Method {
        switch self {
//        case .logout:
//            return .post
        default:
            return .get
        }
    }
    
    var sampleData: Data {
        return "".utf8Encoded
    }
    
    var task: Task {
        let requestParameters = parameters ?? [:]
        let encoding: ParameterEncoding
        switch self.method {
        case .post:
            encoding = JSONEncoding.default
        default:
            encoding = URLEncoding.default
        }
        return .requestParameters(parameters: requestParameters, encoding: encoding)
    }
    
    var headers: [String : String]? {
        switch self {
        case .login:
            return nil
        default:
            let Token = UserDefaults.standard.value(forKey: "Token")
            return ["Cookie":"JSESSIONID=\(Token!)"]
            
        }

    }
    
}

// MARK: - Helpers
private extension String {
    var urlEscaped: String {
        return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
    
    var utf8Encoded: Data {
        return data(using: .utf8)!
    }
}

func url(_ route: TargetType) -> String {
    return route.baseURL.appendingPathComponent(route.path).absoluteString
}





