//
//  File.swift
//  
//
//  Created by Ernest Babayan on 29.10.2021.
//

#if canImport(UIKit)
import UIKit


public protocol UIViewControllerFlowExtensions {}

extension UIViewController: UIViewControllerFlowExtensions {}

public extension UIViewControllerFlowExtensions where Self: UIViewController {
    /// Execute passed flow and return self.
    ///
    /// - Parameter flowFactory: flow build to be executed.
    ///
    /// - Returns: This instance of the view controller.
    func withFlow(_ flowFactory: (Self) -> Flow) -> Self {
        flowFactory(self).execute()
        return self
    }
}
#endif
