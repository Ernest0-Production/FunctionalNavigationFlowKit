//
//  SetTabBarItemsFlowConfiguration.swift
//  
//
//  Created by Бабаян Эрнест on 13.04.2021.
//

import UIKit


public typealias SetTabsFlowConfiguration<
    TabBar: UITabBarController,
    Tab: UIViewController
> = FlowConfiguration<TabBar, [Tab]>


public extension SetTabsFlowConfiguration {
    // Не знаю почему, но без указания женериков функций, требует явно указать женерик конфигурации
    static func titlePositionAdjustment<TabBar, Tab>(_ offset: UIOffset) -> SetTabsFlowConfiguration<TabBar, Tab> {
        SetTabsFlowConfiguration.preparation({ tabBar, _ in
            for tabItem in tabBar.tabBar.items ?? [] {
                tabItem.titlePositionAdjustment = offset
            }
        })
    }
}
