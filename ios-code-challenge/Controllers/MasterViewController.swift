//
//  MasterViewControllerS.swift
//  ios-code-challenge
//
//  Created by Joe Rocca on 5/31/19.
//  Copyright © 2019 Dustin Lange. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {
    
    var detailViewController: DetailViewController?
    
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
            
            strongSelf.tableView.reloadData()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController?.isCollapsed ?? false
        super.viewDidAppear(animated)
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
