//
//  PresentFlow.swift
//  
//
//  Created by Бабаян Эрнест on 11.04.2021.
//

import UIKit


public func PresentFlow<Presenting, Presented>(
    in presentingBuilder: @escaping @autoclosure Deferred<Presenting>,
    animated: Bool = true,
    configuration: PresentFlowTransitionConfiguration<Presenting, Presented> = .empty,
    _ presentedBuilder: @escaping Deferred<Presented>,
    completionFlow: Flow? = nil
) -> Flow {
    onMainThread {
        let presenting = presentingBuilder()
        let presented = presentedBuilder()
        
        configuration.prepareHandler?(presenting, presented)

        presenting.present(
            presented,
            animated: animated,
            completion: completionFlow
        )

        configuration.completionHandler?(presenting, presented)
    }
}

public func PresentFlow<Presenting, Presented>(
    in presentingBuilder: @escaping @autoclosure Deferred<Presenting>,
    animated: Bool = true,
    configuration: PresentFlowTransitionConfiguration<Presenting, Presented> = .empty,
    _ autoclosure_presentedBuilder: @autoclosure @escaping Deferred<Presented>,
    completionFlow: Flow? = nil
) -> Flow {
    PresentFlow(
        in: presentingBuilder(),
        animated: animated,
        configuration: configuration,
        autoclosure_presentedBuilder,
        completionFlow: completionFlow
    )
}


// MARK: - Top Most Present

public func PresentFlow<Presented>(
    in window: UIWindow = KeyWindow,
    animated: Bool = true,
    configuration: PresentFlowTransitionConfiguration<UIViewController, Presented> = .empty,
    _ presentingBuilder: @escaping Deferred<Presented>,
    completionFlow: Flow? = nil
) -> Flow {
    onMainThread {
        guard let presenting = window.rootViewController?.topmostViewController() else {
            return
        }

        PresentFlow(
            in: presenting,
            animated: animated,
            configuration: configuration,
            presentingBuilder,
            completionFlow: completionFlow
        )()
    }
}

public func PresentFlow<Presented>(
    in window: UIWindow = KeyWindow,
    animated: Bool = true,
    configuration: PresentFlowTransitionConfiguration<UIViewController, Presented> = .empty,
    _ autoclosure_presentedBuilder: @autoclosure @escaping Deferred<Presented>,
    completionFlow: Flow? = nil
) -> Flow {
    PresentFlow(
        in: window,
        animated: animated,
        configuration: configuration,
        autoclosure_presentedBuilder,
        completionFlow: completionFlow
    )
}
