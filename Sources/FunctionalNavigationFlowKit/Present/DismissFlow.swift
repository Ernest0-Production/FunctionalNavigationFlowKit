//
//  DismissFlow.swift
//  
//
//  Created by Бабаян Эрнест on 12.04.2021.
//

import UIKit


public func DismissFlow(
    animated: Bool = true,
    _ controllerBuilder: @escaping @autoclosure Deferred<UIViewController>,
    completionFlow: Flow? = nil
) -> Flow {
    onMainThread {
        controllerBuilder().dismiss(
            animated: animated,
            completion: completionFlow
        )
    }
}

public func DismissFlow(
    animated: Bool = true,
    in presentingControllerBuilder: @escaping @autoclosure Deferred<UIViewController>,
    completionFlow:Flow? = nil
) -> Flow {
    return {
        let presentingController = presentingControllerBuilder()
        
        guard let presentedController = presentingController.presentedViewController else {
            assertionFailure("\(presentingController) has not any presented View Controller ")
            return
        }

        DismissFlow(
            animated: animated,
            presentedController,
            completionFlow: completionFlow
        )()
    }
}

public func DismissFlow(
    animated: Bool = true,
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
            topmostViewController,
            completionFlow: completionFlow
        )()
    }
}
