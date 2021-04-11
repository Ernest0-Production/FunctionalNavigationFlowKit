//
//  SetWindowRoot.swift
//  
//
//  Created by Бабаян Эрнест on 11.04.2021.
//

import UIKit


public func SetWindowRootFlow(
    in window: UIWindow,
    animated: Bool = true,
    _ controller: UIViewController,
    completionFlow: Flow? = nil
) -> Flow {
    onMainThread {
        window.rootViewController = controller
        window.makeKeyAndVisible()

        guard animated else {
            return
        }

        UIView.transition(
            with: window,
            duration: 0.3,
            options: .transitionCrossDissolve,
            animations: nil,
            completion: { _ in completionFlow?() }
        )
    }
}


// MARK: - Deferred Set Window Root

public func DeferredSetWindowRootFlow(
    in window: UIWindow,
    animated: Bool = true,
    _ controllerBuilder: @escaping ViewControllerBuilder,
    completionFlow: Flow? = nil
) -> Flow {
    return {
        SetWindowRootFlow(
            in: window,
            animated: animated,
            controllerBuilder(),
            completionFlow: completionFlow
        )()
    }
}

public func DeferredSetWindowRootFlow(
    in window: UIWindow,
    animated: Bool = true,
    _ controllerBuilder: @autoclosure @escaping ViewControllerBuilder,
    completionFlow: Flow? = nil
) -> Flow {
    return {
        SetWindowRootFlow(
            in: window,
            animated: animated,
            controllerBuilder(),
            completionFlow: completionFlow
        )()
    }
}
