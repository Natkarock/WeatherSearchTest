/* 
Copyright (c) 2018 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
import Realm
import RealmSwift
@objcMembers
class WeatherEntity : Object,Decodable {
    @objc dynamic var dt = 0
	@objc dynamic var main : Main? = nil
	let weather : List<Weather>? = List<Weather>()
	@objc dynamic var clouds : Clouds? = nil
	@objc dynamic var wind : Wind? = nil
	@objc dynamic var sys : Sys? = nil
    @objc dynamic var dt_txt  = ""

	enum CodingKeys: String, CodingKey {

		case dt = "dt"
		case main = "main"
		case weather = "weather"
		case clouds = "clouds"
		case wind = "wind"
		case sys = "sys"
		case dt_txt = "dt_txt"
	}

	required convenience init(from decoder: Decoder) throws {
        self.init()
		let values = try decoder.container(keyedBy: CodingKeys.self)
		dt = try values.decodeIfPresent(Int.self, forKey: .dt) ?? 0
        main = try values.decodeIfPresent(Main.self, forKey: .main)
        let weatherList = try values.decodeIfPresent([Weather].self, forKey: .weather)
        weatherList?.forEach{weather?.append($0)}
		clouds = try Clouds(from: decoder)
		wind = try Wind(from: decoder)
		sys = try Sys(from: decoder)
		dt_txt = try values.decodeIfPresent(String.self, forKey: .dt_txt) ?? ""
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
