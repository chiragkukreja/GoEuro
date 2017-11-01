//
//  FlightViewModel.swift
//  GoEuro
//
//  Created by Chirag Kukreja on 10/31/17.
//  Copyright © 2017 redBus. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper

class FlightViewModel: commonViewModel {

    fileprivate var flightData =  [SearchResponse]()
    fileprivate var preferredSort = SortMode.departure

    func getFlights() {
        
        Alamofire.request("https://api.myjson.com/bins/w60i").responseArray { (response: DataResponse<[SearchResponse]>) in
            
            if let value = response.result.value {
                
                print(value)
                self.flightData = value
                self.updateResultWIthPreferredSort(self.preferredSort)
                self.delegate?.searchResultGotData()
            }
            else {
                
                print("Failed srrrrryyyyy")
                self.delegate?.searchResultFailed()
            }
        }
    }
    
    func updateResultWIthPreferredSort(_ sort: SortMode) {
        preferredSort = sort
        if flightData.count > 0 {
            
            flightData = SortingManager.sort(flightData, with: preferredSort)
        }
        
    }
    
    func numberOfRows() -> Int {
        
        return flightData.count
        
    }
    
    func busDataAtIndex(_ index: Int) -> SearchResponse? {
        
        if flightData.count > 0 {
            return flightData[index]
        }
        return nil
    }
}
