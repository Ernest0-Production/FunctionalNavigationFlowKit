//
//  PopFlow.swift
//  
//
//  Created by Бабаян Эрнест on 12.04.2021.
//

import UIKit


public typealias PopFlowTransitionConfiguration = PushFlowTransitionConfiguration


public func PopFlow<NavigationStack, Item>(
    in navigationController: UINavigationController,
    animated: Bool = true,
    configuration: PopFlowTransitionConfiguration<NavigationStack, Item> = .empty
) -> Flow {
    onMainThread {
        navigationController.popViewController(animated: animated)
    }
}

public func PopFlow<NavigationStack>(
    in navigationController: NavigationStack,
    animated: Bool = true,
    configuration: PopFlowTransitionConfiguration<NavigationStack, UIViewController> = .empty,
    to viewController: UIViewController
) -> Flow {
    onMainThread {
        navigationController.popToViewController(
            viewController,
            animated: animated
        )
    }
}

public func PopToRootFlow<NavigationStack>(
    in navigationController: UINavigationController,
    animated: Bool = true,
    configuration: PopFlowTransitionConfiguration<NavigationStack, UIViewController> = .empty
) -> Flow {
    onMainThread {
        navigationController.popToRootViewController(animated: animated)
    }
}
