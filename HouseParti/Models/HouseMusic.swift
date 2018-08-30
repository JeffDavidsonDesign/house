//
//  HouseMusic.swift
//  HouseParti
//
//  Created by Developer on 28/08/18.
//  Copyright © 2018 developer. All rights reserved.
//

import UIKit
import ObjectMapper

class HouseMusic: NSObject,Mappable {
    var musicId : String?
    var musicName : String?
    var party_hostedId : String?
    var partyTitle : String?
    var partyDescription : String?
    var partyAddress : String?
    var partyZipcode : String?
    var partyCity : String?
    var partyMusic : String?
    var food_drink : String?
    var guest_limit : String?
    var ticket_price : String?
    var start_time : String?
    var end_time : String?
    var hosted_by : String?
    var age_min :String?
    var age_max :String?
    var created : String?
    var updated : String?
    var preferred_guest:String?
    var tickets_sold:String?
    var total_tickets:String?
    var lat:String?
    var long:String?


    override init() {
        super.init()
    }
    convenience required init?(map: Map) {
        self.init()
    }
    func mapping(map: Map) {
        musicId <- map["id"]
        musicName <- map["name"]
        party_hostedId <- map["id"]
        partyTitle <- map["title"]
        partyDescription <- map["description"]
        partyAddress <- map["address"]
        partyZipcode <- map["zipcode"]
        partyCity <- map["city"]
        partyMusic <- map["music"]
        food_drink <- map["food_drink"]
        guest_limit <- map["guest_limit"]
        ticket_price <- map["ticket_price"]
        start_time <- map["start_time"]
        end_time <- map["end_time"]
        hosted_by <- map["hosted_by"]
        age_min <- map["age_min"]
        age_max <- map["age_max"]
        created <- map["created"]
        updated <- map["updated"]
        preferred_guest <- map["preferred_guest"]
        tickets_sold <- map["tickets_sold"]
        total_tickets <- map["tickets_sold"]
        lat <- map["lat"]
        long <- map["long"]

    }
}
