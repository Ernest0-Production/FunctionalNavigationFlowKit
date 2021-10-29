//
//  PushFlow.swift
//  
//
//  Created by Бабаян Эрнест on 11.04.2021.
//

#if canImport(UIKit)
import UIKit


public extension Flow {
    /// Pushes a view controller onto the navigation stack and updates the display.
    ///
    /// - Parameters:
    ///   - navigationStack: Navigation controller in which the view controller will be pushed.
    ///
    ///   - animated: Specify true to animate the transition or false if you do not want the transition to be animated. You might specify false if you are setting up the navigation controller at launch time.
    ///
    ///   - configuration: Flow configuration that executed before and after pushing.
    ///
    ///   - itemFactory: The view controller to push onto the stack. This object cannot be a tab bar controller. If the view controller is already on the navigation stack, this method throws an exception.
    ///
    /// - Returns: Flow that push view controller onto navigation controller.
    static func push<NavigationStack, Item>(
        in navigationStack: NavigationStack,
        animated: Bool = true,
        with configuration: PushFlowConfiguration<NavigationStack, Item> = .empty,
        _ itemFactory: @autoclosure @escaping Deferred<Item>
    ) -> Flow {
        Flow({
            let item = itemFactory()

            configuration.preparationHandler?(navigationStack, item)

            navigationStack.pushViewController(item, animated: animated)

            configuration.completionHandler?(navigationStack, item)
        }).onMainThread()
    }

    /// Pop top view controller and pushes new view controller onto the navigation stack and updates the display.
    ///
    /// - Parameters:
    ///   - navigationStack: Navigation controller in which the view controller will be pushed.
    ///
    ///   - animated: Specify true to animate the transition or false if you do not want the transition to be animated. You might specify false if you are setting up the navigation controller at launch time.
    ///
    ///   - configuration: Flow configuration that executed before and after swapping push.
    ///
    ///   - itemFactory: The view controller to push onto the stack. This object cannot be a tab bar controller. If the view controller is already on the navigation stack, this method throws an exception.
    ///
    /// - Returns: Flow that swap top view controller onto navigation controller.
    static func swapPush<NavigationStack, Item>(
        in navigationStack: NavigationStack,
        animated: Bool = true,
        with configuration: PushFlowConfiguration<NavigationStack, Item> = .empty,
        _ itemFactory: @autoclosure @escaping Deferred<Item>
    ) -> Flow {
        Flow({
            let item = itemFactory()
            var stackItems = navigationStack.viewControllers

            _ = stackItems.popLast()
            stackItems.append(item)

            configuration.preparationHandler?(navigationStack, item)

            navigationStack.setViewControllers(stackItems, animated: animated)

            configuration.completionHandler?(navigationStack, item)
        }).onMainThread()
    }
}
#endif
