//
//  MainLoginRouter.swift
//  MVVMBaseProject
//
//  Created by Jacob on 11/16/18.
//  Copyright © 2018 PHDV. All rights reserved.
//

import UIKit
import CodeBase

class MainLoginRouter: Router {
    
    @discardableResult
    func navigate(from root: AnyScreen?, transitionType: TransitionType, animated: Bool, completion: (() -> Void)?) -> AnyObject? {
        let mainLoginViewController = MainLoginViewController.initFromDefaultXib()
        RoutingExecutor.navigate(from: root, to: mainLoginViewController, transitionType: transitionType, animated: animated, completion: completion)
        return mainLoginViewController
    }
    
}
