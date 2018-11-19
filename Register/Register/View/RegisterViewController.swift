//
//  RegisterViewController.swift
//  MVVMBaseProject
//
//  Created by Jacob on 11/14/18.
//  Copyright © 2018 PHDV. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import CodeBase

open class RegisterViewController: BaseViewController {

    // Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var registerButton: RoundedCornerButton!
    
    public let registerManager = RegisterManager.init(registerType: .email, emailViewModel: RegisterEmailViewModel(), passwordViewModel: RegisterPasswordViewModel(), registerModel: Register())
    
    override open func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override open func setupUIComponents() {
        super.setupUIComponents()
        
        self.title = "register.title".localized()
        self.navigationItem.leftBarButtonItem = self.closeBarButton()
        
        self.tableView.tableFooterView = UIView()
        for cell in [RegisterHeaderCell.self, RegisterEmailCell.self, RegisterPasswordCell.self] {
            cell.registerFor(self.tableView)
        }
    }
    
    override open func initializeObjects() {
        super.initializeObjects()
        
        self.hanldeRegisterProcess()
    }
    
    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let emailCell = self.tableView.cellForRow(at: IndexPath(row: 0, section: 1)) as? RegisterEmailCell {
            emailCell.emailTextField.becomeFirstResponder()
        }
    }
    
    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.view.endEditing(true)
    }
    
    private func hanldeRegisterProcess() {
        // Capture all observable variable from RegisterManager
        // Data validation, to enable/disable register button
        self.registerManager.inputIsValid.asObservable().subscribe(onNext: { [weak self] (isValid) in
            if isValid {
                self?.registerButton.enable()
            } else {
                self?.registerButton.disable()
            }
        }).disposed(by: self.disposeBag)
        
        // Loading
        self.registerManager.isLoading.asObservable().subscribe(onNext: { [weak self] (needLoading) in
            if needLoading {
                self?.registerButton.showLoading()
            } else {
                self?.registerButton.hideLoading()
            }
        }).disposed(by: self.disposeBag)
        
        // Result
//        self.registerManager.result.asObservable().subscribe(onNext: { (result) in
//            if let userProfile = result?.userProfile {
//                LogDebug(userProfile.name)
//                AlertManager.shared.show(Constant.AppName, message: "regsiter.success.message".localized(), buttons: [Constant.AlertDismissButtonTitle], tapBlock: { [weak self]  (_, _) in
//                    self?.backOrDismiss()
//                })
//            } else if let error = result?.error {
//                self.handle(error, onDismissAlert: { [weak self] in
//                    self?.backOrDismiss()
//                })
//            }
//        }).disposed(by: self.disposeBag)
    }

    // MARK: - Actions
    @IBAction private func register(_ sender: AnyObject) {
        self.registerManager.register()
    }
}

extension RegisterViewController: UITableViewDelegate, UITableViewDataSource {
    
    //MARK: UITableViewDataSource
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch (indexPath.section, indexPath.row) {
        case (0, 0):
            guard let cell = RegisterHeaderCell.dequeue(tableView, indexPath) as? RegisterHeaderCell else { return UITableViewCell() }
            return cell
        case (1, 0):
            guard let cell = RegisterEmailCell.dequeue(tableView, indexPath) as? RegisterEmailCell else { return UITableViewCell() }
            cell.registerManager = self.registerManager
            return cell
        case (2, 0):
            guard let cell = RegisterPasswordCell.dequeue(tableView, indexPath) as? RegisterPasswordCell else { return UITableViewCell() }
            cell.registerManager = self.registerManager
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    //MARK: UITableViewDelegate
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch (indexPath.section, indexPath.row) {
        case (0, 0):
            return 140
        case (1, 0):
            return 70
        case (2, 0):
            return 70
        default:
            return 0
        }
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 15
    }
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.size.width, height: 15))
        return headerView
    }
}
