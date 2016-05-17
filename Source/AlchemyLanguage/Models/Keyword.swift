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
 
 **Keyword**
 
 Returned by the AlchemyLanguage service.
 
 */
extension AlchemyLanguageV1 {
    public struct Keyword: JSONDecodable {
        public let knowledgeGraph: KnowledgeGraph?
        public let relevance: Double?
        public let sentiment: Sentiment?
        public let text: String?
        
        public init(json: JSON) throws {
            knowledgeGraph = try json.decode("knowledgeGraph", type: KnowledgeGraph.init)
            relevance = try Double(json.string("relevance"))
            sentiment = try json.decode("sentiment", type: Sentiment.init)
            text = try json.string("text")
        }
    }
    
}
