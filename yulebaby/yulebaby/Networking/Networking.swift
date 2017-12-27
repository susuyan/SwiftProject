//
//  Networking.swift
//  TestNetwork
//
//  Created by susuyan on 2017/12/13.
//  Copyright © 2017年 susuyan. All rights reserved.
//

import Foundation
import Moya
import Result
import Alamofire
import SwiftyJSON

import MBProgressHUD
import Toast_Swift
import Reachability

private var topViewController: UIViewController? {
    var resultVC: UIViewController?
    resultVC = _topViewController(UIApplication.shared.keyWindow?.rootViewController)
    while resultVC?.presentedViewController != nil {
        resultVC = _topViewController(resultVC?.presentedViewController)
    }
    return resultVC
}

private  func _topViewController(_ vc: UIViewController?) -> UIViewController? {
    if vc is UINavigationController {
        return _topViewController((vc as? UINavigationController)?.topViewController)
    } else if vc is UITabBarController {
        return _topViewController((vc as? UITabBarController)?.selectedViewController)
    } else {
        return vc
    }
}

class OnlineProvider<Target> where Target: Moya.TargetType {

    fileprivate let provider: MoyaProvider<Target>
    
    init(endpointClosure: @escaping MoyaProvider<Target>.EndpointClosure = MoyaProvider.defaultEndpointMapping,
         requestClosure: @escaping MoyaProvider<Target>.RequestClosure = MoyaProvider.defaultRequestMapping,
         stubClosure: @escaping MoyaProvider<Target>.StubClosure = MoyaProvider.neverStub,
         manager: Manager = MoyaProvider<Target>.defaultAlamofireManager(),
         plugins: [PluginType] = [],
         trackInflights: Bool = false) {

        self.provider = MoyaProvider(endpointClosure: endpointClosure,
                                     requestClosure: requestClosure,
                                     stubClosure: stubClosure,
                                     manager: manager,
                                     plugins: plugins,
                                     trackInflights: trackInflights)
        

        
    }
    
    
    func request(_ target: Target,
                 success successCallback: @escaping (JSON) -> Void,
                 //                 error errorCallback: @escaping (Int) -> Void,
        failure failureCallback: @escaping (MoyaError) -> Void) {
        
        
        self.provider.request(target) { (result) in
            
            switch result {
            case let .success(response):
                do {
                    //如果数据返回成功则直接将结果转为JSON
                    let respo = try response.filterSuccessfulStatusCodes()
                    let json = try JSON(respo.mapJSON())
                    
                    guard let vc = topViewController else { return }
                    
                    switch json["result"].intValue {
                    case 0:
                        successCallback(json)
                    case 1:
                        vc.view.makeToast("请登录")
                    case 2:
                        vc.view.makeToast("业务逻辑错误")
                    case 3:
                        vc.view.makeToast("参数校验失败")
                    case 4:
                        vc.view.makeToast("账号余额不足")
                    case -1:
                        vc.view.makeToast("服务器异常")
                        
                    default:
                        vc.view.makeToast(json["message"].string, duration: 0.5)
                    }
                    
                    
                }
                catch let error {
                    //如果数据获取失败，则返回错误状态码
                    //                    errorCallback((error as! MoyaError).response!.statusCode)
                    
                    failureCallback(error as! MoyaError)
                }
                
                
            case let .failure(error):
                //如果连接异常，则返沪错误信息（必要时还可以将尝试重新发起请求）
                //if target.shouldRetry {
                //    retryWhenReachable(target, successCallback, errorCallback,
                //      failureCallback)
                //}
                //else {
                failureCallback(error)
                //}
            }
        }
        
    }
       
}

protocol NetworkingType {
    associatedtype T: TargetType
    var provider: OnlineProvider<T> { get }
}

struct Networking: NetworkingType {
    typealias T = YuleBabyAPI
    let provider: OnlineProvider<YuleBabyAPI>
}

// "Public" interfaces
extension Networking {
    
    func request(_ target: YuleBabyAPI,
                 success successCallback: @escaping (JSON) -> Void,
                 failure failureCallback: @escaping (MoyaError) -> Void) {
        
        guard self.isReachable else {return}
        
        self.provider.request(target, success: successCallback, failure: failureCallback)
        
    }
    
    var isReachable: Bool {
        let reachability = Reachability()!
        let isReach: Bool
        
        switch reachability.connection {
        case .none:
            isReach = false
        default:
            isReach = true
        }
        return isReach
    }
    
}

// Static methods
extension NetworkingType {
    //带 Token 的请求
    static func newDefaultNetworking() -> Networking {
        return Networking(provider: newProvider(plugins))
    }
    
    static var plugins: [PluginType] {
        
        let activityPlugin = NetworkActivityPlugin(networkActivityClosure: { (type, target) in
            guard let vc = topViewController else { return }
            switch type {
            case .began:
                MBProgressHUD.hide(for: vc.view, animated: false)
                MBProgressHUD.showAdded(to: vc.view, animated: true)
                
                UIApplication.shared.isNetworkActivityIndicatorVisible = true
            case .ended:
                MBProgressHUD.hide(for: vc.view, animated: true)
                
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
        })
        
        let loggerPlugin =  NetworkLogger(blacklist: { target -> Bool in
            guard let target = target as? YuleBabyAPI else { return false }
            
            switch target {
                // 设置接口不打印 log 输出
            case .logout: return true
            default: return false
            }
        })
        
        return [activityPlugin, loggerPlugin]
        
    }
    
    static func endpointsClosure<T>() -> (T) -> Endpoint<T> where T: TargetType {
        
        return {target in
            
            let endpoint: Endpoint<T> = Endpoint<T>(url: url(target), sampleResponseClosure: {.networkResponse(200, target.sampleData)}, method: target.method, task: target.task, httpHeaderFields: [:])
            
            return endpoint
        }
    }
    
    //设置请求超时
    static var timeoutClosure :MoyaProvider<T>.RequestClosure {
        return {(endpoint: Endpoint<T>, closure: MoyaProvider<T>.RequestResultClosure) -> Void in
            
            if var urlRequest = try? endpoint.urlRequest() {
                urlRequest.timeoutInterval = 20
                closure(.success(urlRequest))
            } else {
                closure(.failure(MoyaError.requestMapping(endpoint.url)))
            }
        }
    }
    
    
}

private func newProvider<T>(_ plugins: [PluginType]) -> OnlineProvider<T>  {
    return OnlineProvider(endpointClosure: Networking.endpointsClosure(),
                          requestClosure: Networking.timeoutClosure,
                          plugins: plugins) as! OnlineProvider<T>
    

}

