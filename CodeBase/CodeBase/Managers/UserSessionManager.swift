//
//  UserSessionManager.swift
//  MVVMBaseProject
//
//  Created by Jacob on 11/16/18.
//  Copyright © 2018 PHDV. All rights reserved.
//

import UIKit
import Foundation
import KeychainAccess

extension Notification.Name {
    static let didLogin = Notification.Name("UserDidLogin")
    static let didLogout = Notification.Name("UserDidLogout")
}

open class UserSessionManager: NSObject {
    
    struct KeychainKey {
        static let AccessToken = "com.pizzahut.accessToken"
        static let Password = "com.pizzahut.password"
        static let UserId = "com.pizzahut.userId"
    }
    
    let keychain = Keychain(service: AppInfo.bundleId())
    private(set) var user: User?
    // MARK: - Methods
    
    func userId() -> String? {
        return keychain[KeychainKey.UserId]
    }
    
    func accessToken() -> String? {
        return keychain[KeychainKey.AccessToken]
    }
    
    func password() -> String? {
        return keychain[KeychainKey.Password]
    }
    
    public var isAuthenticated: Bool {
        guard let userCode = userId(), userCode.count > 0, let password = password(), password.count > 0 else {
            return false
        }
        return true
    }
    
    func logout() {
        self.cleanUp()
        NotificationCenter.default.post(name: Notification.Name.didLogout, object: nil)
    }
    
    //MARK: - Private functions
    private func saveToken(_ token: String) {
        keychain[KeychainKey.AccessToken] = token
    }
    
    private func saveUserId(_ userId: String) {
        keychain[KeychainKey.UserId] = "\(userId)"
    }
    
    private func savePassword(_ password: String) {
        keychain[KeychainKey.Password] = password
    }
    
    func cleanUp() {
        UIApplication.shared.applicationIconBadgeNumber = 0
        keychain[KeychainKey.AccessToken] = nil
        keychain[KeychainKey.UserId] = nil
        keychain[KeychainKey.Password] = nil
    }
}

