//
//  RoundedCornerButton.swift
//  MVVMBaseProject
//
//  Created by Jacob on 11/15/18.
//  Copyright © 2018 PHDV. All rights reserved.
//

import UIKit
import SnapKit

@IBDesignable open class RoundedCornerButton: UIButton {
    
    @IBInspectable open var corner: CGFloat = 5
    @IBInspectable open var border: CGFloat = 0
    @IBInspectable open var borderColor: UIColor?
    @IBInspectable open var borderAlpha: CGFloat = 1.0
    
    open var loadingActivity: UIActivityIndicatorView? = nil
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    override open func draw(_ rect: CGRect) {
        self.layer.cornerRadius = corner
        self.layer.borderWidth = border
        self.layer.masksToBounds = true
        guard let color = borderColor else {
            self.layer.borderWidth = 0
            return
        }
        self.layer.borderColor = color.withAlphaComponent(borderAlpha).cgColor
    }
    
    public func setup() {
        self.border(borderWidth: 0, cornerRadius: 5, borderColor: UIColor.clear)
        loadingActivity = UIActivityIndicatorView(style: .white)
        loadingActivity?.hidesWhenStopped = true
        loadingActivity?.stopAnimating()
        self.addSubview(loadingActivity!)
        loadingActivity?.snp.makeConstraints({ [weak self] (make) in
            guard let `self` = self else { return }
            make.center.equalTo(self)
        })
        self.titleLabel?.adjustsFontSizeToFitWidth = true
    }
    
    public func showLoading() {
        self.isUserInteractionEnabled = false
        loadingActivity?.startAnimating()
        self.titleLabel?.removeFromSuperview()
    }
    
    public func hideLoading() {
        self.isUserInteractionEnabled = true
        loadingActivity?.stopAnimating()
        self.addSubview(self.titleLabel!)
    }
    
    public func disable() {
        self.isUserInteractionEnabled = false
        self.alpha = 0.5
    }
    
    public func enable() {
        self.isUserInteractionEnabled = true
        self.alpha = 1
    }
}
