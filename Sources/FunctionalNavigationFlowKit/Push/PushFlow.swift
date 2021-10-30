//
//  PushFlow.swift
//  
//
//  Created by Бабаян Эрнест on 11.04.2021.
//

import UIKit


public func PushFlow<NavigationStack, Item>(
    in navigationControllerBuilder: @escaping @autoclosure Deferred<NavigationStack>,
    animated: Bool = true,
    with configuration: PushFlowConfiguration<NavigationStack, Item> = .empty,
    _ itemBuilder: @autoclosure @escaping Deferred<Item>
) -> Flow {
    onMainThread {
        let navigationController = navigationControllerBuilder()
        let presentingController = itemBuilder()

        configuration.preparationHandler?(navigationController, presentingController)

        navigationController.pushViewController(
            presentingController,
            animated: animated
        )

        configuration.completionHandler?(navigationController, presentingController)
    }
}
