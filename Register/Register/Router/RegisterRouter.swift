//
//  RegisterRouter.swift
//  Register
//
//  Created by Jacob on 11/16/18.
//  Copyright © 2018 PHDV. All rights reserved.
//

import UIKit
import CodeBase

open class RegisterRouter: Router {
    
    public init () {}
    
    @discardableResult
    open func navigate(from root: AnyScreen?, transitionType: TransitionType, animated: Bool, completion: (() -> Void)?) -> AnyObject? {
        let registerViewController = RegisterViewController.initFromDefaultXib()
        RoutingExecutor.navigate(from: root, to: registerViewController.embedInNavigationController(), transitionType: .present, animated: animated, completion: completion)
        return registerViewController
    }
}
