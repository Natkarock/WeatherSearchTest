//
//  DataManager.swift
//  WeatherSearchExample
//
//  Created by Karapats on 23/05/ 15.
//  Copyright © 2018 Karapats. All rights reserved.
//

import Foundation
import RealmSwift

final class DataManager<ReturnModel : Object&Decodable>  {
    
    func getForecast<ReturnModel: Object&Decodable>(params: [String:Any],onSuccess: @escaping (ReturnModel) -> Void,  onFailure: @escaping (String) -> Void){
        dataProvider().getData(params:params, onSuccess: onSuccess, onFailure: onFailure)
    }
    
    private func dataProvider() -> DataProvider {
        return NetworkProvider()
    }
}
