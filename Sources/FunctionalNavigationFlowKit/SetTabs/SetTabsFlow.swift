//
//  SetTabBarItemsFlowConfiguration.swift
//  
//
//  Created by Бабаян Эрнест on 12.04.2021.
//

import UIKit


public func SetTabsFlow<TabBar, Tab>(
    in tabBarControllerBuilder: @escaping @autoclosure Deferred<TabBar>,
    animated: Bool = true,
    with configuration: SetTabsFlowConfiguration<TabBar, Tab>  = .empty,
    _ tabsBuilder: @autoclosure @escaping Deferred<[Tab]>
) -> Flow {
    onMainThread {
        let tabBarController = tabBarControllerBuilder()
        let tabs = tabsBuilder()

        configuration.preparationHandler?(tabBarController, tabs)

        tabBarController.setViewControllers(
            tabs,
            animated: animated
        )

        configuration.completionHandler?(tabBarController, tabs)
    }
}
