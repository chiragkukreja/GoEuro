//
//  TrainVC.swift
//  GoEuro
//
//  Created by Chirag Kukreja on 10/30/17.
//  Copyright © 2017 redBus. All rights reserved.
//

import UIKit

class TrainVC: UIViewController {
    
    fileprivate var preferredSort = SortMode.departure
    fileprivate var trainViewModel =  TrainViewModel()
    fileprivate var  trainTableView : UITableView!
    fileprivate var activityIndicator : UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        trainViewModel.delegate = self
        let tableView = UITableView.init(frame: CGRect.zero, style: .plain)
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
        
        trainTableView = tableView
        
        activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        activityIndicator.center = view.center
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        trainViewModel.getTrains()
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
        
        trainViewModel.updateResultWIthPreferredSort(preferredSort)
        trainTableView.reloadData()
    }
}

extension TrainVC : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return trainViewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? SearchResultCell
        if let data = trainViewModel.busDataAtIndex(indexPath.row) {
            
            cell?.showData(data)
        }
        return cell!
    }
}

extension TrainVC : SearchResultProtocol {
    
    func searchResultGotData() {
        
        activityIndicator.stopAnimating()
        trainTableView.reloadData()
        
    }
    
    func searchResultFailed() {
        
        //show error view
    }
}
