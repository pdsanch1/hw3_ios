//
//  BusinessesViewController.swift
//  Yelp
//
//  Created by Timothy Lee on 4/23/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

class BusinessesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchResultsUpdating, UISearchBarDelegate {

    
    
    
    var businesses: [Business]!
    
    var isActive : Bool = false

    var filtered: [Business] = []
    
    var index = 0
    
    let searchController = UISearchController(searchResultsController: nil)
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        //tableView.rowHeight = 110
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
        
        
        searchController.searchResultsUpdater=self
        searchController.delegate = self as? UISearchControllerDelegate
        searchController.dimsBackgroundDuringPresentation=true
        searchController.searchBar.sizeToFit()
        searchController.searchBar.showsCancelButton = true
        searchController.searchBar.delegate = self

        searchController.searchBar.placeholder = "Search Restaurant(s) Name"

        searchController.searchBar.becomeFirstResponder()
        
        tableView.tableHeaderView  = searchController.searchBar
       
        definesPresentationContext=true

        //tableView.rowHeight = 110
        //tableView.rowHeight = UITableViewAutomaticDimension
        //tableView.estimatedRowHeight = 120
        
        Business.searchWithTerm(term: "Thai", completion: { (businesses: [Business]?, error: Error?) -> Void in
            
                self.businesses = businesses
                self.tableView.reloadData()
            
                if let businesses = businesses {
                    for business in businesses {
                        print(business.name!)
                        //print(business.address!)
                    }
                }
            
            }
        )
        
        /* Example of Yelp search with more search options specified
         Business.searchWithTerm(term: "Restaurants", sort: .distance, categories: ["asianfusion", "burgers"]) { (businesses, error) in
                self.businesses = businesses
                 for business in self.businesses {
                     print(business.name!)
                     print(business.address!)
                 }
         }
         */
        
    }
    
    func  searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.showsCancelButton = false
        self.dismiss(animated: true, completion: nil)
        isActive = false
        tableView.reloadData()
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if isActive {
            if filtered.count == 0 && searchController.searchBar.text == "" {
                isActive = false
                return self.businesses.count
            } else {
                return filtered.count }
        } else {
            if self.businesses != nil {
                return self.businesses!.count
            }
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var business: Business
 
        if isActive {
            business = filtered[indexPath.row]
        } else {
            business = businesses[indexPath.row]
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "BusinessCell", for: indexPath) as! BusinessCell
        
        cell.index = indexPath.row as Int
        
        cell.business = business
        
        
        return cell
    }
    
    
    
    func filtersViewController(filtersViewController: FiltersViewController, didUpdateFilters filters: [String : AnyObject]) {
        
        let categories = filters["categories"] as? [String]
        
        Business.searchWithTerm(term: "Restaurants", sort: nil, categories: categories) { (businesses, error) in
            self.businesses = businesses
            for business in self.businesses {
                print(business.name!)
                print(business.address!)
            }
        }
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        
        let searchString = searchController.searchBar.text
        print(businesses.count)
        filtered = businesses.filter() { (business) -> Bool in
            let businessNameLabel: NSString = business.name! as NSString
            
            return (businessNameLabel.range(of: searchString!, options: NSString.CompareOptions.caseInsensitive).location) != NSNotFound
        }
            print(filtered.count)
            isActive = true
            tableView.reloadData()
    }
    
    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
        if !isActive {
            isActive = true
            tableView.reloadData()
        }
        
        searchController.searchBar.resignFirstResponder()
    }
    
    
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        isActive = true
        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        isActive = false
        tableView.reloadData()
    }

}
