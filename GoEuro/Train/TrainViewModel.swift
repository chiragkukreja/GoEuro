//
//  TrainViewModel.swift
//  GoEuro
//
//  Created by Chirag Kukreja on 10/31/17.
//  Copyright © 2017 redBus. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper

class TrainViewModel: commonViewModel {

    fileprivate var trainData =  [SearchResponse]()
    fileprivate var preferredSort = SortMode.departure
    func getTrains() {
        
        Alamofire.request("https://api.myjson.com/bins/3zmcy").responseArray { (response: DataResponse<[SearchResponse]>) in
            
            if let value = response.result.value {
                
                print(value)
                
                self.trainData = value
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
        if trainData.count > 0 {
            
            trainData = SortingManager.sort(trainData, with: preferredSort)
        }
        
    }
    func numberOfRows() -> Int {
        
        return trainData.count
    }
    
    func busDataAtIndex(_ index: Int) -> SearchResponse? {
        
        if trainData.count > 0 {
            
            return trainData[index]
        }
        return nil
    }
}
