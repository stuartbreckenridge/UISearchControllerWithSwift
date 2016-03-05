//
//  ViewControllerExtensions.swift
//  SearchController
//
//  Created by Stuart Breckenridge on 17/8/14.
//  Copyright (c) 2014 Stuart Breckenridge. All rights reserved.
//

import Foundation
import UIKit

extension ViewController: UITableViewDataSource
{
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        switch countrySearchController.active {
        case true:
            return searchArray.count
        case false:
            return countryArray.count
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = countryTable.dequeueReusableCellWithIdentifier("Cell")!
        
        switch countrySearchController.active {
        case true:
            cell.textLabel?.text! = searchArray[indexPath.row]
            return cell
        case false:
            cell.textLabel?.text! = countryArray[indexPath.row]
            return cell
        }
    }
}

extension ViewController: UITableViewDelegate
{
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}

extension ViewController: UISearchResultsUpdating
{
    func updateSearchResultsForSearchController(searchController: UISearchController)
    {
        searchArray.removeAll(keepCapacity: false)
     
        let searchPredicate = NSPredicate(format: "SELF CONTAINS[c] %@", searchController.searchBar.text!)
        let array = (countryArray as NSArray).filteredArrayUsingPredicate(searchPredicate)
        searchArray = array as! [String]
    }
}