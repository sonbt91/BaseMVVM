//
//  Appearance.swift
//  MVVMBaseProject
//
//  Created by Jacob on 11/15/18.
//  Copyright © 2018 PHDV. All rights reserved.
//

import UIKit

class Appearance: NSObject {
    
    static func setupDefaultAppearance() {
        
        // Navigation bar
        let navigationBarAppearance = UINavigationBar.appearance()
        navigationBarAppearance.isTranslucent = false
        navigationBarAppearance.barTintColor = UIColor.black
        navigationBarAppearance.tintColor = UIColor.white
        navigationBarAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        let appearance = UINavigationBar.appearance(whenContainedInInstancesOf: [BaseNavigationController.self])
        appearance.isTranslucent = false
        appearance.barStyle = .black
        
        let barButtonAppearance = UIBarButtonItem.appearance(whenContainedInInstancesOf: [BaseNavigationController.self])
        barButtonAppearance.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.white], for: .normal)
        
        // Same things for tabbar, textfield, etc...
    }
}
