//
//  RegisterTransition.swift
//  MVVMBaseProject
//
//  Created by Jacob on 11/14/18.
//  Copyright © 2018 PHDV. All rights reserved.
//

import UIKit

class RegisterRouter: Router {

    @discardableResult
    func navigate(from root: AnyScreen?, transitionType: TransitionType, animated: Bool, completion: (() -> Void)?) -> AnyScreen? {
        let registerViewController = RegisterViewController.initFromDefaultXib()
        RoutingExecutor.navigate(from: root, to: registerViewController.embedInNavigationController(), transitionType: transitionType, animated: animated, completion: completion)
        
        return registerViewController
    }
}
