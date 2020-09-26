//
//  FormData.swift
//  MultipartFormtest
//
//  Created by Ulxan Emiraslanov on 6/30/20.
//  Copyright © 2020 Ulxan Emiraslanov. All rights reserved.
//

import Foundation

public struct FormData {
    let name: String
    let fileName: String
    let data: Data
    let mimeType: String
    
    public init(data: Data, withName name: String, fileName: String = "", mimeType: String = "") {
        self.data = data
        self.name = name
        self.mimeType = mimeType
        self.fileName = fileName
        
    }
    
}
