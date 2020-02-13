//
//  NXTSearchController.swift
//  ios-code-challenge
//
//  Created by Clarissa Jawaid on 2/13/20.
//  Copyright © 2020 Dustin Lange. All rights reserved.
//

import UIKit

@objc class NXTSearchController: UISearchController {
    @objc static let shared = NXTSearchController(searchResultsController: nil)
    
    var isSearchBarEmpty: Bool {
      return searchBar.text?.isEmpty ?? true
    }
    
    override init(searchResultsController: UIViewController?) {
        super.init(searchResultsController: searchResultsController)
        dimsBackgroundDuringPresentation = false
        searchBar.sizeToFit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
