//
//  SetTabBarItemsFlowTransitionConfiguration.swift
//  
//
//  Created by Бабаян Эрнест on 12.04.2021.
//

import UIKit


public func SetTabBarItemsFlow<TabBar, Item>(
    in tabBarControllerBuilder: @escaping @autoclosure () -> TabBar,
    animated: Bool = true,
    configuration: SetTabBarItemsFlowTransitionConfiguration<TabBar, Item>  = .empty,
    items: [Item]
) -> Flow {
    onMainThread {
        let tabBarController = tabBarControllerBuilder()
        
        configuration.prepareHandler?(tabBarController, items)

        tabBarController.setViewControllers(
            items,
            animated: animated
        )

        configuration.completionHandler?(tabBarController, items)
    }
}

public func SetTabBarItemsFlow<TabBar, Item>(
    in tabBarControllerBuilder: @escaping @autoclosure () -> TabBar,
    animated: Bool = true,
    configuration: SetTabBarItemsFlowTransitionConfiguration<TabBar, Item> = .empty,
    items itemBuilders: [Deferred<Item>]
) -> Flow {
    return {
        SetTabBarItemsFlow(
            in: tabBarControllerBuilder(),
            animated: animated,
            configuration: configuration,
            items: itemBuilders.map({ $0() })
        )()
    }
}
