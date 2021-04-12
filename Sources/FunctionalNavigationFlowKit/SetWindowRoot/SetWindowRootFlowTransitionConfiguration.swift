//
//  SetWindowRootFlowTransitionConfiguration.swift
//  
//
//  Created by Бабаян Эрнест on 12.04.2021.
//

import UIKit


public typealias SetWindowRootFlowTransitionConfiguration<
    Window: UIWindow,
    Root: UIViewController
> = FlowConfiguration<Window, Root>


public extension SetWindowRootFlowTransitionConfiguration {
    static var keyAndVisible: SetWindowRootFlowTransitionConfiguration {
        SetWindowRootFlowTransitionConfiguration(completion: { window, _ in
            window.makeKeyAndVisible()
        })
    }
}
