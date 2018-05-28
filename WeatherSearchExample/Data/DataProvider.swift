//
//  DataProvider.swift
//  WeatherSearchExample
//
//  Created by Karapats on 23/05/ 15.
//  Copyright © 2018 Karapats. All rights reserved.
//

import Foundation
import RealmSwift
protocol DataProvider {
    typealias DecodableObject = Object & Decodable
    func getData<T :DecodableObject>(params: [String:Any], onSuccess: @escaping  (T) ->() , onFailure: @escaping (String) -> ())
}
