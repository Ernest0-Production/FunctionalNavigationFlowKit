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
    configuration: SetTabBarItemsFlowTransitionConfiguration<TabBar, Item>,
    _ itemBuilders: [Deferred<Item>]
) -> Flow {
    onMainThread {
        let viewControllers = itemBuilders.map({ $0() })

        configuration.handler(tabBarController, viewControllers)

        tabBarController.setViewControllers(
            viewControllers,
            animated: animated
        )
    }
}

public func SetTabBarItemsFlow<TabBar, Item>(
    in tabBarController: TabBar,
    animated: Bool = true,
    configuration: SetTabBarItemsFlowTransitionConfiguration<TabBar, Item>,
    _ items: [Item]
) -> Flow {
    SetTabBarItemsFlow(
        in: tabBarController,
        animated: animated,
        configuration: configuration,
        items.map({ item in { item } })
    )
}

