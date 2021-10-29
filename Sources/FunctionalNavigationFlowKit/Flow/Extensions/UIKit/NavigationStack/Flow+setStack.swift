//
//  File.swift
//  
//
//  Created by Ernest Babayan on 12.11.2021.
//

#if canImport(UIKit)
import UIKit


public typealias SetStackFlowConfiguration<
    NavigationStack: UINavigationController,
    Item: UIViewController
> = FlowConfiguration<NavigationStack, [Item]>


public extension Flow {
    /// Replaces the view controllers currently managed by the navigation controller with the specified items.
    ///
    /// - Parameters:
    ///   - animated: If true, animate the pushing or popping of the top view controller. If false, replace the view controllers without any animations.
    ///
    ///   - configuration: Flow configuration that executed before and after setting.
    ///
    ///   - itemsFactory: The view controllers to place in the stack. The front-to-back order of the controllers in this array represents the new bottom-to-top order of the controllers in the navigation stack. Thus, the last item added to the array becomes the top item of the navigation stack.
    ///
    /// - Returns: Flow that set view controller onto navigation controller.
    static func setStack<NavigationStack, Item>(
        in navigationStack: NavigationStack,
        animated: Bool = true,
        with configuration: SetStackFlowConfiguration<NavigationStack, Item> = .empty,
        _ itemsFactory: @autoclosure @escaping Deferred<[Item]>
    ) -> Flow {
        Flow({
            let items = itemsFactory()

            configuration.preparationHandler?(navigationStack, items)

            navigationStack.setViewControllers(items, animated: animated)
            
            configuration.completionHandler?(navigationStack, items)
        }).onMainThread()
    }
}
#endif
