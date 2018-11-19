//
//  Router.swift
//  MVVMBaseProject
//
//  Created by Jacob on 11/14/18.
//  Copyright © 2018 PHDV. All rights reserved.
//

import UIKit

// Transition types
public enum TransitionType {
    // Presents the screen modally on top of the current viewController
    case present
    
    // Pushes the next screen to the rootViewController of current navigation
    case push
    
    // Replaces the key window's root view controller
    case changeRootController
}

/*
 The Router is a protocol that handles all screen transitions
 */
public protocol Router: class {
    
    /*
     Navigate from your current screen to a new route.
     
     - Parameters:
         + root: The root where the transition happens
         + destination: The destination where the transition ends
         + transition: The transition type that you want to use.
         + animated: Animate the transition or not.
         + completion: Completion handler.
     */
    @discardableResult
    func navigate(from root: AnyScreen?, transitionType: TransitionType, animated: Bool, completion: (() -> Void)?) -> AnyScreen?
}

open class RoutingExecutor {
    
    @discardableResult
    public static func navigate(from root: AnyScreen?, to destination: AnyScreen?, transitionType: TransitionType, animated: Bool = true, completion: (() -> Void)? = nil) -> AnyScreen? {

        switch transitionType {
        case .present:
            if let root = root as? UIViewController,
               let destination = destination as? UIViewController {
                root.present(destination, animated: animated, completion: completion)
            } else {
                fatalError("Both root and destination should be an instance or descendant of UIViewController!")
            }
            
        case .push:
            if let root = root as? UINavigationController,
                let destination = destination as? UIViewController {
                root.pushViewController(destination, animated: animated)
                if let theCompletion = completion {
                    theCompletion()
                }
            } else {
                fatalError("Root should be an instance of UINavigationController & Destination should be an instance of UIViewController!")
            }
            
        case .changeRootController:
            guard
                let destination = destination,
                (destination is UIViewController) else {
                fatalError("Destination should be an instance or descendants of UIViewController")
            }
            
            let keyWindow = UIApplication.shared.keyWindow
            let duration = keyWindow?.rootViewController == nil ? 0 : 0.3
            UIView.animate(withDuration: duration) {
                keyWindow?.rootViewController = (destination as! UIViewController)
                if let theCompletion = completion {
                    theCompletion()
                }
            }
        }
        
        return destination
    }
}
