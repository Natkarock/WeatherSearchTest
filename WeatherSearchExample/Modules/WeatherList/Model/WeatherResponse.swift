//
//  WeatherResponse.swift
//  WeatherSearchExample
//
//  Created by Karapats on 26/05/ 15.
//  Copyright © 2018 Karapats. All rights reserved.
//

import Foundation
import Realm
import RealmSwift
@objcMembers
class WeatherResponse: Object,Decodable {
    @objc dynamic var city: City? = nil
    let list:  List<WeatherEntity>? = List<WeatherEntity>()
    
    
    enum CodingKeys: String, CodingKey {
        case city = "city"
        case list = "list"
    }
    
    required convenience init(from decoder: Decoder) throws {
        self.init()
        let values = try decoder.container(keyedBy: CodingKeys.self)
        city = try values.decodeIfPresent(City.self, forKey: .city)
        let list = try values.decodeIfPresent([WeatherEntity].self, forKey: .list)
        list?.forEach{self.list?.append($0)}

    }
    
    required override init(value: Any) {
        super.init(value: value)
    }
    
    required init() {
        super.init()
    }
    
    required init(value: Any, schema: RLMSchema) {
        super.init(value: value, schema: schema)
    }
    
    required init(realm: RLMRealm, schema: RLMObjectSchema) {
        super.init(realm: realm, schema: schema)
    }
    
}
