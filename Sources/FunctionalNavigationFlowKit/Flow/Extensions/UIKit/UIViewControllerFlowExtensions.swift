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
    func withFlow(_ flowFactory: (Self) -> Flow) -> Self {
        flowFactory(self).execute()
        return self
    }
}
#endif
