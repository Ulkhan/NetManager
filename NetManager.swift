//
//  NetManager.swift
//  NetManager
//
//  Created by Ulxan Emiraslanov on 11/28/19.
//  Copyright © 2019 Ulxan Emiraslanov. All rights reserved.
//

import Foundation

open class NetManager: NSObject {
    
    static let shared = NetManager()
    
    private override init() {}
    
    var uploadProgress: ((Float) -> Void)?
    
    func fire(_ url: URL, params: [String: String]? = nil, body: [String: Any]? = nil, headers: [String: String]? = nil, method: HTTPMethod, taskId: inout Int, completion: @escaping (Data? ,URLResponse?, Error?) -> Void) {
        let reqConstructor = RequestConstructor(baseUrl: url, parameters: params, body: body, headers: headers, method: method)
        
        let task = DataTaskManager(with: reqConstructor.constructRequest())
        
        taskId = task.fireSession(completionHandler: completion)
        
    }
    
    func cancelTask(ofId id: Int) {
        URLSession.shared.getAllTasks { tasks in
            tasks
                .filter { $0.state == .running }
                .filter { $0.taskIdentifier == id }.first?
                .cancel()
        }
    }
}
