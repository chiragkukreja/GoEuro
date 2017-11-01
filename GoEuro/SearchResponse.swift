//
//  SearchResponse.swift
//  GoEuro
//
//  Created by Chirag Kukreja on 10/30/17.
//  Copyright © 2017 redBus. All rights reserved.
//

import UIKit
import ObjectMapper


@objc class SearchResponse: NSObject, Mappable {
    
    @objc var id   = 0
    @objc var price = 0.0
    @objc var logo = ""
    @objc var departureTime = ""
    @objc var arrivalTime = ""
    @objc var stops = 0

    required init?(map:Map) {
        
    }
    
    func mapping(map: Map) {
        
        id                  <- map["id"]
        price               <- map["price_in_euros"]
        logo                <- map["provider_logo"]
        departureTime       <- map["departure_time"]
        arrivalTime         <- map["arrival_time"]
        stops               <- map["number_of_stops"]
    }
    
    @objc func duration() -> String {
        
        let format = DateFormatter()
        format.dateFormat = "HH:mm"
        let date1 = format.date(from: departureTime)
        let date2 = format.date(from: arrivalTime)
        
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .abbreviated
        let string = formatter.string(from: date1!, to: date2!)
        return string!
    }
    
    func durationgInSortingFormat()-> TimeInterval {
        
        let format = DateFormatter()
        format.dateFormat = "HH:mm"
        let date1 = format.date(from: departureTime)
        let date2 = format.date(from: arrivalTime)
        
        let sec = date2?.timeIntervalSince(date1!)
        return sec!
    }
}
