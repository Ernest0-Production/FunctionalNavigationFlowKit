//
//  SetWindowRootFlow.swift
//  
//
//  Created by Бабаян Эрнест on 11.04.2021.
//

import UIKit


public typealias SetWindowRootFlowTransitionConfiguration<
    Window: UIWindow,
    Root: UIViewController
> = FlowConfiguration<Window, Root>


public func SetWindowRootFlow<Window, Root>(
    in window: Window,
    configuration: SetWindowRootFlowTransitionConfiguration<Window, Root> = .empty,
    _ rootBuilder: @escaping Deferred<Root>
) -> Flow {
    onMainThread {
        let root = rootBuilder()

        configuration.handler(window, root)

        window.rootViewController = root
        window.makeKeyAndVisible()
    }
}

public func SetWindowRootFlow<Window, Root>(
    in window: Window,
    configuration: SetWindowRootFlowTransitionConfiguration<Window, Root> = .empty,
    _ autoclosure_rootBuilder: @autoclosure @escaping Deferred<Root>
) -> Flow {
    SetWindowRootFlow(
        in: window,
        configuration: configuration,
        autoclosure_rootBuilder
    )
}

public func SetWindowRootFlow<Dependency, Window, Root>(
    in window: Window,
    configuration: SetWindowRootFlowTransitionConfiguration<Window, Root> = .empty,
    _ rootBuilder: @escaping (Dependency) -> Root
) -> (Dependency) -> Flow {
    return { (dependency: Dependency) in
        SetWindowRootFlow(
            in: window,
            configuration: configuration,
            rootBuilder(dependency)
        )
    }
}
