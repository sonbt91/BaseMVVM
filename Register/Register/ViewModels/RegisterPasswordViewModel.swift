//
//  RegisterPasswordViewModel.swift
//  MVVMBaseProject
//
//  Created by Jacob on 11/15/18.
//  Copyright © 2018 PHDV. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import CodeBase

open class RegisterPasswordViewModel: BaseViewModel, TextFieldProtocol, SecureTextFieldProtocol {
    
    public var maxLength: Int = 50
    public var minLength: Int = 8
    public let title: String = "register.password.title".localized()
    public let errorMessage: String = "register.password.title".localized()
    public var lengthErrorMessage: String = "register.email.length.is.not.valid".localized()
    
    public var value: BehaviorRelay<String> = BehaviorRelay(value: "")
    public var errorValue: BehaviorRelay<String?> = BehaviorRelay(value: nil)
    
    public func isValid() -> Bool {
        let lengthIsValid = self.validateSize(value: self.value.value, lengthRange: (self.minLength, self.maxLength))
        
        guard lengthIsValid else {
            self.errorValue.accept("password.length.is.not.valid".localized())
            return false
        }
        
        self.errorValue.accept(nil)
        return true
    }
    
    public var isSecureTextEntry: Bool = true
    
    
}
