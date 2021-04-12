//
//  PresentFlow.swift
//  
//
//  Created by Бабаян Эрнест on 11.04.2021.
//

import UIKit


public func PresentFlow<Presenting, Presented>(
    in presenting: Presenting,
    animated: Bool = true,
    _ configuration: PresentFlowTransitionConfiguration<Presenting, Presented> = .empty,
    _ presentingBuilder: @escaping Deferred<Presented>,
    completionFlow: Flow? = nil
) -> Flow {
    onMainThread {
        let presented = presentingBuilder()

        configuration.handler(presenting, presented)

        presenting.present(
            presented,
            animated: animated,
            completion: completionFlow
        )
    }
}

public func PresentFlow<Presenting, Presented>(
    in presenting: Presenting,
    animated: Bool = true,
    _ configuration: PresentFlowTransitionConfiguration<Presenting, Presented> = .empty,
    _ autoclosure_presentedBuilder: @autoclosure @escaping Deferred<Presented>,
    completionFlow: Flow? = nil
) -> Flow {
    PresentFlow(
        in: presenting,
        animated: animated,
        configuration,
        autoclosure_presentedBuilder,
        completionFlow: completionFlow
    )
}

public func PresentFlow<Dependency, Presenting, Presented>(
    in presenting: Presenting,
    animated: Bool = true,
    _ configuration: PresentFlowTransitionConfiguration<Presenting, Presented> = .empty,
    _ presentedBuilder: @escaping (Dependency) -> Presented,
    completionFlow: Flow? = nil
) -> (Dependency) -> Flow {
    return { (dependency: Dependency) in
        PresentFlow(
            in: presenting,
            animated: animated,
            configuration,
            presentedBuilder(dependency),
            completionFlow: completionFlow
        )
    }
}