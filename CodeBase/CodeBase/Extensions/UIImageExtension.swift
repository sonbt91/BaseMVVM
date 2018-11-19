//
//  UIImageExtension.swift
//  CodeBase
//
//  Created by Jacob on 11/16/18.
//  Copyright © 2018 PHDV. All rights reserved.
//

import UIKit

extension UIImage {
    public class func imageFromCodeBase(name: String) -> UIImage? {
        let codeBaseBundle = Bundle(for: BaseViewController.self)
        return UIImage(named: name, in: codeBaseBundle, compatibleWith: nil)
    }
}
