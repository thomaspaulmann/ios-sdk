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

import Foundation
import Alamofire
import Freddy

public class AlchemyLanguageV1 {
    
    private let apiKey: String
    
    private let serviceUrl = "http://gateway-a.watsonplatform.net/calls"
    private let errorDomain = "com.watsonplatform.alchemyLanguage"
    
    public init(apiKey: String) {
        self.apiKey = apiKey
    }
    
    private func dataToError(data: NSData) -> NSError? {
        do {
            let json = try JSON(data: data)
            let description = try json.string("description")
            let error = try json.string("error")
            let code = try json.int("code")
            let userInfo = [
                NSLocalizedFailureReasonErrorKey: error,
                NSLocalizedDescriptionKey: description
            ]
            return NSError(domain: errorDomain, code: code, userInfo: userInfo)
        } catch {
            return nil
        }
    }
    
    private func shouldHaveGraph(knowledgeGraph: Bool) -> String {
        if(knowledgeGraph == true) {
           return "1"
        } else {
           return "0"
        }
    }
    
    public func getAuthorsURL(
        url: String,
        failure: (NSError -> Void)? = nil,
        success: DocumentAuthors -> Void)
    {
        
        // construct request
        let request = RestRequest(
            method: .POST,
            url: serviceUrl + "/url/URLGetAuthors",
            acceptType: "application/json",
            contentType: "application/x-www-form-urlencoded",
            queryParameters: [
                NSURLQueryItem(name: "url", value: url),
                NSURLQueryItem(name: "apikey", value: apiKey),
                NSURLQueryItem(name: "outputMode", value: "json")
            ]
        )
        
        // execute request
        Alamofire.request(request)
            .responseObject(dataToError: dataToError) {
                (response: Response<DocumentAuthors, NSError>) in
                switch response.result {
                case .Success(let authors): success(authors)
                case .Failure(let error): failure?(error)
                }
        }
        
    }
    
    public func getAuthorsHTTP(
        html: String,
        url: String? = nil,
        failure: (NSError -> Void)? = nil,
        success: DocumentAuthors -> Void)
    {
        
        // construct body
        guard let body = try? ["html_File": html].toJSON().serialize() else {
            let failureReason = "Classification text could not be serialized to JSON."
            let userInfo = [NSLocalizedFailureReasonErrorKey: failureReason]
            let error = NSError(domain: errorDomain, code: 0, userInfo: userInfo)
            failure?(error)
            return
        }
        
        // construct request
        let request = RestRequest(
            method: .POST,
            url: serviceUrl + "/html/HTMLGetAuthors",
            acceptType: "application/json",
            contentType: "application/x-www-form-urlencoded",
            messageBody: body,
            queryParameters: [
                NSURLQueryItem(name: "url", value: url),
                NSURLQueryItem(name: "apikey", value: apiKey),
                NSURLQueryItem(name: "outputMode", value: "json")
            ]
        )
        
        // execute request
        Alamofire.request(request)
            .responseObject(dataToError: dataToError) {
                (response: Response<DocumentAuthors, NSError>) in
                switch response.result {
                case .Success(let authors): success(authors)
                case .Failure(let error): failure?(error)
                }
        }
    }
    
    public func getRankedConceptsURL(
        url: String,
        knowledgeGraph: Bool? = false,
        failure: (NSError -> Void)? = nil,
        success: ConceptResponse -> Void)
    {
        let graph = shouldHaveGraph(knowledgeGraph!)
        
        // construct request
        let request = RestRequest(
            method: .POST,
            url: serviceUrl + "/url/URLGetRankedConcepts",
            acceptType: "application/json",
            contentType: "application/x-www-form-urlencoded",
            queryParameters: [
                NSURLQueryItem(name: "url", value: url),
                NSURLQueryItem(name: "apikey", value: apiKey),
                NSURLQueryItem(name: "outputMode", value: "json"),
                NSURLQueryItem(name: "linkedData", value: "1"),
                NSURLQueryItem(name: "knowledgeGraph", value: graph)
            ]
        )
        
        // execute request
        Alamofire.request(request)
            .responseObject(dataToError: dataToError) {
                (response: Response<ConceptResponse, NSError>) in
                switch response.result {
                case .Success(let concepts): success(concepts)
                case .Failure(let error): failure?(error)
                }
        }
    }
    
    public func getRankedNamedEntitiesURL(
        url: String,
        knowledgeGraph: Bool? = false,
        failure: (NSError -> Void)? = nil,
        success: Entities -> Void)
    {
        let graph = shouldHaveGraph(knowledgeGraph!)
        
        // construct request
        let request = RestRequest(
            method: .POST,
            url: serviceUrl + "/url/URLGetRankedNamedEntities",
            acceptType: "application/json",
            contentType: "application/x-www-form-urlencoded",
            queryParameters: [
                NSURLQueryItem(name: "url", value: url),
                NSURLQueryItem(name: "apikey", value: apiKey),
                NSURLQueryItem(name: "outputMode", value: "json"),
                NSURLQueryItem(name: "linkedData", value: "1"),
                NSURLQueryItem(name: "knowledgeGraph", value: graph)
            ]
        )
        
        // execute request
        Alamofire.request(request)
            .responseObject(dataToError: dataToError) {
                (response: Response<Entities, NSError>) in
                switch response.result {
                case .Success(let entities): success(entities)
                case .Failure(let error): failure?(error)
                }
        }
    }
    
    public func getRankedKeywordsURL(
        url: String,
        knowledgeGraph: Bool? = false,
        failure: (NSError -> Void)? = nil,
        success: Keywords -> Void)
    {
        let graph = shouldHaveGraph(knowledgeGraph!)
        
        // construct request
        let request = RestRequest(
            method: .POST,
            url: serviceUrl + "/url/URLGetRankedKeywords",
            acceptType: "application/json",
            contentType: "application/x-www-form-urlencoded",
            queryParameters: [
                NSURLQueryItem(name: "url", value: url),
                NSURLQueryItem(name: "apikey", value: apiKey),
                NSURLQueryItem(name: "outputMode", value: "json"),
                NSURLQueryItem(name: "linkedData", value: "1"),
                NSURLQueryItem(name: "knowledgeGraph", value: graph)
            ]
        )
        
        // execute request
        Alamofire.request(request)
            .responseObject(dataToError: dataToError) {
                (response: Response<Keywords, NSError>) in
                switch response.result {
                case .Success(let keywords): success(keywords)
                case .Failure(let error): failure?(error)
                }
        }
    }
    
    public func getLanguageURL(
        url: String,
        failure: (NSError -> Void)? = nil,
        success: Language -> Void)
    {
        // construct request
        let request = RestRequest(
            method: .POST,
            url: serviceUrl + "/url/URLGetLanguage",
            acceptType: "application/json",
            contentType: "application/x-www-form-urlencoded",
            queryParameters: [
                NSURLQueryItem(name: "url", value: url),
                NSURLQueryItem(name: "apikey", value: apiKey),
                NSURLQueryItem(name: "outputMode", value: "json")
            ]
        )
        
        // execute request
        Alamofire.request(request)
            .responseObject(dataToError: dataToError) {
                (response: Response<Language, NSError>) in
                switch response.result {
                case .Success(let language): success(language)
                case .Failure(let error): failure?(error)
                }
        }
    }
    
    public func getMicroformatDataURL(
        url: String,
        failure: (NSError -> Void)? = nil,
        success: Microformats -> Void)
    {
        // construct request
        let request = RestRequest(
            method: .POST,
            url: serviceUrl + "/url/URLGetMicroformatData",
            acceptType: "application/json",
            contentType: "application/x-www-form-urlencoded",
            queryParameters: [
                NSURLQueryItem(name: "url", value: url),
                NSURLQueryItem(name: "apikey", value: apiKey),
                NSURLQueryItem(name: "outputMode", value: "json")
            ]
        )
        
        // execute request
        Alamofire.request(request)
            .responseObject(dataToError: dataToError) {
                (response: Response<Microformats, NSError>) in
                switch response.result {
                case .Success(let microformats): success(microformats)
                case .Failure(let error): failure?(error)
                }
        }
    }
    
    public func getPubDateURL(
        url: String,
        failure: (NSError -> Void)? = nil,
        success: PublicationResponse -> Void)
    {
        // construct request
        let request = RestRequest(
            method: .POST,
            url: serviceUrl + "/url/URLGetPubDate",
            acceptType: "application/json",
            contentType: "application/x-www-form-urlencoded",
            queryParameters: [
                NSURLQueryItem(name: "url", value: url),
                NSURLQueryItem(name: "apikey", value: apiKey),
                NSURLQueryItem(name: "outputMode", value: "json")
            ]
        )
        
        // execute request
        Alamofire.request(request)
            .responseObject(dataToError: dataToError) {
                (response: Response<PublicationResponse, NSError>) in
                switch response.result {
                case .Success(let pubResponse): success(pubResponse)
                case .Failure(let error): failure?(error)
                }
        }

    }
    
    public func getRelationsURL(
        url: String,
        knowledgeGraph: Bool? = false,
        disambiguateEntities: Bool? = false,
        linkedDate: Bool? = false,
        coreference: Bool? = false,
        failure: (NSError -> Void)? = nil,
        success: SAORelations -> Void)
    {
        
    }

}
