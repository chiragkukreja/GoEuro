//
//  BusVC.swift
//  GoEuro
//
//  Created by Chirag Kukreja on 10/30/17.
//  Copyright © 2017 redBus. All rights reserved.
//

import UIKit

class BusVC: UIViewController {
    
    fileprivate var preferredSort = SortMode.departure

    fileprivate var busViewModel =  BusViewModel()
    fileprivate var  busTableView :UITableView!
    fileprivate var activityIndicator : UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()

        busViewModel.delegate = self
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        let margins =  view.layoutMarginsGuide
        
        tableView.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: margins.bottomAnchor).isActive = true
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "SearchResultCell",bundle: nil), forCellReuseIdentifier: "cell")
        
        busTableView = tableView
        
        activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        activityIndicator.center = view.center
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        busViewModel.getBuses()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateResult(_ mode : SortMode){
        preferredSort = mode
        updataAndReload()
    }
    
    func setPreferredSortMode(_ mode: SortMode){
        
        preferredSort = mode
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        updataAndReload()
    }
    
    fileprivate func updataAndReload() {
        
        busViewModel.updateResultWIthPreferredSort(preferredSort)
        busTableView.reloadData()
    }
}

extension BusVC : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
       return busViewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? SearchResultCell
        if let data = busViewModel.busDataAtIndex(indexPath.row) {
            
            cell?.showData(data)
        }
        return cell!
    }
}

extension BusVC : SearchResultProtocol {
    
    func searchResultGotData() {
        
        activityIndicator.stopAnimating()
        busTableView.reloadData()
        
    }
    
    func searchResultFailed() {
        
        //show error view
    }
}
