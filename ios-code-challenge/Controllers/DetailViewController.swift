//
//  DetailViewController.swift
//  ios-code-challenge
//
//  Created by Joe Rocca on 5/31/19.
//  Copyright © 2019 Dustin Lange. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet var containerView: UIView!
    @IBOutlet var detailPhotoImageView: UIImageView!
    @IBOutlet var detailPriceLevelLabel: UILabel!
    @IBOutlet var detailCategoriesLabel: UILabel!
    @IBOutlet var detailReviewCountLabel: UILabel!
    @IBOutlet var detailRatingLabel: UILabel!
    @IBOutlet var defaultLabel: UILabel!
    
    lazy private var favoriteBarButtonItem: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "Star-Outline"), style: .plain, target: self, action: #selector(onFavoriteBarButtonSelected(_:)))

    @objc var detailItem: YLPBusiness?
    
    private var _favorite: Bool = false
    private var isFavorite: Bool {
        get {
            return _favorite
        } 
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        navigationItem.rightBarButtonItems = [favoriteBarButtonItem]
    }
    
    private func configureView() {
        guard let detailItem = detailItem else { return }
        loadViewIfNeeded()
        showDetailViews()
        navigationItem.title = detailItem.name
        detailPhotoImageView.image = detailItem.image
        detailPriceLevelLabel.text = "Price: " + detailItem.priceLevel
        detailCategoriesLabel.text = "Categories: " + detailItem.getCategoriesAsString()
        detailReviewCountLabel.text = "Reviews: " + detailItem.reviewCount
        detailRatingLabel.text = "Rating: " + detailItem.rating
    }
    
    func setDetailItem(newDetailItem: YLPBusiness?) {
        guard detailItem != newDetailItem, let newDetailItem = newDetailItem else { return }
        detailItem = newDetailItem
        configureView()
    }
    
    private func updateFavoriteBarButtonState() {
        favoriteBarButtonItem.image = isFavorite ? UIImage(named: "Star-Filled") : UIImage(named: "Star-Outline")
    }
    
    @objc private func onFavoriteBarButtonSelected(_ sender: Any) {
        _favorite.toggle()
        updateFavoriteBarButtonState()
    }
    
    func showDetailViews() {
        detailPhotoImageView.isHidden = false
        detailPriceLevelLabel.isHidden = false
        detailCategoriesLabel.isHidden = false
        detailRatingLabel.isHidden = false
        detailReviewCountLabel.isHidden = false
        defaultLabel.isHidden = true
    }
}
