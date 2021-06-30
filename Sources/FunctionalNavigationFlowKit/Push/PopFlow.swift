//
//  PopFlow.swift
//  
//
//  Created by Бабаян Эрнест on 12.04.2021.
//

import UIKit


public typealias PopFlowTransitionConfiguration = PushFlowTransitionConfiguration


public func PopFlow<NavigationStack>(
    in navigationController: NavigationStack,
    animated: Bool = true,
    configuration: PopFlowTransitionConfiguration<NavigationStack, UIViewController> = .empty
) -> Flow {
    onMainThread {
        navigationController.popViewController(animated: animated)
    }
}

public func PopFlow<NavigationStack, Item>(
    in navigationController: NavigationStack,
    animated: Bool = true,
    configuration: PopFlowTransitionConfiguration<NavigationStack, Item> = .empty,
    to viewControllerBuilder: @escaping @autoclosure Deferred<Item>
) -> Flow {
    onMainThread {
        navigationController.popToViewController(
            viewControllerBuilder(),
            animated: animated
        )
    }
}

public func PopToRootFlow<NavigationStack>(
    in navigationController: NavigationStack,
    animated: Bool = true,
    configuration: PopFlowTransitionConfiguration<NavigationStack, UIViewController> = .empty
) -> Flow {
    onMainThread {
        navigationController.popToRootViewController(animated: animated)
    }
}
