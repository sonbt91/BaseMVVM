//
//  RegisterManager.swift
//  MVVMBaseProject
//
//  Created by Jacob on 11/15/18.
//  Copyright © 2018 PHDV. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import CodeBase
import Moya

enum RegisterType {
    case email
    case socialNetwork(type: SocialType)
}

enum SocialType {
    case facebook
    case google
    case twitter
}

public typealias RegisterResult = (userProfile: Comment?, error: Error?)

open class RegisterManager {
    
    private(set) var registerType: RegisterType = RegisterType.email
    private(set) var emailViewModel: RegisterEmailViewModel!
    private(set) var passwordViewModel: RegisterPasswordViewModel!
    private(set) var registerModel: Register!
    
    // Rx variables
    var disposeBag = DisposeBag()
    
    // To handle loading activity indicator
    var isLoading = BehaviorRelay<Bool>(value: false)
    
    // To capture the result of register task
    public var result = BehaviorRelay<RegisterResult?>(value: nil)
    
    // To capture the format of input
    var inputIsValid = BehaviorRelay<Bool>(value: false)
    
    private let lengthRange: TextFieldLengthRange = (min: 8, max: 20)
    
    convenience init(registerType: RegisterType, emailViewModel: RegisterEmailViewModel, passwordViewModel: RegisterPasswordViewModel, registerModel: Register) {
        self.init()
        
        self.registerType = registerType
        self.emailViewModel = emailViewModel
        self.passwordViewModel = passwordViewModel
        self.registerModel = registerModel
        
        self.startObservering()
    }

    private func startObservering() {
        
        // Start listening changes from email & password view model
        self.emailViewModel.value.asObservable().subscribe(onNext: { [weak self] (_) in
            guard let `self` = self else { return }
            self.inputIsValid.accept(self.formIsValid())
        }).disposed(by: self.disposeBag)
        
        self.passwordViewModel.value.asObservable().subscribe(onNext: { [weak self] (_) in
            guard let `self` = self else { return }
            self.inputIsValid.accept(self.formIsValid())
        }).disposed(by: self.disposeBag)
    }
    
    func formIsValid() -> Bool {
        return (self.emailViewModel.isValid() && self.passwordViewModel.isValid())
    }
    
    func register() {
        
        // Update model
        self.registerModel.email = self.emailViewModel.value.value
        self.registerModel.password = self.passwordViewModel.value.value
        
        // Send request
        self.isLoading.accept(true)
        
        let authenAPI = AuthenAPI.register(model: self.registerModel)
        let request = AuthenAPIProvider.rx.requestGetArray(ofType: Comment.self, authenAPI)
        request.asObservable().subscribe(onNext: { [weak self] (result) in
            self?.isLoading.accept(false)
            if let array = result?.result {
                array.forEach({ (comment) in
                    print(comment.body)
                })
            }
        }).disposed(by: self.disposeBag)
    }
}

extension RegisterManager {
    func update(email: String) {
        self.emailViewModel.value.accept(email)
    }
    
    func update(password: String) {
        self.passwordViewModel.value.accept(password)
    }
}
