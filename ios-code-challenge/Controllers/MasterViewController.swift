//
//  MasterViewControllerS.swift
//  ios-code-challenge
//
//  Created by Joe Rocca on 5/31/19.
//  Copyright © 2019 Dustin Lange. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {
    
    lazy private var dataSource: NXTDataSource? = {
        guard let dataSource = NXTDataSource(objects: nil) else { return nil }
        dataSource.tableViewDidReceiveData = { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.tableView.reloadData()
        }
        return dataSource
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = dataSource
        tableView.delegate = dataSource
        
        NXTLocationManager.shared.updateSearchResults = { [weak self] searchResult in
            guard let strongSelf = self,
                let dataSource = strongSelf.dataSource,
                var businesses = searchResult?.businesses else {
                    return
            }
            
            businesses.sort { Int($0.distance) ?? .zero < Int($1.distance) ?? .zero }
            dataSource.setObjects(businesses)
            dataSource.tableViewDidSelectCell = { object in
                strongSelf.performSegue(withIdentifier: "showDetail", sender: object)
            }
            
            dataSource.shouldAnimateCells = false
            strongSelf.tableView.reloadData()
        }
        
        setupSearchBar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController?.isCollapsed ?? false
        super.viewDidAppear(animated)
    }
    
    func setupSearchBar() {
        tableView.tableHeaderView = NXTSearchController.shared.searchBar
        NXTSearchController.shared.searchResultsUpdater = self
        NXTSearchController.shared.searchBar.delegate = self
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            guard let indexPath = tableView.indexPathForSelectedRow,
                let navController = segue.destination as? UINavigationController, let controller = navController.topViewController as? DetailViewController else {
                return
            }
            let business = dataSource?.objects[indexPath.row] as? YLPBusiness
            controller.setDetailItem(newDetailItem: business)
            controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem
            controller.navigationItem.leftItemsSupplementBackButton = true
        }
    }
}

// MARK: UISearchResultsUpdating
extension MasterViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard !NXTSearchController.shared.isSearchBarEmpty else { return }
        
        let filteredObjects = dataSource?.objects.filter({ object -> Bool in
            guard let business = object as? YLPBusiness, let searchText = searchController.searchBar.text?.lowercased() else { return false }
            
            return business.name.lowercased().contains(searchText) || business.priceLevel.lowercased().contains(searchText) || business.rating.lowercased().contains(searchText) || business.reviewCount.lowercased().contains(searchText) ||
                business.distance.lowercased().contains(searchText) || !business.categories.filter({ $0.title.lowercased().contains(searchText)}).isEmpty
        })
        dataSource?.setFilteredObjects(filteredObjects)

        tableView.reloadData()
    }
}

// MARK: UISearchBarDelegate
extension MasterViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        NXTSearchController.shared.isActive = false
        tableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            dataSource?.setFilteredObjects(dataSource?.objects)
            tableView.reloadData()
        }
    }
}
