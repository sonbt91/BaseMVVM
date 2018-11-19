//
//  BaseTextField.swift
//  MVVMBaseProject
//
//  Created by Jacob on 11/15/18.
//  Copyright © 2018 PHDV. All rights reserved.
//

import UIKit

open class BaseTextField: UITextField {

    @IBInspectable var inset: CGFloat = 13.0
    
    override open func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.rightViewRect(forBounds: bounds)
        rect.origin.x -= self.inset
        return rect
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.editingRect(forBounds: bounds)
        rect.origin.x += self.inset
        return rect
    }
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.textRect(forBounds: bounds)
        rect.origin.x += self.inset
        return rect
    }
    
    override open func drawText(in rect: CGRect) {
        super.drawText(in: rect)
        
        if #available(iOS 9.0, *) {
            let item : UITextInputAssistantItem = self.inputAssistantItem
            item.leadingBarButtonGroups = []
            item.trailingBarButtonGroups = []
        }
    }

}
