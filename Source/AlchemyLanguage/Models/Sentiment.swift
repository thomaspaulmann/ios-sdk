/**
 * Copyright IBM Corporation 2015
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 **/

import Foundation
import Freddy

/**
 
 **Sentiment**
 
 Returned by the AlchemyLanguage service.
 
 */
extension AlchemyLanguageV1 {
    public struct Sentiment: JSONDecodable {
        public let mixed: Int?
        public let score: Double?
        public let type: String?
        
        public init(json: JSON) throws {
            mixed = try Int(json.string("mixed"))
            score = try Double(json.string("score"))
            type = try json.string("tyoe")
        }
    }
}
