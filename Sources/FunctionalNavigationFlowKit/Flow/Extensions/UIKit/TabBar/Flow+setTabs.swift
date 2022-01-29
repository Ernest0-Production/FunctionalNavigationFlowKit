//
//  SetTabsFlowConfiguration.swift
//  
//
//  Created by Бабаян Эрнест on 12.04.2021.
//

#if canImport(UIKit)
import UIKit


public extension Flow {
    /// Sets the root view controllers of the tab bar controller.
    ///
    /// - Parameters:
    ///   - tabBar: Tab bar controller in which the view controllers will be setted.
    ///
    ///   - animated: If true, the tab bar items for the view controllers are animated into position. If false, changes to the tab bar items are reflected immediately.
    ///
    ///   - configuration: Flow configuration that executed before and after settig tabs.
    ///
    ///   - tabsFactory: The array of custom view controllers to display in the tab bar interface. The order of the view controllers in this array corresponds to the display order in the tab bar, with the controller at index 0 representing the left-most tab, the controller at index 1 the next tab to the right, and so on.
    ///
    /// - Returns: Flow that set view controllers onto tab bar controller.
    static func setTabs<TabBar: UITabBarController, Tab: UIViewController>(
        in tabBar: TabBar,
        animated: Bool = true,
        with configuration: FlowConfiguration<TabBar, [Tab]>  = .empty,
        _ tabsFactory: @autoclosure @escaping () -> [Tab]
    ) -> Flow {
        Flow({
            let tabs = tabsFactory()

            configuration.preparationHandler?(tabBar, tabs)

            tabBar.setViewControllers(tabs, animated: animated)
            
            configuration.completionHandler?(tabBar, tabs)
        }).synchonize(with: .mainThread)
    }
}
#endif
