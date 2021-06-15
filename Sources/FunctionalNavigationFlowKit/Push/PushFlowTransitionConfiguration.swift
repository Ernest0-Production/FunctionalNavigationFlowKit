//
//  PushFlowTransitionConfiguration.swift
//  
//
//  Created by Бабаян Эрнест on 12.04.2021.
//

import UIKit


public typealias PushFlowTransitionConfiguration<
    NavigationStack: UINavigationController,
    Item: UIViewController
> = FlowConfiguration<NavigationStack, Item>


public extension PushFlowTransitionConfiguration {
    static var hidesBottomBarWhenPushed: PushFlowTransitionConfiguration {
        PushFlowTransitionConfiguration(prepare: { _, item in
            item.hidesBottomBarWhenPushed = true
        })
    }

    static func title(_ title: String?) -> PushFlowTransitionConfiguration {
        PushFlowTransitionConfiguration(prepare: { _, item in
            item.navigationItem.title = title
        })
    }

    static func titleView(_ titleView: UIView?) -> PushFlowTransitionConfiguration {
        PushFlowTransitionConfiguration(prepare: { _, item in
            item.navigationItem.titleView = titleView
        })
    }

    static func leftBarButton(animated: Bool = true, _ item: UIBarButtonItem) -> PushFlowTransitionConfiguration {
        PushFlowTransitionConfiguration.prepare({ _, controller in
            controller.navigationItem.setLeftBarButton(item, animated: animated)
        })
    }
    
    static func leftBarButtonItems(animated: Bool = true, _ items: [UIBarButtonItem]) -> PushFlowTransitionConfiguration {
        PushFlowTransitionConfiguration.prepare({ _, controller in
            controller.navigationItem.setLeftBarButtonItems(items, animated: animated)
        })
    }
    
    static func rightBarButton(animated: Bool = true, _ item: UIBarButtonItem) -> PushFlowTransitionConfiguration {
        PushFlowTransitionConfiguration.prepare({ _, controller in
            controller.navigationItem.setRightBarButton(item, animated: animated)
        })
    }
    
    static func rightBarButtonItems(animated: Bool = true, _ items: [UIBarButtonItem]) -> PushFlowTransitionConfiguration {
        PushFlowTransitionConfiguration.prepare({ _, controller in
            controller.navigationItem.setRightBarButtonItems(items, animated: animated)
        })
    }
    
    static func navigationDelegate(_ delegate: UINavigationControllerDelegate) -> PushFlowTransitionConfiguration {
        var currentDelegate: UINavigationControllerDelegate?

        return PushFlowTransitionConfiguration(
            prepare: { navigationStack, _ in
                currentDelegate = navigationStack.delegate
                navigationStack.delegate = delegate
            },
            completion: { navigationStack, _ in
                navigationStack.delegate = currentDelegate
            })
    }
}
