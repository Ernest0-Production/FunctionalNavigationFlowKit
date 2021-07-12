//
//  DismissFlow.swift
//  
//
//  Created by Бабаян Эрнест on 12.04.2021.
//

import UIKit


public typealias DismissFlowTransitionConfiguration = PresentFlowTransitionConfiguration

public func DismissFlow<Presented>(
    animated: Bool = true,
    configuration: DismissFlowTransitionConfiguration<UIViewController, Presented> = .empty,
    _ controllerBuilder: @escaping @autoclosure Deferred<Presented>,
    completionFlow: Flow? = nil
) -> Flow {
    onMainThread {
        let presentedController = controllerBuilder()
        
        guard let presentingController = presentedController.presentingViewController else {
            assertionFailure("\(presentedController) has not presenting View Controller")
            return
        }
        
        dismiss(
            in: presentingController,
            presentedController,
            animated: animated,
            configuration: configuration,
            completionFlow: completionFlow
        )
    }
}

public func DismissFlow<Presenting>(
    animated: Bool = true,
    configuration: DismissFlowTransitionConfiguration<Presenting, UIViewController> = .empty,
    in presentingControllerBuilder: @escaping @autoclosure Deferred<Presenting>,
    completionFlow: Flow? = nil
) -> Flow {
    return {
        let presentingController = presentingControllerBuilder()
        
        guard let presentedController = presentingController.presentedViewController else {
            assertionFailure("\(presentingController) has not any presented View Controller ")
            return
        }

        dismiss(
            in: presentingController,
            presentedController,
            animated: animated,
            configuration: configuration,
            completionFlow: completionFlow
        )
    }
}

public func DismissFlow<Presenting>(
    animated: Bool = true,
    configuration: DismissFlowTransitionConfiguration<Presenting, UIViewController> = .empty,
    to presentingControllerBuilder: @escaping @autoclosure Deferred<Presenting>,
    completionFlow: Flow? = nil
) -> Flow {
    LazyFlow({
        let presentingController = presentingControllerBuilder()
        
        return DismissFlow(
            animated: animated,
            configuration: configuration,
            in: presentingController,
            completionFlow: LazyFlow({
                if presentingController.presentedViewController == nil {
                    return completionFlow ?? EmptyFlow
                }
                
                return DismissFlow(
                    animated: animated,
                    configuration: configuration,
                    in: presentingController,
                    completionFlow: completionFlow
                )
            })
        )
    })
}

public func DismissFlow(
    animated: Bool = true,
    configuration: DismissFlowTransitionConfiguration<UIViewController, UIViewController> = .empty,
    in window: UIWindow = KeyWindow,
    completionFlow: Flow? = nil
) -> Flow {
    return {
        guard let topmostViewController = window.rootViewController?.topmostViewController() else {
            assertionFailure("\(window) has not rootViewController")
            return
        }

        DismissFlow(
            animated: animated,
            configuration: configuration,
            topmostViewController,
            completionFlow: completionFlow
        )()
    }
}

private func dismiss<Presenting: UIViewController, Presented: UIViewController>(
    in presentingController: Presenting,
    _ presentedController: Presented,
    animated: Bool,
    configuration: DismissFlowTransitionConfiguration<Presenting, Presented>,
    completionFlow: Flow?
) {
    configuration.prepareHandler?(presentingController, presentedController)
    
    presentedController.dismiss(
        animated: animated,
        completion: completionFlow
    )
    
    configuration.completionHandler?(presentingController, presentedController)
}
