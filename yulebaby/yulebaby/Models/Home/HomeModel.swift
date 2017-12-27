//
//  HomeModel.swift
//  yulebaby
//
//  Created by susuyan on 2017/12/25.
//  Copyright © 2017年 susuyan. All rights reserved.
//

import Foundation

import SwiftyJSON

class HomeModel{
    
    var albumUrl : String!
    var animationList : [AnimationList]!
    var birthday : String!
    var generalize : [Generalize]!
    var headSize : Float!
    var height : Float!
    var id : String!
    var misicList : [AnimationList]!
    var name : String!
    var naturalnessHeadSize : Int!
    var naturalnessHeight : String!
    var naturalnessWeight : String!
    var photoList : [PhotoList]!
    var reserveCount : Int!
    var reserveList : [ReserveList]!
    var weight : Float!
    
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        albumUrl = json["albumUrl"].stringValue
        animationList = [AnimationList]()
        let animationListArray = json["animationList"].arrayValue
        for animationListJson in animationListArray{
            let value = AnimationList(fromJson: animationListJson)
            animationList.append(value)
        }
        birthday = json["birthday"].stringValue
        generalize = [Generalize]()
        let generalizeArray = json["generalize"].arrayValue
        for generalizeJson in generalizeArray{
            let value = Generalize(fromJson: generalizeJson)
            generalize.append(value)
        }
        headSize = json["headSize"].floatValue
        height = json["height"].floatValue
        id = json["id"].stringValue
        misicList = [AnimationList]()
        let misicListArray = json["misicList"].arrayValue
        for misicListJson in misicListArray{
            let value = AnimationList(fromJson: misicListJson)
            misicList.append(value)
        }
        name = json["name"].stringValue
        naturalnessHeadSize = json["naturalnessHeadSize"].intValue
        naturalnessHeight = json["naturalnessHeight"].stringValue
        naturalnessWeight = json["naturalnessWeight"].stringValue
        photoList = [PhotoList]()
        let photoListArray = json["photoList"].arrayValue
        for photoListJson in photoListArray{
            let value = PhotoList(fromJson: photoListJson)
            photoList.append(value)
        }
        reserveCount = json["reserveCount"].intValue
        reserveList = [ReserveList]()
        let reserveListArray = json["reserveList"].arrayValue
        for reserveListJson in reserveListArray{
            let value = ReserveList(fromJson: reserveListJson)
            reserveList.append(value)
        }
        weight = json["weight"].floatValue
    }
    
}

class AnimationList{
    
    var id : Int!
    var imgUrl : String!
    var orderIndex : Int!
    var typeName : String!
    
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        id = json["id"].intValue
        imgUrl = json["imgUrl"].stringValue
        orderIndex = json["orderIndex"].intValue
        typeName = json["typeName"].stringValue
    }
    
}

class Generalize{
    
    var img : String!
    var orderindex : Int!
    var url : String!
    
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        img = json["img"].stringValue
        orderindex = json["orderindex"].intValue
        url = json["url"].stringValue
    }
    
}

class PhotoList{
    
    var groupKey : String!
    var groupList : [GroupList]!
    
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        groupKey = json["groupKey"].stringValue
        groupList = [GroupList]()
        let groupListArray = json["groupList"].arrayValue
        for groupListJson in groupListArray{
            let value = GroupList(fromJson: groupListJson)
            groupList.append(value)
        }
    }
    
    class GroupList{
        
        var babyImg : String!
        var babyImgOrigin : String!
        var monthAge : Int!
        var path : String!
        
        
        /**
         * Instantiate the instance using the passed json values to set the properties values
         */
        init(fromJson json: JSON!){
            if json.isEmpty{
                return
            }
            babyImg = json["babyImg"].stringValue
            babyImgOrigin = json["babyImgOrigin"].stringValue
            monthAge = json["month_age"].intValue
            path = json["path"].stringValue
        }
        
    }
    
}

class ReserveList{
    
    var appraise : Int!
    var latitude : [Latitude]!
    var satisfaction : Int!
    var shopImg : String!
    var shopName : String!
    var teacherCount : Int!
    
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        appraise = json["appraise"].intValue
        latitude = [Latitude]()
        let latitudeArray = json["latitude"].arrayValue
        for latitudeJson in latitudeArray{
            let value = Latitude(fromJson: latitudeJson)
            latitude.append(value)
        }
        satisfaction = json["satisfaction"].intValue
        shopImg = json["shopImg"].stringValue
        shopName = json["shopName"].stringValue
        teacherCount = json["teacherCount"].intValue
    }
    
    class Latitude{
        
        var distance : Int!
        
        
        /**
         * Instantiate the instance using the passed json values to set the properties values
         */
        init(fromJson json: JSON!){
            if json.isEmpty{
                return
            }
            distance = json["distance"].intValue
        }
        
    }
    
}
