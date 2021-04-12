//
//  SetTabBarItemsFlowTransitionConfiguration.swift
//  
//
//  Created by Бабаян Эрнест on 12.04.2021.
//

import UIKit


public typealias SetTabBarItemsFlowTransitionConfiguration<
    TabBar: UITabBarController,
    Item: UIViewController
> = FlowConfiguration<TabBar, [Item]>


public func SetTabBarItemsFlow<TabBar, Item>(
    in tabBarController: TabBar,
    animated: Bool = true,
    configuration: SetTabBarItemsFlowTransitionConfiguration<TabBar, Item>  = .empty,
    items: [Item]
) -> Flow {
    onMainThread {
        configuration.prepareHandler?(tabBarController, items)

        tabBarController.setViewControllers(
            items,
            animated: animated
        )

        configuration.completionHandler?(tabBarController, items)
    }
}


public func SetTabBarItemsFlow<TabBar, Item>(
    in tabBarController: TabBar,
    animated: Bool = true,
    configuration: SetTabBarItemsFlowTransitionConfiguration<TabBar, Item> = .empty,
    items itemBuilders: [Deferred<Item>]
) -> Flow {
    return {
        SetTabBarItemsFlow(
            in: tabBarController,
            animated: animated,
            configuration: configuration,
            items: itemBuilders.map({ $0() })
        )()
    }
}
