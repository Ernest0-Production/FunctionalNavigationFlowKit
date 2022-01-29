//
//  SetTabBarItemsFlowConfiguration.swift
//  
//
//  Created by Бабаян Эрнест on 13.04.2021.
//

#if canImport(UIKit)
import UIKit


public extension FlowConfiguration {
    // Не знаю почему, но без указания женериков функций, требует явно указать женерик конфигурации
    static func titlePositionAdjustment<TabBar: UITabBarController, AnyDestination>(_ offset: UIOffset) -> FlowConfiguration<TabBar, AnyDestination> {
        FlowConfiguration<TabBar, AnyDestination>(preparation: { tabBar, _ in
            for tabItem in tabBar.tabBar.items ?? [] {
                tabItem.titlePositionAdjustment = offset
            }
        })
    }

    static func tabBarDelegate<TabBar: UITabBarController, AnyDestination>(_ delegate: UITabBarControllerDelegate) -> FlowConfiguration<TabBar, AnyDestination> {
        FlowConfiguration<TabBar, AnyDestination>(preparation: { tabBar, _ in
            tabBar.delegate = delegate
        })
    }
}
#endif
