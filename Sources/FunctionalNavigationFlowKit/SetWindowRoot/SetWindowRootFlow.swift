//
//  SetWindowRootFlow.swift
//  
//
//  Created by Бабаян Эрнест on 11.04.2021.
//

import UIKit


public func SetWindowRootFlow<Window, Root>(
    in windowBuilder: @escaping @autoclosure Deferred<Window>,
    with configuration: SetWindowRootFlowConfiguration<Window, Root> = .empty,
    _ rootBuilder: @autoclosure @escaping Deferred<Root>
) -> Flow {
    onMainThread {
        let window = windowBuilder()
        let root = rootBuilder()

        configuration.preparationHandler?(window, root)

        window.rootViewController = root

        configuration.completionHandler?(window, root)
    }
}
