//
//  TaskManager.swift
//  NetManager
//
//  Created by Ulxan Emiraslanov on 11/27/19.
//  Copyright © 2019 Ulxan Emiraslanov. All rights reserved.
//

import Foundation

protocol TaskManager {
    func fireSession(completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> Int
    
}

 class DataTaskManager: TaskManager {

    private let urlRequest: URLRequest
    
    init(with urlRequest: URLRequest) {
        self.urlRequest = urlRequest
    }
    
    
    func fireSession(completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> Int {
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: urlRequest, completionHandler: completionHandler)
        task.resume()
        
        return task.taskIdentifier
    }
     
}
