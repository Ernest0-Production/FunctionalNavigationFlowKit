//
//  SetWindowRootFlow.swift
//  
//
//  Created by Бабаян Эрнест on 11.04.2021.
//

import UIKit



public func SetWindowRootFlow<Window, Root>(
    in windowBuilder: @escaping @autoclosure () -> Window,
    configuration: SetWindowRootFlowTransitionConfiguration<Window, Root> = .empty,
    _ rootBuilder: @escaping Deferred<Root>
) -> Flow {
    onMainThread {
        let window = windowBuilder()
        let root = rootBuilder()

        configuration.prepareHandler?(window, root)

        window.rootViewController = root

        configuration.completionHandler?(window, root)
    }
}

public func SetWindowRootFlow<Window, Root>(
    in windowBuilder: @escaping @autoclosure () -> Window,
    configuration: SetWindowRootFlowTransitionConfiguration<Window, Root> = .empty,
    _ autoclosure_rootBuilder: @autoclosure @escaping Deferred<Root>
) -> Flow {
    SetWindowRootFlow(
        in: windowBuilder(),
        configuration: configuration,
        autoclosure_rootBuilder
    )
}
