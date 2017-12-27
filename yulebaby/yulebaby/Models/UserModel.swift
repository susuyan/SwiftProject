//
//  UserModel.swift
//  TestNetwork
//
//  Created by susuyan on 2017/12/11.
//  Copyright © 2017年 susuyan. All rights reserved.
//

import UIKit
import SwiftyJSON

class UserModel: NSObject ,Codable{

    var age : String!
    var albumUrl : String!
    var babyType : String!
    var babyTypeZn : String!
    var birthday : String!
    var bondBalance : Int!
    var city : String!
    var community : String!
    var day : String!
    var id : String!
    var key : String!
    var message : String!
    var month : String!
    var monthAge : Int!
    var name : String!
    var point : String!
    var province : String!
    var remainTimes : String!
    var sex : String!
    var shopName : String!
    var shopTel : String!
    var shopid : Int!
    var swimTip : String!
    var tong : Bool!
    var userType : String!
    var year : String!

    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        age = json["age"].stringValue
        albumUrl = json["albumUrl"].stringValue
        babyType = json["babyType"].stringValue
        babyTypeZn = json["babyTypeZn"].stringValue
        birthday = json["birthday"].stringValue
        bondBalance = json["bondBalance"].intValue
        city = json["city"].stringValue
        community = json["community"].stringValue
        day = json["day"].stringValue
        id = json["id"].stringValue
        key = json["key"].stringValue
        message = json["message"].stringValue
        month = json["month"].stringValue
        monthAge = json["monthAge"].intValue
        name = json["name"].stringValue
        point = json["point"].stringValue
        province = json["province"].stringValue
        remainTimes = json["remainTimes"].stringValue
        sex = json["sex"].stringValue
        shopName = json["shopName"].stringValue
        shopTel = json["shopTel"].stringValue
        shopid = json["shopid"].intValue
        swimTip = json["swimTip"].stringValue
        tong = json["tong"].boolValue
        userType = json["userType"].stringValue
        year = json["year"].stringValue
    }

}
