//
//  PushFlow.swift
//  
//
//  Created by Бабаян Эрнест on 11.04.2021.
//

import UIKit


public func PushFlow<NavigationStack, Item>(
    in navigationController: NavigationStack,
    animated: Bool = true,
    configuration: PushFlowTransitionConfiguration<NavigationStack, Item> = .empty,
    _ itemBuilder: @escaping Deferred<Item>
) -> Flow {
    onMainThread {
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
    in navigationController: NavigationStack,
    animated: Bool = true,
    configuration: PushFlowTransitionConfiguration<NavigationStack, Item> = .empty,
    _ autoclosure_itemBuilder: @autoclosure @escaping Deferred<Item>
) -> Flow {
    PushFlow(
        in: navigationController,
        animated: animated,
        configuration: configuration,
        autoclosure_itemBuilder
    )
}

public func PushFlow<Dependency, NavigationStack, Item>(
    in navigationController: NavigationStack,
    animated: Bool = true,
    configuration: PushFlowTransitionConfiguration<NavigationStack, Item> = .empty,
    _ itemBuilder: @escaping (Dependency) -> Item
) -> (Dependency) -> Flow {
    return { (dependency: Dependency) in
        PushFlow(
            in: navigationController,
            animated: animated,
            configuration: configuration,
            itemBuilder(dependency)
        )
    }
}
