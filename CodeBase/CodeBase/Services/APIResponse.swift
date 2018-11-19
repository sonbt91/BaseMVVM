//
//  APIResponse.swift
//  MVVMBaseProject
//
//  Created by Jacob on 11/15/18.
//  Copyright © 2018 PHDV. All rights reserved.
//

import UIKit
import Alamofire
import Moya
import SwiftyJSON

public protocol Jsonable {
    
    init?(json: JSON)
    func export() -> JSON
}

public extension Jsonable {
    
    func export() -> JSON {
        return .null
    }
}

// MARK: - API Response
open class ApiResponse {
    
    let error: Error?
    let data: JSON?
    
    init(response: Response) {
        
        // Handle response
        if response.isUnauthenticated {
            self.error = ServiceErrorAPI(code: ServiceHelper.errorCodeUnauthenticated, reason: "general.error.message.unauthenticated".localized())
            self.data = nil
        } else if response.isUnauthorized {
            self.error = ServiceErrorAPI(code: ServiceHelper.errorCodeUnauthorized, reason: "general.error.message.unauthorized".localized())
            self.data = nil
        } else if response.isSuccess {
            let json = JSON(response.data)
            if json["status"].exists() && json["status"].intValue == 0 {
                self.error = ServiceErrorAPI(code: response.statusCode, reason: json["message"].stringValue)
            } else {
                self.error = nil
            }
            
            if json["data"].exists() {
                self.data = json["data"]
            } else {
                self.data = json
            }
        } else {
            self.error = ServiceErrorAPI(code: response.statusCode, reason: "general.message.error".localized())
            self.data = nil
        }
    }
    
    // Keypath is the key following "data"
    // e.g:
    //  "data" : {
    //      "customer" : {
    //          "age": 10
    //          "name": "John"
    //      }
    //   }
    //
    
    public func toObject<T: Jsonable>(_ as: T.Type, keyPath: String? = nil) -> T? {
        guard let data = self.data else {
            return nil
        }
        if let keyPath = keyPath {
            return T(json: data[keyPath])
        } else {
            return T(json: data)
        }
    }
    
    public func toArray<T: Jsonable>(_ as: [T.Type], keyPath: String? = nil) -> [T] {
        guard let data = self.data else {
            return []
        }
        if let keyPath = keyPath {
            return data[keyPath].arrayValue.compactMap { T(json: $0) }
        } else {
            return data.arrayValue.compactMap { T(json: $0) }
        }
    }
}

// MARK: - Moya Extension
public extension Response {
    
    public func mapApi() -> ApiResponse {
        return ApiResponse(response: self)
    }
}

public struct ServiceHelper {
    
    static let errorServiceDomain = "pizzahut.error.service"
    static let errorCodeUnauthenticated = 401
    static let errorCodeUnauthorized = 403
    static let errorInternal = 500
    
    public static func defaultEndpointClosure<Target: TargetType>(target: Target) -> Endpoint {
        var headers = [String: String]()
        
        // authorization
        if let token = UserPreferenceManager.shared.currentToken {
            headers["Authorization"] = "Bearer \(token)"
        }
        // Check if need to use cookie (may be later)
//        if let user = Session.shared.currentUser {
//            headers["Cookie"] = "{'sails.sid': '\(user.sid)'}"
//        }
        
        // language
        let currentLanguage = NSLocale.preferredLanguages[0] //LanguageManager.shared.currentLanguage.languageCode
        let acceptLanguage: String
        if currentLanguage == "vi" {
            acceptLanguage = "vi-VN"
        } else if currentLanguage == "en-US" {
            acceptLanguage = "en-US"
        } else {
            acceptLanguage = "vi-VN" // default language -> Change depends on requirement
        }
        headers["Accept-Language"] = acceptLanguage
        
        let defaultEndpoint = MoyaProvider.defaultEndpointMapping(for: target)
        return defaultEndpoint.adding(newHTTPHeaderFields: headers)
    }
}

extension NSError {
    
    var isUnauthenticated: Bool {
        return self.code == ServiceHelper.errorCodeUnauthenticated
    }
    
    var isUnauthorized: Bool {
        return self.code == ServiceHelper.errorCodeUnauthorized
    }
}

extension Moya.Response {
    
    var isSuccess: Bool {
        return statusCode == 200
    }
    
    var isUnauthenticated: Bool {
        return statusCode == ServiceHelper.errorCodeUnauthenticated
    }
    
    var isUnauthorized: Bool {
        return statusCode == ServiceHelper.errorCodeUnauthorized
    }
}
