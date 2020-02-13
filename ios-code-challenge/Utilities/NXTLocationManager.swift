//
//  NXTLocationManager.swift
//  ios-code-challenge
//
//  Created by Clarissa Jawaid on 2/12/20.
//  Copyright © 2020 Dustin Lange. All rights reserved.
//

import CoreLocation

class NXTLocationManager: NSObject {
    static let shared = NXTLocationManager()
    
    private var locationManager = CLLocationManager()
    var updateSearchResults: ((_ searchResult: YLPSearch?) -> Void)?
    
    override init() {
        super.init()
        locationManager.delegate = self
        requestLocationPermission()
    }
    
    func getUserLocation() -> CLLocation? {
        return locationManager.location
    }
    
    func requestLocationPermission() {
        locationManager.requestWhenInUseAuthorization()
    }
}

// MARK: CLLocationManagerDelegate

extension NXTLocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.startUpdatingLocation()
        default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationManager.stopUpdatingLocation()
        let query = YLPSearchQuery(coordinates: NXTLocationManager.shared.getUserLocation())
        AFYelpAPIClient.shared().search(with: query, completionHandler: { [weak self] searchResult, error in
            self?.updateSearchResults?(searchResult)
        })
    }
}
