//
//  BodyConstructor.swift
//  NetManager
//
//  Created by Ulxan Emiraslanov on 11/27/19.
//  Copyright © 2019 Ulxan Emiraslanov. All rights reserved.
//

import Foundation

 class BodyConstructor {
    
    private let body: [String: Any]
    private var httpBody: Data? = nil
    
    
    init(_ body: [String: Any]) {
        self.body = body
    }
    
    var getHttpBody: Data? {
        get {
            do {
                httpBody = try JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
            } catch let err {
                print(err.localizedDescription)
            }
            return httpBody
        }
    }
}
