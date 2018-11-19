//
//  BaseNavigationController.swift
//  MVVMBaseProject
//
//  Created by Jacob on 11/14/18.
//  Copyright © 2018 PHDV. All rights reserved.
//

import UIKit

open class BaseNavigationController: UINavigationController {
    override open func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.isTranslucent = false
        self.delegate = self
    }
}

extension BaseNavigationController: UINavigationControllerDelegate {
    
    private func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        self.topViewController?.navigationItem.backBarButtonItem =
            UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
}

extension UIViewController {
    public func embedInNavigationController() -> BaseNavigationController {
        let navigationController = BaseNavigationController(rootViewController: self)
        return navigationController
    }
}

