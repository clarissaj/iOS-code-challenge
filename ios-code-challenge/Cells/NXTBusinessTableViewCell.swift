//
//  NXTBusinessTableViewCell.swift
//  ios-code-challenge
//
//  Created by Clarissa Jawaid on 2/11/20.
//  Copyright © 2020 Dustin Lange. All rights reserved.
//

@objc(NXTBusinessTableViewCell)
class NXTBusinessTableViewCell: UITableViewCell {
    
    @IBOutlet var thumbnailImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var categoriesLabel: UILabel!
    @IBOutlet var ratingLabel: UILabel!
    @IBOutlet var reviewCountLabel: UILabel!
    @IBOutlet var distanceLabel: UILabel!
    
    func configureCell(business: YLPBusiness) {
        nameLabel.text = business.name
        categoriesLabel.text = business.getCategoriesAsString()
        ratingLabel.text = "Rating: " + business.rating
        reviewCountLabel.text = "Reviews: " + business.reviewCount
        distanceLabel.text = "Distance: \(business.distance) m"
        thumbnailImageView.image = business.image
    }
}

// MARK: NXTBindingDataForObjectDelegate

extension NXTBusinessTableViewCell: NXTBindingDataForObjectDelegate {
    
    func bindingData(for object: Any) {
        guard let object = object as? YLPBusiness else { return }
        configureCell(business: object)
    }
}
