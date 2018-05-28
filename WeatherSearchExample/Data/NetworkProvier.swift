//
//  NetworkProvier.swift
//  WeatherSearchExample
//
//  Created by Karapats on 23/05/ 15.
//  Copyright © 2018 Karapats. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import RealmSwift

class NetworkProvider: DataProvider {
    
    func deleteAllForecast() {
        let realm = try! Realm()
        try! realm.write {
            realm.delete(realm.objects(WeatherEntity.self))
        }
    }
    
    func getData<T :DecodableObject>( params: [String:Any], onSuccess: @escaping  (T) ->() , onFailure: @escaping (String) -> ()) {
        var newparams = params
        newparams["appid"] = WeatherApiRouter.Constants.API_KEY
        Alamofire.request(WeatherApiRouter.forecast(newparams)).responseJSON{
            response in
            guard response.result.isSuccess, let value = response.result.value, let data = response.data else {
                onFailure("\(String(describing:  response.result.error))")
                return
            }
            print(value)
            if JSON(value)["cod"].exists(){
                let cod = JSON(value)["cod"]
                if (cod.intValue == 200){
                    if(JSON(value)["list"].exists()){
                        //let listJSON = JSON(value)["list"]
                        //let weatherList: [Json4Swift_Base]?
                        let  weatherResponse = try! JSONDecoder().decode(T.self,from: data) as T
                        onSuccess(weatherResponse)
                        self.deleteAllForecast()
                        let realm = try! Realm()
                        try! realm.write {
                            realm.add(weatherResponse)
                        }
                    }
                }else{
                    if JSON(value)["message"].exists(){
                        onFailure(JSON(value)["message"].stringValue)
                    }
                }
            }
        }
        
    }
    
  
    
}
