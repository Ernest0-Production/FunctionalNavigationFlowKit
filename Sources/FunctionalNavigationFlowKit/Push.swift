//
//  Push.swift
//  
//
//  Created by Бабаян Эрнест on 11.04.2021.
//

import UIKit


public func PushFlow(
    in navigationController: UINavigationController,
    animated: Bool = true,
    _ controller: UIViewController
) -> Flow {
    onMainThread {
        navigationController.pushViewController(controller, animated: animated)
    }
}

// MARK: - Deferred

public func DeferredPushFlow(
    in navigationController: UINavigationController,
    animated: Bool = true,
    _ viewControllerBuilder: @escaping ViewControllerBuilder
) -> Flow {
    return {
        PushFlow(
            in: navigationController,
            animated: animated,
            viewControllerBuilder()
        )()
    }
}

public func DeferredPushFlow(
    in navigationController: UINavigationController,
    animated: Bool = true,
    _ viewControllerBuilder: @autoclosure @escaping ViewControllerBuilder
) -> Flow {
    return {
        PushFlow(
            in: navigationController,
            animated: animated,
            viewControllerBuilder()
        )()
    }
}

public func DeferredPushFlow<Dependency>(
    in navigationController: UINavigationController,
    animated: Bool = true,
    _ viewControllerBuilder: @escaping ViewControllerBuilderWith<Dependency>
) -> FlowBuilderWith<Dependency> {
    return { (input: Dependency) in
        DeferredPushFlow(
            in: navigationController,
            animated: animated,
            { viewControllerBuilder(input) }
        )
    }
}
