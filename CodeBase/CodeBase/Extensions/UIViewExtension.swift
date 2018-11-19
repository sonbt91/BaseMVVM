//
//  UIViewExtension.swift
//  MVVMBaseProject
//
//  Created by Jacob on 11/15/18.
//  Copyright © 2018 PHDV. All rights reserved.
//

import UIKit

extension UIView {
    class func loadFromNib(named name: String, bundle: Bundle? = nil) -> UIView? {
        return UINib(nibName: name, bundle: bundle).instantiate(withOwner: nil, options: nil)[0] as? UIView
    }
    
    class func loadFromNib<T: UIView>() -> T {
        let nibName = "\(self)".split { $0 == "." }.map(String.init).last!
        let nib = UINib(nibName: nibName, bundle: nil)
        return nib.instantiate(withOwner: self, options: nil).first as! T
    }
    
    class func getNib() -> UINib? {
        let bundle = Bundle.init(for: self.classForCoder())
        return UINib(nibName: self.nibName(), bundle: bundle)
    }
    
    private static func nibName() -> String {
        let nameSpaceClassName = NSStringFromClass(self)
        let className = nameSpaceClassName.components(separatedBy: ".").last! as String
        return className
    }
    
    func border(borderWidth:CGFloat, cornerRadius:CGFloat, borderColor:UIColor) {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = cornerRadius
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
    }
    
    func circleBorder() {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = self.frame.size.height/2
    }
    
    func removeBorderIfNeeded() {
        self.layer.masksToBounds = false
        self.layer.borderColor = UIColor.clear.cgColor
    }
    
    func animate(withTransform transforms: CGAffineTransform, duration: TimeInterval = 2.0, delay: TimeInterval = 0.0, springWithDamping: CGFloat = 0.20, springVelocity: CGFloat = 6.0, options: UIView.AnimationOptions = .allowUserInteraction){
        self.transform = transforms
        UIView.animate(withDuration: duration,
                       delay: delay,
                       usingSpringWithDamping: springWithDamping,
                       initialSpringVelocity: springVelocity,
                       options: options,
                       animations: {
                        self.transform = CGAffineTransform.identity
        },
                       completion: { Void in()  }
        )
    }
}
