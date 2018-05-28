//
//  DatabaseProvider.swift
//  WeatherSearchExample
//
//  Created by Karapats on 23/05/ 15.
//  Copyright © 2018 Karapats. All rights reserved.
//

import Foundation
import RealmSwift
class DatabaseProvider: DataProvider {
    
    func getData<T :DecodableObject>(params: [String:Any], onSuccess: @escaping  (T) ->() , onFailure: @escaping (String) -> ()){
        let realm = try! Realm()
        if let data = realm.objects(T.self).first{
            onSuccess(data)
        }
    }
    
}
