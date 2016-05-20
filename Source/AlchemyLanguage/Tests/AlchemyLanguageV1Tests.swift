/**
 * Copyright IBM Corporation 2016
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

import XCTest
import WatsonDeveloperCloud

class AlchemyLanguageV1Tests: XCTestCase {
    
    private var service: AlchemyLanguageV1!
    
    private let timeout: NSTimeInterval = 60.0
    
    let testUrl = "http://arstechnica.com/gadgets/2016/05/android-instant-apps-will-blur-the-lines-between-apps-and-mobile-sites/"
    
    override func setUp() {
        if let url = NSBundle(forClass: self.dynamicType).pathForResource("Credentials", ofType: "plist") {
            if let dict = NSDictionary(contentsOfFile: url) as? Dictionary<String, String> {
                let apikey = dict["AlchemyAPIKey"]!
                if service == nil {
                    service = AlchemyLanguageV1(apiKey: apikey)
                }
            } else {
                XCTFail("Unable to extract dictionary from plist")
            }
        } else {
            XCTFail("Plist file not found")
        }
    }
    
    /** Fail false negatives. */
    func failWithError(error: NSError) {
        XCTFail("Positive test failed with error: \(error)")
    }
    
    /** Fail false positives. */
    func failWithResult<T>(result: T) {
        XCTFail("Negative test returned a result.")
    }
    
    /** Wait for expectations. */
    func waitForExpectations() {
        waitForExpectationsWithTimeout(timeout) { error in
            XCTAssertNil(error, "Timeout")
        }
    }
    
    func stringFromURLString(url: String) -> String? {
        let myURL = NSURL(string: testUrl)
        do {
            let myHtml = try String(contentsOfURL: myURL!)
            return myHtml
        } catch {
            return nil
        }
    }
    
    func testGetAuthorsURL() {
        let description = "Get the author of an Ars article"
        let expectation = expectationWithDescription(description)

        service.getAuthorsURL(testUrl, failure: failWithError) { authors in
            XCTAssertNotNil(authors, "Authors should not be nil")
            expectation.fulfill()
        }
        waitForExpectations()
    }
    
    func testGetAuthorsHTTP() {
        let description = "Get the author of an article, given the html"
        let expectation = expectationWithDescription(description)
        
        let html = stringFromURLString(testUrl)
        
        service.getAuthorsHTTP(html!, failure: failWithError) { authors in
            XCTAssertNotNil(authors, "Authors should not be nil")
            expectation.fulfill()
        }
        
        waitForExpectations()
        
    }
    
    func testGetRankedConceptsURL() {
        let description = "Get the ranked concepts of an Ars article"
        let expectation = expectationWithDescription(description)
        
        service.getRankedConceptsURL(testUrl, failure: failWithError) { concepts in
            XCTAssertNotNil(concepts, "Concepts should not be nil")
            expectation.fulfill()
        }
        waitForExpectations()
    }
    
    func testGetRankedNamedEntitiesURL() {
        let description = "Get the entities of an Ars article"
        let expectation = expectationWithDescription(description)
        
        service.getRankedNamedEntitiesURL(testUrl, failure: failWithError) { entities in
            XCTAssertNotNil(entities, "Entities should not be nil")
            expectation.fulfill()
        }
        waitForExpectations()
    }
    
    func testGetRankedKeywordsURL() {
        let description = "Get the keywords of an Ars article"
        let expectation = expectationWithDescription(description)
        service.getRankedKeywordsURL(testUrl, failure: failWithError) { keywords in
            XCTAssertNotNil(keywords, "Keywords should not be nil")
            expectation.fulfill()
        }
        waitForExpectations()
    }
    
    func testGetLanguageURL() {
        let description = "Get the language of an Ars article"
        let expectation = expectationWithDescription(description)
        service.getLanguageURL(testUrl, failure: failWithError) { language in
            XCTAssertNotNil(language, "Keywords should not be nil")
            expectation.fulfill()
        }
        waitForExpectations()
    }
    
    func testGetMicroformatsURL() {
        let description = "Get the microformats of an Ars article"
        let expectation = expectationWithDescription(description)
        service.getLanguageURL(testUrl, failure: failWithError) { microformats in
            XCTAssertNotNil(microformats, "Microformats should not be nil")
            expectation.fulfill()
        }
        waitForExpectations()
    }
    
    func testGetPubDateURL() {
        let description = "Get the publication date of an Ars article"
        let expectation = expectationWithDescription(description)
        service.getLanguageURL(testUrl, failure: failWithError) { pubDate in
            XCTAssertNotNil(pubDate, "Publication Date should not be nil")
            expectation.fulfill()
        }
        waitForExpectations()
    }
    
}
