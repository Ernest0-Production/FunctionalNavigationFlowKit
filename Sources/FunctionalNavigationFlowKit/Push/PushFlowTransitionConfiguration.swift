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

    static func navigationDelegate(_ delegate: UINavigationControllerDelegate) -> PushFlowTransitionConfiguration {
        var currentDelegate: UINavigationControllerDelegate?

        return PushFlowTransitionConfiguration(
            prepare: { navigationStack, _ in
                currentDelegate = navigationStack.delegate
                navigationStack.delegate = delegate
            }, completion: { navigationStack, _ in
                navigationStack.delegate = currentDelegate
            })
    }
}
