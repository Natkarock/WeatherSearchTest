//
//  WeatherListPresenter.swift
//  WeatherSearchExample
//
//  Created by Karapats on 21/05/ 15.
//  Copyright © 2018 Karapats. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import RealmSwift

protocol MainPProtocol {
    func getWeatherList(by cityName:String)
    func getWeatherList(by lat:Double, and lon:Double)
}

class MainPresenter: MainPProtocol {
    var view: MainVProtocol!
    
    init(view: MainVProtocol) {
        self.view = view
    }

    func getWeatherList(by cityName:String) {
        DataManager<WeatherResponse>().getForecast(params: ["q": cityName], onSuccess: {( response: WeatherResponse )  in self.view.setForecast(data: response)},
                                  onFailure: {text in self.view.showError(text: text)})
    }
    
    
    func getWeatherList(by lat:Double, and lon:Double){
        let params = ["lat":lat,"lon":lon]
        DataManager<WeatherResponse>().getForecast(params: params, onSuccess: {( response: WeatherResponse ) in self.view.setForecast(data: response)},
                                                   onFailure: {text in self.view.showError(text: text)})
    }
    
    
}
