//
//  Decoder.swift
//  NetManager
//
//  Created by Ulxan Emiraslanov on 11/27/19.
//  Copyright © 2019 Ulxan Emiraslanov. All rights reserved.
//

import Foundation

class Decoder {
    
    static func decode<T: Decodable>(data: Data, ofType type: T.Type) -> Result<(T), Error> {
        do {
            let decodedData = try JSONDecoder().decode(type.self, from: data)
            return .success(decodedData)
        } catch (let error) {
            return .failure(error)
            
        }
    }
    
    
}
