//
//  MainLoginViewController.swift
//  MVVMBaseProject
//
//  Created by Jacob on 11/16/18.
//  Copyright © 2018 PHDV. All rights reserved.
//

import UIKit
import CodeBase
import Register
import Login

open class MainLoginViewController: BaseViewController {
    
    @IBOutlet weak var headerImageView: UIImageView!
    
    override open var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override open func setupUIComponents() {
        super.setupUIComponents()
        
        self.headerImageView.image = UIImage.imageFromCodeBase(name: "pizza-icon")
    }
    
    @IBAction private func register(_ sender: Any) {
        
        guard let registerViewController = RegisterRouter().navigate(from: self, transitionType: .present, animated: true, completion: nil) as? RegisterViewController else { return  }
        
        // Capture & handle result of register flow
        let registerManager = registerViewController.registerManager
        registerManager.result.asObservable().subscribe(onNext: { (result) in
            if let userProfile = result?.userProfile {
                LogDebug(userProfile.name)
                AlertManager.shared.show(Constant.AppName, message: "regsiter.success.message".localized(), buttons: [Constant.AlertDismissButtonTitle], tapBlock: { (_, _) in
                    registerViewController.backOrDismiss()
                })
            } else if let error = result?.error {
                self.handle(error, onDismissAlert: nil)
            }
        }).disposed(by: self.disposeBag)
    }
    
    @IBAction private func login(_ sender: Any) {
        
        LoginRouter().navigate(from: self, transitionType: .present, animated: true, completion: nil)
    }
}
