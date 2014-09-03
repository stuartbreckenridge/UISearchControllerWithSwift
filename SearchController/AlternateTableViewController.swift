//
//  AlternateTableViewController.swift
//  SearchController
//
//  Created by Stuart Breckenridge on 2/9/14.
//  Copyright (c) 2014 Stuart Breckenridge. All rights reserved.
//

import UIKit

class AlternateTableViewController: UITableViewController, UISearchResultsUpdating {

    let viewController = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle()).instantiateViewControllerWithIdentifier("NormalViewController") as ViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewController.searchArray.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("LargeCell", forIndexPath: indexPath) as AlternateTableViewCell

        cell.configureCell(viewController.searchArray[indexPath.row])

        return cell
    }
    

    func updateSearchResultsForSearchController(searchController: UISearchController)
    {
        viewController.searchArray.removeAll(keepCapacity: false)
        
        for country:String in viewController.countryArray
        {
            var searchText = searchController.searchBar.text
            
            if NSString(string: country.lowercaseString).containsString(searchText.lowercaseString)
            {
                viewController.searchArray.append(country)
            }
        }
        
        self.tableView.reloadData()
    }
}
