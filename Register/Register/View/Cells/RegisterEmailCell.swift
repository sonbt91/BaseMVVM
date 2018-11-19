//
//  RegisterEmailCell.swift
//  MVVMBaseProject
//
//  Created by Jacob on 11/15/18.
//  Copyright © 2018 PHDV. All rights reserved.
//

import UIKit
import RxSwift
import CodeBase

class RegisterEmailCell: TableViewCell {

    @IBOutlet weak var emailTextField: BaseTextField!
    
    var registerManager: RegisterManager! {
        didSet {
//            emailTextField.rx.text.orEmpty.bind(to: registerManager.emailViewModel.value).disposed(by: registerManager.disposeBag)
        }
    }
    
    override open func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override open func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

extension RegisterEmailCell: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let newString = currentText.replacingCharacters(in: stringRange, with: string).trim()
        if newString.count > self.registerManager.emailViewModel.maxLength {
            AlertManager.shared.show(Constant.AppName, message: self.registerManager.emailViewModel.lengthErrorMessage, buttons: [Constant.AlertDismissButtonTitle], tapBlock: { [weak self] (_, _) in
                self?.emailTextField.becomeFirstResponder()
            })
            return false
        }
        
        self.registerManager.update(email: newString)
        return true
    }
    
    private func textFieldShouldClear(_ textField: UITextField) -> Bool {
        // Clear all
        return true
    }
}
