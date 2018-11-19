//
//  LoginRouter.swift
//  MVVMBaseProject
//
//  Created by Jacob on 11/14/18.
//  Copyright © 2018 PHDV. All rights reserved.
//

import UIKit
import CodeBase

open class LoginRouter: Router {
    
    public init() { }
    
    @discardableResult
    public func navigate(from root: AnyScreen?, transitionType: TransitionType, animated: Bool, completion: (() -> Void)?) -> AnyScreen? {
        let loginViewController = LoginViewController.initFromDefaultXib()
        RoutingExecutor.navigate(from: root, to: loginViewController.embedInNavigationController(), transitionType: transitionType, animated: animated, completion: completion)
        return loginViewController
    }
}
