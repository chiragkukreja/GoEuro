//
//  SortingManager.swift
//  GoEuro
//
//  Created by Chirag Kukreja on 10/31/17.
//  Copyright © 2017 redBus. All rights reserved.
//

import UIKit

class SortingManager: NSObject {

    static func sortByDepartureTime(_ data: [SearchResponse]) -> [SearchResponse] {
        
        let sortedArray = data.sorted { $0.departureTime  < $1.departureTime}
        
        return sortedArray
    }
    
    static func sortByArrivalTime(_ data: [SearchResponse]) -> [SearchResponse] {
        
        let sortedArray = data.sorted { $0.arrivalTime  < $1.arrivalTime}
        
        return sortedArray
    }
    
    static func sortByDuration(_ data: [SearchResponse]) -> [SearchResponse] {
        
        let sortedArray = data.sorted { $0.durationgInSortingFormat()  < $1.durationgInSortingFormat()}
        
        return sortedArray
    }
    
    static func sort(_ data : [SearchResponse], with mode: SortMode) -> [SearchResponse]  {
        
        switch mode {
        case .departure:
            return sortByDepartureTime(data)
        case  .arrival :
            return sortByArrivalTime(data)
        case .duration :
            return sortByDuration(data)
        }
    }
}
