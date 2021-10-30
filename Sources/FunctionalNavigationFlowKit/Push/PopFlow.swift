//
//  PopFlow.swift
//  
//
//  Created by Бабаян Эрнест on 12.04.2021.
//

import UIKit


public typealias PopFlowConfiguration<
    NavigationStack: UINavigationController,
    Item: UIViewController
> = FlowConfiguration<NavigationStack, Item?>


public func PopFlow<NavigationStack>(
    in navigationControllerBuilder: @escaping @autoclosure Deferred<NavigationStack>,
    animated: Bool = true,
    with configuration: PopFlowConfiguration<NavigationStack, UIViewController> = .empty
) -> Flow {
    onMainThread {
        let navigationController = navigationControllerBuilder()
        configuration.preparationHandler?(navigationController, navigationController.topViewController)

        navigationController.popViewController(animated: animated)

        configuration.completionHandler?(navigationController, navigationController.topViewController)
    }
}

public func PopFlow<NavigationStack, Item>(
    in navigationControllerBuilder: @escaping @autoclosure Deferred<NavigationStack>,
    animated: Bool = true,
    with configuration: PopFlowConfiguration<NavigationStack, Item> = .empty,
    to viewControllerBuilder: @escaping @autoclosure Deferred<Item>
) -> Flow {
    onMainThread {
        let navigationController = navigationControllerBuilder()
        let viewController = viewControllerBuilder()

        configuration.preparationHandler?(navigationController, viewController)

        navigationController.popToViewController(
            viewControllerBuilder(),
            animated: animated
        )

        configuration.completionHandler?(navigationController, viewController)
    }
}

public func PopToRootFlow<NavigationStack>(
    in navigationControllerBuilder: @escaping @autoclosure Deferred<NavigationStack>,
    animated: Bool = true,
    with configuration: PopFlowConfiguration<NavigationStack, UIViewController> = .empty
) -> Flow {
    onMainThread {
        let navigationController = navigationControllerBuilder()
        let viewController = navigationController.viewControllers.first
        
        configuration.preparationHandler?(navigationController, viewController)

        navigationController.popToRootViewController(animated: animated)

        configuration.completionHandler?(navigationController, viewController)
    }
}
