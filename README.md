# UISearchController
![](https://img.shields.io/badge/Swift-3-%23FD3C33.svg "Swift Version")

This is a small demonstration of the new `UISearchController` API. 

### Countries.swift
This file contains a public enum—`Countries`. `Countries` has one static constant—`list`—which is an array of most countries in the world.

To access the array of countries anywhere in the app, you use `Countries.list`.

For more information on case-less enums, have a look at [this post](https://www.natashatherobot.com/swift-enum-no-cases/ "Natasha the Robot") on Natasha the Robot.

### ViewController.swift
This class sets up a `UISearchController` called `countrySearchController`. The `countrySearchController` is configured during initialisation:

> *nil* is passed as the argument in the method parameter as it has the effect of presenting the search results in the current view.

        var countrySearchController: UISearchController = (
            let controller = UISearchController(searchResultsController: nil)
            controller.hidesNavigationBarDuringPresentation = false
            controller.dimsBackgroundDuringPresentation = false
            controller.searchBar.searchBarStyle = .Minimal
            controller.searchBar.sizeToFit()
            return controller
        })()


In `viewDidLoad`, `countrySearchController.searchBar` is  set as the tableHeaderView and the `countrySearchController.searchResultsUpdater` is set to the current ViewController. The ViewController is responsible for updating the contents of search controller. This means that the ViewController must conform to the new `UISearchResultsUpdating` protocol. 

There is no need to add a search bar in Interface Builder.

`ViewController` conforms to `UISearchResultsUpdating`.

When the `updateSearchResultsForSearchController` function is called:
- `searchArray` is cleared
- a new `searchString` is created based on the searchBar text, which takes the form of `S*E*A*R*C*H*T*E*X*T*`
- a search of `countryArray` is performed based on `searchController.searchBar.text`
- any matches are added to `searchArray`
- `countryTable` is reloaded

In `cellForRowAtIndexPath`, the `countryTable` is populated based on whether or not the `searchController` is active. If the `searchController` is active, the cell is configured by calling 
`cell.configureCellWith(searchTerm: String, cellText: String)`. 


### SearchTableViewCell.swift
`cell.configureCellWith(searchTerm:String, cellText: String)` will configure the cell to highlight matched search terms using a basic regular expression.

---

An alternate setup is included that allows you to use a separate view controller to present search results:

A standalone tableViewController is created in Storyboard and then instantiated as part of the `UISearchController` setup.

let alternateController:AlternateTableViewController = storyBoard.instantiateViewControllerWithIdentifier("aTV") as! AlternateTableViewController
let controller = UISearchController(searchResultsController: alternateController)

`AlternateTableViewController` subscribes to `Notification`s. When the user enters search a search term, the search results are updated and posted through Notification Center via a `didSet`:

```
var searchArray = [String]() {
    didSet {
        NotificationCenter.default.post(name: NSNotification.Name.init("searchResultsUpdated"), object: searchArray)
    }
}
```


