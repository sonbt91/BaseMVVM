//
//  TextFieldProtocols.swift
//  MVVMBaseProject
//
//  Created by Jacob on 11/15/18.
//  Copyright © 2018 PHDV. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

public protocol TextFieldProtocol {
    
    // Variables:
    // minLength: min length of entry text, optional most of cases
    // maxLength: max length of entry text
    // title: to say what is the name of the field
    // errorMessage: to say the error message
    
    var minLength: Int { get }
    var maxLength: Int { get }
    var title: String { get }
    var errorMessage: String { get }
    var lengthErrorMessage: String { get }
    
    // Observables
    // value: the content/text of the field
    // errorValue: the error value in string
    var value: BehaviorRelay<String> { get set }
    var errorValue: BehaviorRelay<String?> { get set}
    
    // Validation
    func isValid() -> Bool
}

public extension TextFieldProtocol {
    
    // Used to validate length of text
    public func validateSize(value: String, lengthRange: TextFieldLengthRange) -> Bool {
        return (value.count >= lengthRange.min && value.count <= lengthRange.max)
    }
    
    // Used to validate format of text in a certain pattern
    public func validateString(_ value: String?, pattern: String) -> Bool {
        let test = NSPredicate(format:"SELF MATCHES %@", pattern)
        return test.evaluate(with: value)
    }
}

// Options for FieldViewModel
public protocol SecureTextFieldProtocol {
    var isSecureTextEntry: Bool { get }
}
