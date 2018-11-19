//
//  AuthenAPI.swift
//  MVVMBaseProject
//
//  Created by Jacob on 11/16/18.
//  Copyright © 2018 PHDV. All rights reserved.
//

import UIKit
import Moya
import CodeBase

public let AuthenAPIProvider = MoyaProvider<AuthenAPI>(endpointClosure: ServiceHelper.defaultEndpointClosure)

// Define APIs
public enum AuthenAPI {
    case register(model: Register)
}

// Authen extension
extension AuthenAPI: TargetType {
    public var baseURL: URL {
        return URL.init(string: "https://jsonplaceholder.typicode.com")!
    }
    
    public var path: String {
        switch self {
        case .register(_):
            return "/comments"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .register(_):
            return .get
        }
    }
    
    public var headers: [String : String]? {
        return [:]
    }
    
    var parameters: [String : Any]? {
        switch self {
        // Register
        case .register(let registerModel):
            LogDebug(registerModel.email)
            return [
                "postId": String(1)
//                "email": registerModel.email,
//                "password": registerModel.password,
            ]
        }
    }
    
    
    var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }
    
    public var sampleData: Data {
        return "No caption needed yet.".localized().data(using: String.Encoding.utf8)!
    }
    
    public var task: Task {
        if self.parameters != nil {
            if self.method == .post {
                return .requestParameters(parameters: self.parameters!, encoding: JSONEncoding.default)
            }
            return .requestParameters(parameters: self.parameters!, encoding: URLEncoding.default)
        }
        return .requestPlain
    }
}
