//
//  UserPreference.swift
//  MVVMBaseProject
//
//  Created by Jacob on 11/16/18.
//  Copyright © 2018 PHDV. All rights reserved.
//

import UIKit

struct UserDefaultKey {
    static let firstTimeInstall = "com.pizzahut.first.time.install"
}

class UserPreferenceManager {
    
    static let shared = UserPreferenceManager()
    
    static func setFirstTimeInstall(_ value: Bool) {
        UserDefaults.standard.set(value, forKey: UserDefaultKey.firstTimeInstall)
        UserDefaults.standard.synchronize()
    }
    
    static func appHasLaunched() -> Bool {
        return UserDefaults.standard.bool(forKey: UserDefaultKey.firstTimeInstall)
    }
    
    var deviceToken: String? {
        get {
            return UserDefaults.standard.string(forKey: "com.pizzahut.device_token")
        }
        set {
            if let token = newValue {
                UserDefaults.standard.set(token, forKey: "com.pizzahut.device_token")
                UserDefaults.standard.synchronize()
                // TODO:
                // Register push token (to Firebase for example)
            } else {
                UserDefaults.standard.removeObject(forKey: "com.pizzahut.device_token")
                // TODO:
                // Un-Register push token (to Firebase for example)
            }
        }
    }
    
    var currentToken: String? {
        get {
            return UserDefaults.standard.string(forKey: "com.pizzahut.current_token")
        }
        set {
            if let newValue = newValue {
                UserDefaults.standard.set(newValue, forKey: "com.pizzahut.current_token")
                UserDefaults.standard.synchronize()
            } else {
                UserDefaults.standard.removeObject(forKey: "com.pizzahut.current_token")
            }
        }
    }
}
