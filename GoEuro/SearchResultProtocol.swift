//
//  SearchResultProtocol.swift
//  GoEuro
//
//  Created by Chirag Kukreja on 10/30/17.
//  Copyright © 2017 redBus. All rights reserved.
//

import Foundation

protocol SearchResultProtocol {
    
    func searchResultGotData()
    func searchResultFailed()
}

class commonViewModel {
    
     var delegate : SearchResultProtocol?
}
