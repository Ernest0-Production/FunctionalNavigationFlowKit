//
//  SetTabBarItemsFlowTransitionConfiguration.swift
//  
//
//  Created by Бабаян Эрнест on 13.04.2021.
//

import UIKit


public typealias SetTabBarItemsFlowTransitionConfiguration<
    TabBar: UITabBarController,
    Item: UIViewController
> = FlowConfiguration<TabBar, [Item]>


public extension SetTabBarItemsFlowTransitionConfiguration {
    // Не знаю почему, но без указания женериков функций, требует явно указать женерик конфигурации
    static func titlePositionAdjustment<TabBar, Item>(_ offset: UIOffset) -> SetTabBarItemsFlowTransitionConfiguration<TabBar, Item> {
        SetTabBarItemsFlowTransitionConfiguration(prepare: { tabBar, _ in
            for tabItem in tabBar.tabBar.items ?? [] {
                tabItem.titlePositionAdjustment = offset
            }
        })
    }
}
