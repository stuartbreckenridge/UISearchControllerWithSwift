# UISearchController
![](https://img.shields.io/badge/Swift-4.2-%23FD3C33.svg "Swift Version")

This is a small demonstration of the  `UISearchController` API. 

### Countries.swift
This file contains an array of countries.

To access the array of countries anywhere in the app, you use `countries`.

### ViewController.swift
This class sets up a `UISearchController` called `countrySearchController`. The `countrySearchController` is configured during initialisation:

> *nil* is passed as the argument in the method parameter as it has the effect of presenting the search results in the current view.


```swift 
lazy var countrySearchController: UISearchController = ({
    /*
        Display search results in a separate view controller
    let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
    let alternateController = storyBoard.instantiateViewController(withIdentifier: "aTV") as! AlternateTableViewController
    let controller = UISearchController(searchResultsController: alternateController)
    */
    let controller = UISearchController(searchResultsController: nil)
    controller.hidesNavigationBarDuringPresentation = false
    controller.dimsBackgroundDuringPresentation = false
    controller.searchBar.searchBarStyle = .minimal
    controller.searchResultsUpdater = self
    controller.searchBar.sizeToFit()
    return controller
})()
```


In `viewDidLoad`, the `countrySearchController` is set as the `navigationItem.searchController` property. In addition, to make sure that the search bar is always visible, `navigationItem.hidesSearchBarWhenScrolling` is set to `false`.


`ViewController` conforms to the  `UISearchResultsUpdating` protocol.

When the `updateSearchResultsForSearchController` function is called:
- `searchArray` is emptied
- a new `searchString` is created based on the searchBar text, which takes the form of `S*E*A*R*C*H*T*E*X*T*`
- a search of `countries` is performed based on `searchController.searchBar.text`
- any matches are added to `searchArray`
- `countryTable` is reloaded

In `cellForRowAtIndexPath`, the `countryTable` is populated based on whether or not the `searchController` is active. If the `searchController` is active, the cell is configured by calling 
`cell.configureCellWith(searchTerm: String, cellText: String)`. 


### SearchTableViewCell.swift
`cell.configureCellWith(searchTerm:String, cellText: String)` will configure the cell to highlight matched search terms using a basic regular expression.

---

An alternate setup is included that allows you to use a separate view controller to present search results:

A standalone tableViewController is created in Storyboard and then instantiated as part of the `UISearchController` setup.


```swift
lazy var countrySearchController: UISearchController = ({
    // Display search results in a separate view controller
    let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
    let alternateController = storyBoard.instantiateViewController(withIdentifier: "aTV") as! AlternateTableViewController
    let controller = UISearchController(searchResultsController: alternateController)

    //let controller = UISearchController(searchResultsController: nil) 
    controller.hidesNavigationBarDuringPresentation = false
    controller.dimsBackgroundDuringPresentation = false
    controller.searchBar.searchBarStyle = .minimal
    controller.searchResultsUpdater = self
    controller.searchBar.sizeToFit()
    return controller
})()
```

`AlternateTableViewController` subscribes to `Notification`s. When the user enters search a search term, the search results are updated and posted through Notification Center and observed via a `didSet`:

```
var searchArray = [String]() {
    didSet {
        NotificationCenter.default.post(name: NSNotification.Name.init("searchResultsUpdated"), object: searchArray)
    }
}
```


