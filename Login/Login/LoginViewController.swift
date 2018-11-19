//
//  LoginViewController.swift
//  MVVMBaseProject
//
//  Created by Jacob on 11/14/18.
//  Copyright © 2018 PHDV. All rights reserved.
//

import UIKit
import CodeBase

class LoginViewController: BaseViewController {
    
    @IBOutlet weak var button: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func setupUIComponents() {
        super.setupUIComponents()
        
        self.title = "login.title".localized()
        self.navigationItem.leftBarButtonItem = self.closeBarButton()
    }

    @IBAction func login(_ sender: Any) {
        
    }
}
