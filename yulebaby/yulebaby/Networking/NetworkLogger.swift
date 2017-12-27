//
//  NetworkLogger.swift
//  yulebaby
//
//  Created by susuyan on 2017/12/26.
//  Copyright © 2017年 susuyan. All rights reserved.
//

import UIKit
import Moya
import Result
import SwiftyJSON

public final class NetworkLogger: PluginType {

    typealias Comparison = (TargetType) -> Bool
    
    let whitelist: Comparison
    let blacklist: Comparison
    fileprivate let loggerId = "yulebaby_Logger"
    fileprivate let dateFormatString = "yyyy/MM/dd HH:mm:ss"
    fileprivate let dateFormatter = DateFormatter()
    fileprivate let separator = ", "
    fileprivate let terminator = "\n"
    fileprivate let output = reversedPrint
    
    init(whitelist: @escaping Comparison = { _ -> Bool in return true }, blacklist: @escaping Comparison = { _ -> Bool in  return true }) {
        self.whitelist = whitelist
        self.blacklist = blacklist
    }
    
    public func willSend(_ request: RequestType, target: TargetType) {
        // If the target is in the blacklist, don't log it.
        guard blacklist(target) == false else { return }

        outputItems(logNetworkRequest(request.request as URLRequest?))

    }
    
    public func didReceive(_ result: Result<Moya.Response, MoyaError>, target: TargetType) {
        // If the target is in the blacklist, don't log it.
        guard blacklist(target) == false else { return }
        
        switch result {
        case .success(let response):
            if 200..<400 ~= (response.statusCode ) && whitelist(target) == false {
                // If the status code is OK, and if it's not in our whitelist, then don't worry about logging its response body.
                log.verbose("Received response(\(response.statusCode )) from \(response.response?.url?.absoluteString ?? String()).")
            }
            //输出响应体
//            outputItems(logNetworkResponse(response.response, data: response.data, target: target))
            #if DEBUG
                print(JSON(response.data))
            #endif
            
        case .failure(let error):
            // Otherwise, log everything.
            log.verbose("Received networking error: \(error)")
        }
    }
    
    fileprivate func outputItems(_ items: [String]) {
        items.forEach { output(separator, terminator, $0) }
    }
}

private extension NetworkLogger {
    var date: String {
        dateFormatter.dateFormat = dateFormatString
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        return dateFormatter.string(from: Date())
    }
    
    func format(_ loggerId: String, date: String, identifier: String, message: String) -> String {
        return "\(loggerId): [\(date)] \(identifier): \(message)"
    }
    
    func logNetworkRequest(_ request: URLRequest?) -> [String] {
        
        var output = [String]()
        
        output += [format(loggerId, date: date, identifier: "Request", message: request?.description ?? "(invalid request)")]
        
        if let headers = request?.allHTTPHeaderFields {
            output += [format(loggerId, date: date, identifier: "Request Headers", message: headers.description)]
        }
        
        if let bodyStream = request?.httpBodyStream {
            output += [format(loggerId, date: date, identifier: "Request Body Stream", message: bodyStream.description)]
        }
        
        if let httpMethod = request?.httpMethod {
            output += [format(loggerId, date: date, identifier: "HTTP Request Method", message: httpMethod)]
        }
        
        if let body = request?.httpBody, let stringOutput = String(data: body, encoding: .utf8) {
            output += [format(loggerId, date: date, identifier: "Request Body", message: stringOutput)]
        }
        
        return output
    }
    
    func logNetworkResponse(_ response: HTTPURLResponse?, data: Data?, target: TargetType) -> [String] {
        guard let response = response else {
            return [format(loggerId, date: date, identifier: "Response", message: "Received empty network response for \(target).")]
        }
        
        var output = [String]()
        
        output += [format(loggerId, date: date, identifier: "Response", message: response.description)]
        
        #if DEBUG
        print(JSON(data!))
        #endif
        
        return output
    }
}

fileprivate extension NetworkLogger {
    static func reversedPrint(_ separator: String, terminator: String, items: Any...) {
        for item in items {
            #if DEBUG
            print(item, separator: separator, terminator: terminator)
            #endif
        }
    }
}

