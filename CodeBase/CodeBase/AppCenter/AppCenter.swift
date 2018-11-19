//
//  AppCenter.swift
//  MVVMBaseProject
//
//  Created by Jacob on 11/16/18.
//  Copyright © 2018 PHDV. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import Kingfisher
import Moya

// In charge in managing all shared main resources within the app

open class AppCenter {
    public static let shared = AppCenter()
    
    // To avoid singletons
    public var userSessionManager: UserSessionManager!
    public var languageManager: LanguageManager!
    
    init() {
        userSessionManager = UserSessionManager()
        languageManager = LanguageManager()
    }
    
    public func setup() {
        
        // Setup default appearance
        Appearance.setupDefaultAppearance()
        
        // Keyboard supported by IQKeyboard
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = true
        IQKeyboardManager.shared.shouldShowToolbarPlaceholder = true
        IQKeyboardManager.shared.toolbarDoneBarButtonItemText = "done.keyboard.title".localized()
        
        // Register general notifications
        self.registerNotifications()
        
        // Cleanup if needed
        if UserPreferenceManager.appHasLaunched() {
            UserPreferenceManager.setFirstTimeInstall(true)
        } else {
            // The first time app launches
            self.userSessionManager.cleanUp()
        }
    }
    
    public  func registerNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(languageDidChange), name: Notification.Name.languageDidChange, object: nil)
    }
    
    @objc public func languageDidChange() {
        IQKeyboardManager.shared.toolbarDoneBarButtonItemText = "done.keyboard.title".localized()
    }
}
