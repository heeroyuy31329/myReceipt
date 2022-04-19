//
//  APIModel.swift
//  myReceipt
//
//  Created by 姜宗暐 on 2022/4/15.
//

import Foundation
import Amplify
//import AWSAPIPlugin

private let awsApiKey = "ya3GKbD4CTZiEiRhFkhW4Sxj4Aj21SN6uME5ksO6"

// MARK: request type
enum Method: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

class APIModel {
    static let shared = APIModel()
    
    func requset(method: Method,
                 url:String,
                 queryParameters: [String : String]? = nil,
                 body: Data? = nil,
                 listener: @escaping (AmplifyOperation<RESTOperationRequest, Data, APIError>.OperationResult) -> Void) {
        
        // request 物件
        let request = RESTRequest(path: url, headers: ["x-api-key" : awsApiKey], queryParameters: queryParameters, body: body)
        
        // 根據方法呼叫對應的API
        switch method {
        case .get:
            Amplify.API.get(request: request, listener: listener)
        case .post:
            Amplify.API.post(request: request, listener: listener)
        case .put:
            Amplify.API.put(request: request, listener: listener)
        case .delete:
            Amplify.API.delete(request: request, listener: listener)
        }
    }
}
