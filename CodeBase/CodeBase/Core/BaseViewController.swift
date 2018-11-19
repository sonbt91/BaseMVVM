//
//  BaseViewController.swift
//  MVVMBaseProject
//
//  Created by Jacob on 11/14/18.
//  Copyright © 2018 PHDV. All rights reserved.
//

import UIKit
import RxSwift

func classDomain<T>(_ object: T.Type) -> String {
    return String(describing: object)
}

open class BaseViewController: UIViewController {
    
    // Rx Variables
    public let disposeBag = DisposeBag()
    
    open class func initFromDefaultXib() -> UIViewController {
        let className = NSStringFromClass(self) as NSString
        let nibName = className.pathExtension
        let bundle = Bundle.init(for: self.classForCoder())

        return self.init(nibName: nibName, bundle: bundle)
    }
    
    required override public init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override open var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUIComponents()
        self.initializeObjects()
    }
    
    open func initializeObjects() {
        // Where variables, objects will be initialized
    }
    
    open func setupUIComponents() {
        // Where UI components will be polished
    }
    
    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.view.endEditing(true)
    }
    
    deinit {
        print("deinit \(NSStringFromClass(type(of: self)))")
        NotificationCenter.default.removeObserver(self)
    }
}

extension BaseViewController {
    
    class func controller<T: UIViewController>(from storyboard: String, storyboardID: String? = nil) -> T {
        let storyboard = UIStoryboard(name: storyboard, bundle: nil)
        if let identifier = storyboardID {
            return storyboard.instantiateViewController(withIdentifier: identifier) as! T
        }
        return storyboard.instantiateViewController(withIdentifier:classDomain(T.self)) as! T
    }
    
    open func handle(_ error: Error) {
        self.handle(error, onDismissAlert: nil)
    }
    
    open func handle(_ error: Error, onDismissAlert: (() -> Void)?) {
        AlertManager.shared.show(Constant.AppName, message: error.localizedDescription, buttons: [Constant.AlertDismissButtonTitle]) { (_, _) in
            if let onDismissCallback = onDismissAlert {
                onDismissCallback()
            }
        }
    }
    
    open func backBarButton() -> UIBarButtonItem {
        
        let button = UIButton.init(type: .custom)
        button.frame = CGRect(x: 0, y: 0, width: 32, height: 32)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 10)
        button.addTarget(self, action: #selector(self.backOrDismiss), for: .touchUpInside)
        button.setImage( UIImage.imageFromCodeBase(name: "navigation_arrowBack")?.withRenderingMode(.alwaysOriginal), for: .normal)
        let barButtonItem = UIBarButtonItem(customView: button)
        
        return barButtonItem
    }
    
    open func cancelBarButton() -> UIBarButtonItem {
        let button = UIButton.init(type: .custom)
        button.frame = CGRect(x: 0, y: 0, width: 50, height: 32)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 10)
        button.addTarget(self, action: #selector(self.backOrDismiss), for: .touchUpInside)
        button.setTitle("barbutton.cancel.title".localized(), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.lightGray, for: .highlighted)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.contentHorizontalAlignment = .left
        let barButtonItem = UIBarButtonItem(customView: button)
        
        return barButtonItem
    }
    
    open func closeBarButton() -> UIBarButtonItem {
        
        let button = UIButton.init(type: .custom)
        button.frame = CGRect(x: 0, y: 0, width: 32, height: 32)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 10)
        button.addTarget(self, action: #selector(self.backOrDismiss), for: .touchUpInside)
        button.setImage(UIImage.imageFromCodeBase(name: "close")?.withRenderingMode(.alwaysOriginal), for: .normal)
        let barButtonItem = UIBarButtonItem(customView: button)
        
        return barButtonItem
    }
    
    open func backOrCloseBarButton() -> UIBarButtonItem {
        if let count = self.navigationController?.viewControllers.count, count > 1 {
            return self.backBarButton()
        } else {
            return self.closeBarButton()
        }
    }
    
    @objc open func backOrDismiss() -> Void {
        if let count = self.navigationController?.viewControllers.count, count > 1 {
            _ = self.navigationController?.popViewController(animated: true)
        } else {
            self.dismiss(animated: true, completion: {
                LogDebug("Dismiss viewcontroller")
            })
        }
    }
    
    // Add a child view controller, its whole view is embeded in the containerView
    open func addController(controller: UIViewController, containerView: UIView) {
        addChild(controller)
        controller.view.frame = CGRect.init(origin: .zero, size: containerView.frame.size)
        controller.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        containerView.addSubview(controller.view)
        controller.didMove(toParent: self)
    }
    
    // To remove the current child view controller
    public func removeController(controller: UIViewController, containerView: UIView) {
        controller.willMove(toParent: nil)
        controller.removeFromParent()
        controller.view.removeFromSuperview()
        controller.didMove(toParent: nil)
    }
}

extension UIViewController {
    class open func topMostViewController() -> UIViewController? {
        return UIViewController.topViewControllerForRoot(rootViewController: UIApplication.shared.keyWindow?.rootViewController)
    }
    
    class open func topViewControllerForRoot(rootViewController:UIViewController?) -> UIViewController? {
        guard let rootViewController = rootViewController else {
            return nil
        }
        
        if rootViewController is UINavigationController {
            let navigationController:UINavigationController = rootViewController as! UINavigationController
            return UIViewController.topViewControllerForRoot(rootViewController: navigationController.viewControllers.last)
            
        } else if rootViewController is UITabBarController {
            let tabBarController:UITabBarController = rootViewController as! UITabBarController
            return UIViewController.topViewControllerForRoot(rootViewController: tabBarController.selectedViewController)
            
        } else if rootViewController.presentedViewController != nil {
            return UIViewController.topViewControllerForRoot(rootViewController: rootViewController.presentedViewController)
        } else {
            return rootViewController
        }
    }
}
