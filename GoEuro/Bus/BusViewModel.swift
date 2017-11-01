//
//  BusViewModel.swift
//  GoEuro
//
//  Created by Chirag Kukreja on 10/30/17.
//  Copyright © 2017 redBus. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper


class BusViewModel: commonViewModel {

    fileprivate var busData =  [SearchResponse]()
    fileprivate var preferredSort = SortMode.departure

    func getBuses() {
        
        Alamofire.request("https://api.myjson.com/bins/37yzm").responseArray { (response: DataResponse<[SearchResponse]>) in
            
            if let value = response.result.value {
                
                print(value)
                self.busData = value
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
        if busData.count > 0 {
            
            busData = SortingManager.sort(busData, with: preferredSort)
        }
    }
    
    func numberOfRows() -> Int {
        
            return busData.count

    }
    
    func busDataAtIndex(_ index: Int) -> SearchResponse? {
        
        if busData.count > 0 {
            
            return busData[index]
        }
        return nil
    }
}
