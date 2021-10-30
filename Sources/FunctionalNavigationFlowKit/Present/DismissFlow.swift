//
//  DismissFlow.swift
//  
//
//  Created by Бабаян Эрнест on 12.04.2021.
//

import UIKit


public typealias DismissFlowConfiguration = PresentFlowConfiguration


public func DismissFlow<Presented>(
    animated: Bool = true,
    with configuration: DismissFlowConfiguration<UIViewController, Presented> = .empty,
    _ controllerBuilder: @escaping @autoclosure Deferred<Presented>,
    completionFlow: @escaping Flow = EmptyFlow
) -> Flow {
    onMainThread {
        let presentedController = controllerBuilder()

        guard let presentingController = presentedController.presentingViewController else {
            assertionFailure("\(presentedController) has not presenting View Controller")
            return
        }

        configuration.preparationHandler?(presentingController, presentedController)

        presentedController.dismiss(
            animated: animated,
            completion: completionFlow
        )

        configuration.completionHandler?(presentingController, presentedController)
    }
}

public func DismissFlow<Presenting>(
    animated: Bool = true,
    with configuration: DismissFlowConfiguration<Presenting, UIViewController> = .empty,
    in presentingControllerBuilder: @escaping @autoclosure Deferred<Presenting>,
    completionFlow: @escaping Flow = EmptyFlow
) -> Flow {
    onMainThread {
        let presentingController = presentingControllerBuilder()

        guard let presentedController = presentingController.presentedViewController else {
            assertionFailure("\(presentingController) has not any presented View Controller ")
            return
        }

        configuration.preparationHandler?(presentingController, presentedController)

        presentedController.dismiss(
            animated: animated,
            completion: completionFlow
        )

        configuration.completionHandler?(presentingController, presentedController)
    }
}

public func DismissFlow<Presenting>(
    animated: Bool = true,
    with configuration: DismissFlowConfiguration<Presenting, UIViewController> = .empty,
    to presentingControllerBuilder: @escaping @autoclosure Deferred<Presenting>,
    completionFlow: @escaping Flow = EmptyFlow
) -> Flow {
    LazyFlow(onMainThread {
        let presentingController = presentingControllerBuilder()

        return DismissFlow(
            animated: animated,
            with: configuration,
            in: presentingController,
            completionFlow: LazyFlow({
                if presentingController.presentedViewController == nil {
                    return completionFlow
                }

                return DismissFlow(
                    animated: animated,
                    with: configuration,
                    in: presentingController,
                    completionFlow: completionFlow
                )
            })
        )
    })
}
