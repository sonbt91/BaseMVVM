//
//  Error.swift
//  MVVMBaseProject
//
//  Created by Jacob on 11/15/18.
//  Copyright © 2018 PHDV. All rights reserved.
//

import UIKit

public struct ServiceErrorAPI: LocalizedError {
    public enum ServiceErrorCode: String {
        case invalidDataFormat = "INVALID_DATA"
        case invalidToken = "INVALID_TOKEN"
        case unauthenticated = "UNAUTHENTICATED"
        case emptyResponse = "EMPTYRESPONSE"
        case timeout = "TIMEOUT"
        case undefined = "UNDEFINED"
    }
    
    static let unauthenticated = ServiceErrorAPI(code: .unauthenticated, reason: "Unauthenticated".localized())
    static let emptyResponse = ServiceErrorAPI(code: .emptyResponse, reason: "Empty Response".localized())
    static let invalidDataFormat = ServiceErrorAPI(code: .invalidDataFormat, reason: "Invalid Data Format".localized())
    static let timeout = ServiceErrorAPI(code: .timeout, reason: "Request Time out".localized())
    static let invalidToken = ServiceErrorAPI(code: .invalidToken, reason: "Invalid token".localized())
    static let undefined = ServiceErrorAPI(code: .undefined, reason: "Undefined error".localized())
    
    fileprivate (set) var code: String
    fileprivate (set) var reason: String
    fileprivate (set) var data: [String: Any]?
    
    init(code: ServiceErrorCode, reason: String) {
        self.code = code.rawValue
        self.reason = reason
    }
    
    init(code: String, reason: String) {
        self.code = code
        self.reason = reason
    }
    
    init (code: Int, reason: String, data:[String: Any]? = nil) {
        self.code = "\(code)"
        self.reason = reason
        self.data = data
    }
    
    public var errorDescription: String? {
        get {
            return self.reason
        }
    }
}
