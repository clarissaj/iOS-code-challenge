//
//  NXTDataSource+SkeletonView.swift
//  ios-code-challenge
//
//  Created by Clarissa Jawaid on 2/13/20.
//  Copyright © 2020 Dustin Lange. All rights reserved.
//

import SkeletonView

extension NXTDataSource: SkeletonTableViewDataSource {
    @objc func showSkeletonCell(cell: NXTBusinessTableViewCell) {
        cell.showAnimatedGradientSkeleton()
    }
    
    @objc func hideSkeletonCell(cell: NXTBusinessTableViewCell) {
        cell.hideSkeleton()
    }
    
    public func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return NXTBusinessTableViewCell.reuseIdentifier
    }
}
