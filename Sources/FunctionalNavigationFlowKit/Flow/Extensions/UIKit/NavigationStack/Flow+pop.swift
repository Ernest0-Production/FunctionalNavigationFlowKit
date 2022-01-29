//
//  PopFlow.swift
//  
//
//  Created by Бабаян Эрнест on 12.04.2021.
//

#if canImport(UIKit)
import UIKit


public extension Flow {
    /// Pops the top view controller from the navigation stack and updates the display.
    ///
    /// - Parameters:
    ///   - navigationStack: Navigation controller in which the view controller will be popped.
    ///
    ///   - animated: Set this value to true to animate the transition. Pass false if you are setting up a navigation controller before its view is displayed.
    ///
    ///   - configuration: Flow configuration that executed before and after popping **from top item**.
    ///
    /// - Returns: Flow that pop view controller onto navigation controller.
    static func pop<NavigationStack: UINavigationController>(
        in navigationStack: NavigationStack,
        animated: Bool = true,
        with configuration: FlowConfiguration<NavigationStack, UIViewController?> = .empty
    ) -> Flow {
        Flow({
            let currentItem = navigationStack.topViewController

            configuration.preparationHandler?(navigationStack, currentItem)

            navigationStack.popViewController(animated: animated)

            configuration.completionHandler?(navigationStack, currentItem)
        }).synchonize(with: .mainThread)
    }

    /// Pops view controllers from the specified view controller is at the top of the navigation stack.
    ///
    /// - Parameters:
    ///   - navigationStack: Navigation controller in which the view controllers will be popped.
    ///
    ///   - animated: Set this value to true to animate the transition. Pass false if you are setting up a navigation controller before its view is displayed.
    ///
    ///   - configuration: Flow configuration that executed before and after popping **to item**.
    ///
    ///   - item: The view controller that you want pop from stack including all upstream items. This view controller must currently be on the navigation stack.
    ///
    /// - Returns: Flow that pop view controllers onto navigation controller.
    static func pop<NavigationStack: UINavigationController, Item: UIViewController>(
        in navigationStack: NavigationStack,
        animated: Bool = true,
        with configuration: FlowConfiguration<NavigationStack, Item> = .empty,
        from item: Item
    ) -> Flow {
        Flow({
            let newStack = navigationStack.viewControllers
                .drop(while: { $0 !== item })
                .dropLast()

            configuration.preparationHandler?(navigationStack, item)

            navigationStack.setViewControllers(Array(newStack), animated: animated)

            configuration.completionHandler?(navigationStack, item)
        }).synchonize(with: .mainThread)
    }

    /// Pops view controllers until the specified view controller is at the top of the navigation stack.
    ///
    /// - Parameters:
    ///   - navigationStack: Navigation controller in which the view controllers will be popped.
    ///
    ///   - animated: Set this value to true to animate the transition. Pass false if you are setting up a navigation controller before its view is displayed.
    ///
    ///   - configuration: Flow configuration that executed before and after popping **to item**.
    ///
    ///   - item: The view controller that you want to be at the top of the stack. This view controller must currently be on the navigation stack.
    ///
    /// - Returns: Flow that pop view controllers onto navigation controller.
    static func pop<NavigationStack: UINavigationController, Item: UIViewController>(
        in navigationStack: NavigationStack,
        animated: Bool = true,
        with configuration: FlowConfiguration<NavigationStack, Item> = .empty,
        to item: Item
    ) -> Flow {
        Flow({
            configuration.preparationHandler?(navigationStack, item)

            navigationStack.popToViewController(item, animated: animated)

            configuration.completionHandler?(navigationStack, item)
        }).synchonize(with: .mainThread)
    }

    /// Pops all the view controllers on the stack except the root view controller and updates the display.
    ///
    /// - Parameters:
    ///   - navigationStack: Navigation controller in which the view controllers will be popped.
    ///
    ///   - animated: Set this value to true to animate the transition. Pass false if you are setting up a navigation controller before its view is displayed.
    ///
    ///   - configuration: Flow configuration that executed before and after popping **to root**.
    ///
    /// - Returns: Flow that pop to root view controller onto navigation controller.
    static func popToRoot<NavigationStack: UINavigationController>(
        in navigationStack: NavigationStack,
        animated: Bool = true,
        with configuration: FlowConfiguration<NavigationStack, UIViewController?> = .empty
    ) -> Flow {
        Flow({
            let rootItem = navigationStack.viewControllers.first

            configuration.preparationHandler?(navigationStack, rootItem)

            navigationStack.popToRootViewController(animated: animated)

            configuration.completionHandler?(navigationStack, rootItem)
        }).synchonize(with: .mainThread)
    }
}
#endif
