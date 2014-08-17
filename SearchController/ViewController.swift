//
//  ViewController.swift
//  SearchController
//
//  Created by Stuart Breckenridge on 17/8/14.
//  Copyright (c) 2014 Stuart Breckenridge. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var countryTable: UITableView!
    var countryArray = ["Australia", "Singapore", "Malaysia", "United States", "Germany", "United Kingdom", "Kenya"]
    var searchArray = [String]()
    var countrySearchController = UISearchController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configure countryTable
        self.countryTable.delegate = self
        self.countryTable.dataSource = self
        
        // Configure countrySearchController
        self.countrySearchController = ({
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self
            //FIXME: Hiding the navigationBar places the first search result out of sight, so it's kept in view here.
            controller.hidesNavigationBarDuringPresentation = false
            controller.dimsBackgroundDuringPresentation = false

            controller.searchBar.frame = CGRectMake(0.0, 0.0, CGRectGetWidth(self.countryTable.frame), 44.0)
            self.countryTable.tableHeaderView = controller.searchBar
            
            return controller
        })()
    }
    
    override func viewDidAppear(animated: Bool) {
        self.countryTable.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

