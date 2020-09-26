//
//  NetManager+Multipart.swift
//  MultipartFormtest
//
//  Created by Ulxan Emiraslanov on 6/30/20.
//  Copyright © 2020 Ulxan Emiraslanov. All rights reserved.
//

import Foundation

extension NetManager: URLSessionTaskDelegate {
  
    
    
    public func urlSession(_ session: URLSession, task: URLSessionTask, didSendBodyData bytesSent: Int64, totalBytesSent: Int64, totalBytesExpectedToSend: Int64)
    {
        let uploaded: Float = Float(totalBytesSent) / Float(totalBytesExpectedToSend)
        uploadProgress?(uploaded)
        
    }
    
    public func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        
        completionHandler(URLSession.AuthChallengeDisposition.useCredential, URLCredential(trust: challenge.protectionSpace.serverTrust!))
        
    }
    
    open func multiPartRequest(_ url: URL, params: [String: String]? = nil, media: [FormData], queryParams: [String: String]? = nil, headers: [String: String]? = nil, method: HTTPMethod = .post, completion: @escaping (Data? ,URLResponse?, Error?) -> Void) {
        
        let boundary = "Boundary-\(UUID().uuidString)"
        
        var urlComponent = URLComponents(string: url.absoluteString)
        
        
        if let params = queryParams {
            var query = [URLQueryItem(name: "", value: nil)]
            params.forEach { (key, val) in
                let item = URLQueryItem(name: key, value: val)
                query.append(item)
            }
            print(query)
            urlComponent?.queryItems = query
        }
        
        
        var req = URLRequest(url: urlComponent!.url!)
        req.httpMethod = method.rawValue
        
        req.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        let body = createDataBody(withParameters: params, media, boundary)
         req.httpBody = body
            
        
        if let headers = headers {
            req.allHTTPHeaderFields = headers
        }
        
    let session = URLSession(configuration: URLSessionConfiguration.default, delegate: self, delegateQueue: OperationQueue.main)
        
        
        
        session.uploadTask(with: req, from: nil, completionHandler: completion).resume()
    }
    
    private func createDataBody(withParameters params: [String: String]?,_ media: [FormData]?,_ boundary: String) -> Data {
        
        let lineBreak = "\r\n"
        var body = Data()
        
        
        if let parameters = params {
            for (key, value) in parameters {
                body.append("--\(boundary + lineBreak)")
                body.append("Content-Disposition: form-data; name=\"\(key)\"\(lineBreak + lineBreak)")
                body.append("\(value + lineBreak)")
            }
        }
        
        if let media = media {
            for item in media {
                body.append("--\(boundary + lineBreak)")
                body.append("Content-Disposition: form-data; name=\"\(item.name)\"\(lineBreak + lineBreak)")
                body.append("Content-Type: \(item.mimeType + lineBreak + lineBreak)")
                body.append(item.data)
                body.append(lineBreak)
            }
        }
        
        body.append("--\(boundary)--\(lineBreak)")
        
        return body
    }
    
    
    
}



extension Data {
    mutating func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            append(data)
        }
    }
}
