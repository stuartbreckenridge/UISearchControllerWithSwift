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
            return Countries.list.count
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = countryTable.dequeueReusableCellWithIdentifier("Cell") as! SearchTableViewCell
        cell.textLabel?.text = ""
        cell.textLabel?.attributedText = NSAttributedString(string: "")
        
        switch countrySearchController.active {
        case true:
            cell.configureCellWith(searchTerm:countrySearchController.searchBar.text!, cellText: searchArray[indexPath.row])
            return cell
        case false:
            cell.textLabel?.text! = Countries.list[indexPath.row]
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
     
        let range = searchController.searchBar.text!.characters.startIndex ..< searchController.searchBar.text!.characters.endIndex
        var searchString = String()
        
        searchController.searchBar.text?.enumerateSubstringsInRange(range, options: .ByComposedCharacterSequences, { (substring, substringRange, enclosingRange, success) in
            searchString.appendContentsOf(substring!)
            searchString.appendContentsOf("*")
        })
        
        let searchPredicate = NSPredicate(format: "SELF LIKE[cd] %@", searchString)
        let array = (Countries.list as NSArray).filteredArrayUsingPredicate(searchPredicate)
        searchArray = array as! [String]
        countryTable.reloadData()
    }
}