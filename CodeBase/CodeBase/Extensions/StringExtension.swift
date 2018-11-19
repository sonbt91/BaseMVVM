//
//  StringExtension.swift
//  MVVMBaseProject
//
//  Created by Jacob on 11/14/18.
//  Copyright © 2018 PHDV. All rights reserved.
//

import UIKit

extension String {
    
    public func localized() -> String {
        return NSLocalizedString(self, comment: "")
    }
    
    /*
     Triming white space from start and end of the string
     */
    public func trim() -> String {
        return trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
    public func contains(_ s: String) -> Bool {
        return (self.range(of: s) != nil) ? true : false
    }
    
    public func replace(_ target: String, withString: String) -> String {
        return self.replacingOccurrences(of: target, with: withString, options: NSString.CompareOptions.literal, range: nil)
    }
}
/**
 * String file path processing
 */
extension String {
    public var lastPathComponent: String {
        return (self as NSString).lastPathComponent
    }
    
    public var stringByDeletingLastPathComponent: String {
        return (self as NSString).deletingLastPathComponent
    }
    
    public func appendingPathComponent(_ str: String) -> String {
        return (self as NSString).appendingPathComponent(str)
    }
    
    public var pathExtension: String {
        return (self as NSString).pathExtension
    }
    
    public var deletingPathExtension: String {
        return (self as NSString).deletingPathExtension
    }
    
    public func appendingPathExtension(_ str: String) -> String? {
        return (self as NSString).appendingPathExtension(str)
    }
}

/**
 * String is number only
 */
extension String {
    public var isNumeric: Bool {
        guard self.count > 0 else {
            return false
        }
        let nums: Set<Character> = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
        return Set(self).isSubset(of: nums)
    }
}
