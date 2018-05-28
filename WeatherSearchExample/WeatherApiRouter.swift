//
//  WeatherApiRouter.swift
//  WeatherSearchExample
//
//  Created by Karapats on 21/05/ 15.
//  Copyright © 2018 Karapats. All rights reserved.
//

import Foundation
import Alamofire

public enum WeatherApiRouter: URLRequestConvertible{
    
    enum Constants {
        static let baseURLPath = "https://api.openweathermap.org/data/2.5"
        static let API_KEY = "86f5d5210b2f154859dadca9a0345cd0"
    }
    
    
    case forecast([String:Any])
    case weather([String:Any])
    
    
    var method: HTTPMethod {
        return .get
    }
    
    var path: String {
        switch self {
        case .forecast:
            return "/forecast"
        case .weather:
            return "/weather"
        }
    }
    
     var parameters: [String: Any] {
        switch self {
        case .forecast(let params),.weather(let params):
            return params
            return [:]
        }
    }
    
    
    
    public func asURLRequest() throws -> URLRequest {
        let url = try Constants.baseURLPath.asURL()
        var request = URLRequest(url: url.appendingPathComponent(path))
        request.httpMethod = method.rawValue
        request.timeoutInterval = TimeInterval(10 * 1000)
        if !Accessibility.isConnectedToNetwork() {
            request.cachePolicy = .returnCacheDataElseLoad
        }
        return try URLEncoding.default.encode(request, with: parameters)
    }
    
    

    
}
