//
//  LocationUtils.swift
//  WeatherSearchExample
//
//  Created by Karapats on 27/05/ 15.
//  Copyright © 2018 Karapats. All rights reserved.
//

import Foundation
import CoreLocation
final class LocationUtils{
    func getDataCity(tmpLat:Double,tmpLong:Double, completion: @escaping (String) -> Void) {
        
        let tmpCLGeocoder = CLGeocoder.init()
        if tmpLat > 0 , tmpLong > 0
        {
            let tmpDataLoc = CLLocation.init(latitude: tmpLat, longitude: tmpLong)
            
            tmpCLGeocoder.reverseGeocodeLocation(tmpDataLoc, completionHandler: {(placemarks,error) in
                
                guard let tmpPlacemarks = placemarks else{
                    return
                }
                let placeMark = tmpPlacemarks[0] as CLPlacemark
                
                guard let strLocality = placeMark.locality else{
                    return
                }
                completion(strLocality)
                // strLocality is your city
                guard let strSubLocality = placeMark.subLocality else{
                    
                    return
                }
                
                // strSubLocality is your are of city
            })
            
        }
        
    }
}
