//
//  UserInfo.swift
//  HouseParti
//
//  Created by Developer on 28/08/18.
//  Copyright © 2018 developer. All rights reserved.
//

import UIKit
import ObjectMapper

class UserInfo: NSObject,Mappable {
    var status : Int?
    var messege : String?
    var music_info :[HouseMusic]?
    var parties_hosted :[HouseMusic]?
    var parties_attending :[HouseMusic]?
   var user : userData?
    
    override init() {
        super.init()
    }
    convenience required init?(map: Map) {
        self.init()
    }
    func mapping(map: Map) {
        status <- map["status"]
        messege <- map["message"]
        music_info <- map["music_info"]
        parties_hosted <- map["Parties_hosted"]
        parties_attending <- map["Parties_attending"]
        user <- map["User"]
    }
}

class userData: NSObject,Mappable {
    var useId : String?
    var first_name : String?
    var last_name : String?
    var full_name : String?
    var email : String?
    var password : String?
    var phone_number : String?
    var age : String?
    var gender : String?
    var profile_image : String?
    var device_token : String?
    var role : String?
    var status : String?
    var created : String?
    var updated : String?

    override init() {
        super.init()
    }
    convenience required init?(map: Map) {
        self.init()
    }
    func mapping(map: Map) {
        useId <- map["id"]
        first_name <- map["first_name"]
        last_name <- map["last_name"]
        full_name <- map["full_name"]
        email <- map["email"]
        password <- map["password"]
        phone_number <- map["phone_number"]
        age <- map["age"]
        gender <- map["gender"]
        profile_image <- map["profile_image"]
        device_token <- map["device_token"]
        role <- map["role"]
        status <- map["status"]
        created <- map["created"]
        updated <- map["updated"]
        
    }
}
