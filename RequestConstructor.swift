//
//  RequestConstructor.swift
//  NetManager
//
//  Created by Ulxan Emiraslanov on 11/27/19.
//  Copyright © 2019 Ulxan Emiraslanov. All rights reserved.
//

import Foundation

 class RequestConstructor {
    
    let baseUrl: URL
    let queryParameters: [String: String]?
    let httpBody: [String: Any]?
    let httpHeaders: [String: String]?
    let httpMethod: HTTPMethod
    
    init(baseUrl: URL, parameters: [String: String]? = nil, body: [String: Any]? = nil, headers: [String: String]? = nil, method: HTTPMethod = .get) {
        self.baseUrl = baseUrl
        self.queryParameters = parameters
        self.httpBody = body
        self.httpHeaders = headers
        self.httpMethod = method
    }
    
    func constructRequest() -> URLRequest {
        
        var url: URL = baseUrl
        
        if let params = queryParameters {
            let query = QueryHandler(params)
            url = query.constructQuery(with: baseUrl)!
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = httpMethod.rawValue
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if let httpBody = httpBody {
            let bodyConstructor = BodyConstructor(httpBody)
            urlRequest.httpBody = bodyConstructor.getHttpBody
        }
        
        if let headers = httpHeaders {
            urlRequest.allHTTPHeaderFields = headers
        }
        return urlRequest
    }
}
