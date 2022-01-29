//
//  SetWindowRootFlowConfiguration.swift
//  
//
//  Created by Бабаян Эрнест on 12.04.2021.
//

#if canImport(UIKit)
import UIKit


public extension FlowConfiguration where Departure: UIWindow {
    static var keyAndVisible: FlowConfiguration {
        FlowConfiguration(completion: { window, _ in
            window.makeKeyAndVisible()
        })
    }

    static func animated(
        duration: TimeInterval,
        options: UIView.AnimationOptions = .transitionCrossDissolve,
        completion: Optional<() -> Void> = .none
    ) -> FlowConfiguration {
        FlowConfiguration(completion: { window, _ in
            UIView.transition(
                with: window,
                duration: duration,
                options: options,
                animations: nil,
                completion: { result in completion?() }
            )
        })
    }
}
#endif
