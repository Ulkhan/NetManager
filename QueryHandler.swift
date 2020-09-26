//
//  QueryHandler.swift
//  NetManager
//
//  Created by Ulxan Emiraslanov on 11/27/19.
//  Copyright © 2019 Ulxan Emiraslanov. All rights reserved.
//

import Foundation

 class QueryHandler {
    
    //MARK: - Variables
    private var parameters: [String: String]
   
    
    init(_ parameters: [String: String])  {
        self.parameters = parameters
    }
    func constructQuery(with url: URL) -> URL? {
        var urlComponent = URLComponents(string: url.absoluteString)
        var query = [URLQueryItem(name: "", value: nil)]

        parameters.forEach { (key, val) in
            let item = URLQueryItem(name: key, value: val)
            query.append(item)
        }
        
        urlComponent?.queryItems = query
        
        return urlComponent?.url
    }
    
}
