//
//  RegisterPasswordCell.swift
//  MVVMBaseProject
//
//  Created by Jacob on 11/15/18.
//  Copyright © 2018 PHDV. All rights reserved.
//

import UIKit
import RxSwift
import CodeBase

class RegisterPasswordCell: TableViewCell {

    @IBOutlet weak var passwordTextField: BaseTextField!
    
    var registerManager: RegisterManager! {
        didSet {
//            passwordTextField.rx.text.orEmpty.bind(to: registerManager.passwordViewModel.value).disposed(by: registerManager.disposeBag)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

extension RegisterPasswordCell: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let newString = currentText.replacingCharacters(in: stringRange, with: string).trim()
        if newString.count > self.registerManager.emailViewModel.maxLength {
            AlertManager.shared.show(Constant.AppName, message: self.registerManager.passwordViewModel.lengthErrorMessage, buttons: [Constant.AlertDismissButtonTitle], tapBlock: { [weak self] (_, _) in
                self?.passwordTextField.becomeFirstResponder()
            })
            return false
        }
        
        self.registerManager.update(password: newString)
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        // Clear all
        return true
    }
}

