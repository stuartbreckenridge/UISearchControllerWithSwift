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
        if (self.countrySearchController.active)
        {
            return self.searchArray.count
        } else
        {
            return self.countryArray.count
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        var cell = self.countryTable.dequeueReusableCellWithIdentifier("Cell") as UITableViewCell
        
        if (self.countrySearchController.active)
        {
            cell.textLabel?.text! = self.searchArray[indexPath.row]
            return cell
        }
        
        else
        {
            cell.textLabel?.text! = self.countryArray[indexPath.row]
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
        self.searchArray.removeAll(keepCapacity: false)
     
        for country:String in self.countryArray
        {
            var searchText = searchController.searchBar.text
            
            if NSString(string: country.lowercaseString).containsString(searchText.lowercaseString)
            {
                searchArray.append(country)
            }
        }
        
        self.countryTable.reloadData()
    }
}