//
//  PushFlow.swift
//  
//
//  Created by Бабаян Эрнест on 11.04.2021.
//

import UIKit


public func PushFlow<NavigationStack, Item>(
    in navigationControllerBuilder: @escaping @autoclosure () -> NavigationStack,
    animated: Bool = true,
    configuration: PushFlowTransitionConfiguration<NavigationStack, Item> = .empty,
    _ itemBuilder: @escaping Deferred<Item>
) -> Flow {
    onMainThread {
        let navigationController = navigationControllerBuilder()
        let presentingController = itemBuilder()

        configuration.prepareHandler?(navigationController, presentingController)

        navigationController.pushViewController(
            presentingController,
            animated: animated
        )

        configuration.completionHandler?(navigationController, presentingController)
    }
}

public func PushFlow<NavigationStack, Item>(
    in navigationControllerBuilder: @escaping @autoclosure () -> NavigationStack,
    animated: Bool = true,
    configuration: PushFlowTransitionConfiguration<NavigationStack, Item> = .empty,
    _ autoclosure_itemBuilder: @autoclosure @escaping Deferred<Item>
) -> Flow {
    PushFlow(
        in: navigationControllerBuilder(),
        animated: animated,
        configuration: configuration,
        autoclosure_itemBuilder
    )
}
