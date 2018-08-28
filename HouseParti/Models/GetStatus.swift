//
//  GetStatus.swift
//  HouseParti
//
//  Created by Developer on 28/08/18.
//  Copyright © 2018 developer. All rights reserved.
//

import UIKit
import ObjectMapper

class GetStatus: NSObject,Mappable {
    var status : Int?
    var messege : String?
    var music_info :[HouseMusic]?
    var getUserInfo : UserInfo?
   
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
        getUserInfo <- map["user_info"]
  }
}
