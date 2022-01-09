//
//  PushFlowConfiguration.swift
//  
//
//  Created by Бабаян Эрнест on 12.04.2021.
//

#if canImport(UIKit)
import UIKit


public typealias PushFlowConfiguration<
    NavigationStack: UINavigationController,
    Item: UIViewController
> = FlowConfiguration<NavigationStack, Item>


public extension PushFlowConfiguration {
    static var hidesBottomBarWhenPushed: PushFlowConfiguration {
        PushFlowConfiguration(preparation: { _, item in
            item.hidesBottomBarWhenPushed = true
        })
    }

    static func title(_ title: String?) -> PushFlowConfiguration {
        PushFlowConfiguration(preparation: { _, item in
            item.navigationItem.title = title
        })
    }

    static func titleView(_ titleView: UIView?) -> PushFlowConfiguration {
        PushFlowConfiguration(preparation: { _, item in
            item.navigationItem.titleView = titleView
        })
    }

    static func leftBarButton(animated: Bool = true, _ item: UIBarButtonItem) -> PushFlowConfiguration {
        PushFlowConfiguration(preparation: { _, controller in
            controller.navigationItem.setLeftBarButton(item, animated: animated)
        })
    }
    
    static func leftBarButtonItems(animated: Bool = true, _ items: [UIBarButtonItem]) -> PushFlowConfiguration {
        PushFlowConfiguration(preparation: { _, controller in
            controller.navigationItem.setLeftBarButtonItems(items, animated: animated)
        })
    }
    
    static func rightBarButton(animated: Bool = true, _ item: UIBarButtonItem) -> PushFlowConfiguration {
        PushFlowConfiguration(preparation: { _, controller in
            controller.navigationItem.setRightBarButton(item, animated: animated)
        })
    }
    
    static func rightBarButtonItems(animated: Bool = true, _ items: [UIBarButtonItem]) -> PushFlowConfiguration {
        PushFlowConfiguration(preparation: { _, controller in
            controller.navigationItem.setRightBarButtonItems(items, animated: animated)
        })
    }
    
    static func navigationDelegate(_ delegate: UINavigationControllerDelegate) -> PushFlowConfiguration {
        PushFlowConfiguration(preparation: { navigationStack, _ in
            navigationStack.delegate = delegate
        })
    }

    static func showNavigationBar(animated: Bool = true) -> PushFlowConfiguration {
        PushFlowConfiguration(preparation: { navigationStack, _ in
            navigationStack.setNavigationBarHidden(false, animated: animated)
        })
    }

    static func hideNavigationBar(animated: Bool = true) -> PushFlowConfiguration {
        PushFlowConfiguration(preparation: { navigationStack, _ in
            navigationStack.setNavigationBarHidden(true, animated: animated)
        })
    }

    static func showToolbar(animated: Bool = true) -> PushFlowConfiguration {
        PushFlowConfiguration(preparation: { navigationStack, _ in
            navigationStack.setToolbarHidden(false, animated: animated)
        })
    }

    static func hideToolbar(animated: Bool = true) -> PushFlowConfiguration {
        PushFlowConfiguration(preparation: { navigationStack, _ in
            navigationStack.setToolbarHidden(true, animated: animated)
        })
    }
}
#endif
