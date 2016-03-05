# UISearchController
[![Build Status](https://travis-ci.org/stuartbreckenridge/UISearchControllerWithSwift.svg?branch=master)](https://travis-ci.org/stuartbreckenridge/UISearchControllerWithSwift)

This is a small demonstation of the new `UISearchController` API. 

There is one class: `ViewController.swift`, and its extension file, `ViewControllerExtensions.swift`.

### ViewController.swift
This class sets up a sample `Array` of different countries (`countryArray`), an `Array` for holding search results (`searchArray`), and finally a `UISearchController` called `countrySearchController`.

The `countrySearchController` is configured during initialisation:

`let controller = UISearchController(searchResultsController: nil)`

>*nil* is passed as the argument in the method parameter as it has the effect of presenting the search results in the current view.

`var countrySearchController: UISearchController = ({
    let controller = UISearchController(searchResultsController: nil)
    controller.hidesNavigationBarDuringPresentation = false
    controller.dimsBackgroundDuringPresentation = false
    controller.searchBar.searchBarStyle = .Minimal
    controller.searchBar.sizeToFit()
    return controller
})()`


In `viewDidLoad`, `countrySearchController.searchBar` is  set as the tableHeaderView and the `countrySearchController.searchResultsUpdater` is set to the current ViewController. The ViewController is responsible for updating the contents of search controller. This means that the ViewController must conform to the new `UISearchResultsUpdating` protocol. 
 

There is no need to add a search bar in Interface Builder.

### ViewControllerExtensions.swift
The important protocol included in the extension file is `UISearchResultsUpdating`.

When the `updateSearchResultsForSearchController` function is called:
- `searchArray` is cleared
- a search of `countryArray` is performed based on `searchController.searchBar.text`
- any matches are added to `searchArray`
- `countryTable` is reloaded

In `cellForRowAtIndexPath`, the `countryTable` is populated based on whether or not the `searchController` is active. 

---

An alternate setup is included that allows you to use a separate view controller to present search results:

A standalone tableViewController is created in Storyboard and then instantiated as part of the `UISearchController` setup.

`let alternateController:AlternateTableViewController = storyBoard.instantiateViewControllerWithIdentifier("aTV") as! AlternateTableViewController`
`let controller = UISearchController(searchResultsController: alternateController)`

`AlternateTableViewController` conforms to `UISearchResultsUpdating` and is responsible for displaying search results from the original view controller's search results array.

---

####05th March 2016

- Updated to support Swift 2.3 beta (Xcode >= 7.3)


####23rd Feb 2015

- Updated to support Swift 1.2 beta 1 (requires Xcode 6.3 beta 1).
- Larger selection of countries to search. 
- Housekeeping. 
 
 
####27th March 2015
 
- Updated to support Swift 1.2 beta 3 (requires Xcode 6.3 beta 3).
- Switched to didSet syntax when updating the searchResults tableview:
 
 `var searchArray:[String] = [String](){
 didSet  {countryTable.reloadData()}
 }`
 
####16th April 2015
- Swift 1.2 support.
 
 
####17th Jan 2016
 - Swift 2.1 support.
 
    