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

extension LanguageTranslationV2 {

    /** The result of translating an input text from a source language to a target language. */
    public struct TranslateResponse: JSONDecodable {

        /// The number of words in the complete input text.
        public let wordCount: Int

        /// The number of characters in the complete input text.
        public let characterCount: Int

        /// A list of translation output, corresponding to the list of input text.
        public let translations: [Translation]

        public init(json: JSON) throws {
            wordCount = try json.int("word_count")
            characterCount = try json.int("character_count")
            translations = try json.array("translations").map { json in try json.decode() }
        }
    }

    /** A translation of input text from a source language to a target language. */
    public struct Translation: JSONDecodable {

        /// The translation of input text from a source language to a target language.
        public let translation: String

        public init(json: JSON) throws {
            translation = try json.string("translation")
        }
    }
}