//
//  File.swift
//  
//
//  Created by Ernest Babayan on 01.07.2021.
//

import UIKit


public extension UIViewController {
    /// Return presentedViewController specified nesting.
    ///
    /// If the nesting level is less than the specified one, it will return the topmost presentedСontroller.
    ///
    /// if current presentedViewController is nil, return self.
    ///
    ///
    /// **Level parameter**:
    /// - 0 - self
    ///
    /// - 1 - self.presentedViewController ?? self
    ///
    /// - 2 - self.presentedViewController?.presentedViewController ?? self.presentedViewController ?? self
    /// - etc.
    func presentedViewController(level: UInt) -> UIViewController {
        if level == .zero {
            return self
        }
        
        guard let presentedViewController = presentedViewController else {
            print("[FunctionalNavigationFlowKit] ⚠️ There is no presentedController of the specified level")
            return self
        }
        
        return presentedViewController.presentedViewController(level: level - 1)
    }
}
