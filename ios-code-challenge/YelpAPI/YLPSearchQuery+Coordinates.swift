//
//  YLPSearchQuery+Coordinates.swift
//  ios-code-challenge
//
//  Created by Clarissa Jawaid on 2/12/20.
//  Copyright © 2020 Dustin Lange. All rights reserved.
//

import CoreLocation

extension YLPSearchQuery {
    
    public convenience init(coordinates: CLLocation?) {
        self.init()
        if let coordinates = coordinates {
            self.coordinates = coordinates
        }
    }
}
