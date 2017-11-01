//
//  ViewController.swift
//  GoEuro
//
//  Created by Chirag Kukreja on 10/30/17.
//  Copyright © 2017 redBus. All rights reserved.
//

import UIKit

enum SearchMode : Int {
    case train = 0
    case bus = 1
    case flight = 2
}

enum SortMode: Int {
    
    case departure = 0
    case arrival = 1
    case duration = 2
}

protocol searchResultDelegate {
    
    func searchResultChangedMode(to: SearchMode)
}

class ViewController: UIViewController{
    
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var containerView        : UIView!
    fileprivate var searchMode                      = SearchMode.train
    fileprivate var busVC           : BusVC!
    fileprivate var trainVC         : TrainVC!
    fileprivate var flightVC        : FlightVC!
    fileprivate var pageViewController  : UIPageViewController!
    fileprivate var sortMode  = SortMode.departure;
    @IBOutlet weak var sortControl: UISegmentedControl!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupPagesWithInitialViewController(initialViewController())
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func segmentControlChanged(_ sender: Any) {
        
        updateViewWithMode(segmentControl.selectedSegmentIndex)
    }
    
    @IBAction func sortingChanged(_ sender: Any) {
        
        sortMode = SortMode(rawValue : sortControl.selectedSegmentIndex)!
        if let vc = pageViewController.viewControllers?.last {
            
            if let v = vc as? TrainVC {
                
                v.updateResult(sortMode)
            }
            else if let v = vc as? BusVC {
                
                v.updateResult(sortMode)
            }
            else if let v = vc as? FlightVC {
                
                v.updateResult(sortMode)
            }
        }

    }
    
    fileprivate func updateViewWithMode(_ index: Int) {
        
        let mode =  SearchMode(rawValue : index)
        if searchMode == mode  {return}
        
        let direction : UIPageViewControllerNavigationDirection = searchMode.rawValue > index ? .reverse : .forward
        
        searchMode = mode!
        let vc = initialViewController()
        
        pageViewController.setViewControllers([vc], direction: direction, animated: true, completion: nil)
    }
    
    fileprivate func initialViewController() -> UIViewController {
        
        switch self.searchMode {
            
        case .train:
            
            return self.trainViewController()
            
        case .bus:
            
            return self.busViewController()
            
        case .flight:
            
            return self.flightViewController()
            
        }
    }
    
    fileprivate func trainViewController() -> UIViewController {
    
        if trainVC != nil {
            trainVC.setPreferredSortMode(sortMode)
            return trainVC
        }
        
         trainVC = TrainVC()
        trainVC.setPreferredSortMode(sortMode)

        return trainVC
    
    }
    
    fileprivate func busViewController() -> UIViewController {
        if busVC != nil {
            busVC.setPreferredSortMode(sortMode)
            return busVC
        }
        busVC = BusVC()
        busVC.setPreferredSortMode(sortMode)

        return busVC
        
    }
    
    fileprivate func flightViewController() -> UIViewController  {
        
        if flightVC != nil {
            flightVC.setPreferredSortMode(sortMode)
            return flightVC
        }
        flightVC = FlightVC()
        flightVC.setPreferredSortMode(sortMode)

        return flightVC
        
    }
    fileprivate func setupPagesWithInitialViewController (_ initialViewController: UIViewController) {
        
        let pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        
        pageViewController.setViewControllers([initialViewController], direction: .forward, animated: false, completion: nil)
        
        self.addChildViewController(pageViewController)
        
        let pageView = pageViewController.view!
        
        pageView.translatesAutoresizingMaskIntoConstraints = false
        self.containerView.addSubview(pageView)
        
        let margins =  containerView.layoutMarginsGuide
        
        pageView.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
        pageView.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
        pageView.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
        pageView.bottomAnchor.constraint(equalTo: margins.bottomAnchor).isActive = true

        pageViewController.didMove(toParentViewController: self)
        self.pageViewController = pageViewController
    }
}

