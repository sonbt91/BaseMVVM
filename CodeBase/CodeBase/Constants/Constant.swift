//
//  Constant.swift
//  MVVMBaseProject
//
//  Created by Jacob on 11/14/18.
//  Copyright © 2018 PHDV. All rights reserved.
//

import UIKit

public struct Constant {
    
    #if STAGING
        public static let apiBaseUrl = URL(string: "https://google.com")!
    #else
        public static let apiBaseUrl = URL(string: "point_to_prod_here")!
    #endif
    
    public static let ErrorTitle = "error.title".localized()
    public static let AppName = "PizzaHut"
    
    public static let AlertOkayButtonTitle = "alert.ok.title".localized()
    public static let AlertDismissButtonTitle = "alert.ok.dismiss".localized()
}
