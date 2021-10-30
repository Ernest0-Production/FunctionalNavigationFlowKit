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
    with configuration: PresentFlowConfiguration<Presenting, Presented> = .empty,
    _ presentedBuilder: @autoclosure @escaping Deferred<Presented>,
    completionFlow: Flow? = nil
) -> Flow {
    onMainThread {
        let presenting = presentingBuilder()
        let presented = presentedBuilder()
        
        configuration.preparationHandler?(presenting, presented)

        presenting.present(
            presented,
            animated: animated,
            completion: completionFlow
        )

        configuration.completionHandler?(presenting, presented)
    }
}
