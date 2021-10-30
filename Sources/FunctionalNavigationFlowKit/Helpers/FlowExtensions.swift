//
//  File.swift
//  
//
//  Created by Ernest Babayan on 30.10.2021.
//

public protocol FlowExtensions {}

public extension FlowExtensions {
    func withFlow(_ flowBuilder: (Self) -> Flow) -> Self {
        flowBuilder(self)()
        return self
    }
}

import UIKit
extension UIViewController: FlowExtensions {}
