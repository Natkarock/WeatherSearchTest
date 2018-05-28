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
class Main : Object,Decodable {
	@objc dynamic var temp : Double = 0.0
	@objc dynamic var temp_min : Double = 0.0
	@objc dynamic var temp_max : Double = 0.0
	@objc dynamic var pressure : Double = 0.0
	@objc dynamic var sea_level : Double = 0.0
	@objc dynamic var grnd_level : Double = 0.0
	@objc dynamic var humidity : Int = 0
	@objc dynamic var temp_kf : Double = 0

	enum CodingKeys: String, CodingKey {

		case temp = "temp"
		case temp_min = "temp_min"
		case temp_max = "temp_max"
		case pressure = "pressure"
		case sea_level = "sea_level"
		case grnd_level = "grnd_level"
		case humidity = "humidity"
		case temp_kf = "temp_kf"
	}

    required convenience init (from decoder: Decoder) throws {
        self.init()
		let values = try decoder.container(keyedBy: CodingKeys.self)
		temp = try values.decodeIfPresent(Double.self, forKey: .temp) ?? 0.0
		temp_min = try values.decodeIfPresent(Double.self, forKey: .temp_min) ?? 0.0
		temp_max = try values.decodeIfPresent(Double.self, forKey: .temp_max) ?? 0.0
		pressure = try values.decodeIfPresent(Double.self, forKey: .pressure) ?? 0.0
		sea_level = try values.decodeIfPresent(Double.self, forKey: .sea_level) ?? 0.0
		grnd_level = try values.decodeIfPresent(Double.self, forKey: .grnd_level) ?? 0.0
		humidity = try values.decodeIfPresent(Int.self, forKey: .humidity) ?? 0
		temp_kf = try values.decodeIfPresent(Double.self, forKey: .temp_kf) ?? 0.0
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
