//
//  RegisterEmailViewModel.swift
//  MVVMBaseProject
//
//  Created by Jacob on 11/15/18.
//  Copyright © 2018 PHDV. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import CodeBase

open class RegisterEmailViewModel: BaseViewModel, TextFieldProtocol {
    
    public var maxLength: Int = 50
    public var minLength: Int = 8
    public var title: String = "register.email.title".localized()
    public var errorMessage: String = "register.email.title".localized()
    public var lengthErrorMessage: String = "register.email.length.is.not.valid".localized()
    
    public var value: BehaviorRelay<String> = BehaviorRelay(value: "")
    public var errorValue: BehaviorRelay<String?> = BehaviorRelay(value: nil)
    
    public func isValid() -> Bool {
        let formatIsValid = self.validateString(self.value.value, pattern: "[A-Z0-9a-z._%+-]+@([A-Za-z0-9.-]{2,64})+\\.[A-Za-z]{2,64}")
        let lengthIsValid = self.validateSize(value: self.value.value, lengthRange: (self.minLength, self.maxLength))
        
        guard formatIsValid else {
            self.errorValue.accept("email.format.is.not.valid".localized())
            return false
        }
        
        guard lengthIsValid else {
            self.errorValue.accept(lengthErrorMessage)
            return false
        }
        
        self.errorValue.accept(nil)
        return true
    }
    
}
