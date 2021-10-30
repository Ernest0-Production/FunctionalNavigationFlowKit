//
//  SetWindowRootFlowConfiguration.swift
//  
//
//  Created by Бабаян Эрнест on 12.04.2021.
//

import UIKit


public typealias SetWindowRootFlowConfiguration<
    Window: UIWindow,
    Root: UIViewController
> = FlowConfiguration<Window, Root>


public extension SetWindowRootFlowConfiguration {
    static var keyAndVisible: SetWindowRootFlowConfiguration {
        SetWindowRootFlowConfiguration.completion({ window, _ in
            window.makeKeyAndVisible()
        })
    }

    static func animated(
        duration: TimeInterval,
        options: UIView.AnimationOptions = .transitionCrossDissolve,
        completionFlow: @escaping Flow = EmptyFlow
    ) -> SetWindowRootFlowConfiguration {
        SetWindowRootFlowConfiguration.completion({ window, _ in
            UIView.transition(
                with: window,
                duration: duration,
                options: .transitionCrossDissolve,
                animations: nil,
                completion: { _ in completionFlow() }
            )
        })
    }
}
