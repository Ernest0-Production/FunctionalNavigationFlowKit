//
//  Present.swift
//  
//
//  Created by Бабаян Эрнест on 11.04.2021.
//

import UIKit


public func PresentFlow(
    in presentedController: UINavigationController,
    animated: Bool = true,
    _ presentingController: UIViewController,
    completionFlow: Flow? = nil
) -> Flow {
    onMainThread {
        presentedController.present(
            presentingController, animated: animated,
            completion: completionFlow
        )
    }
}


// MARK: - Deferred

public func DeferredPresentFlow(
    in presentedController: UINavigationController,
    animated: Bool = true,
    _ presentingControllerBuilder: @escaping ViewControllerBuilder,
    completionFlow: Flow? = nil
) -> Flow {
    return {
        PresentFlow(
            in: presentedController,
            animated: animated,
            presentingControllerBuilder(),
            completionFlow: completionFlow
        )()
    }
}

public func DeferredPresentFlow(
    in presentedController: UINavigationController,
    animated: Bool = true,
    _ presentingControllerBuilder: @autoclosure @escaping ViewControllerBuilder,
    completionFlow: Flow? = nil
) -> Flow {
    return {
        PresentFlow(
            in: presentedController,
            animated: animated,
            presentingControllerBuilder(),
            completionFlow: completionFlow
        )()
    }
}

public func DeferredPresentFlow<Dependency>(
    in presentedController: UINavigationController,
    _ presentingControllerBuilder: @escaping ViewControllerBuilderWith<Dependency>
) -> FlowBuilderWith<Dependency> {
    return { (dependency: Dependency) in
        DeferredPresentFlow(in: presentedController) {
            presentingControllerBuilder(dependency)
        }
    }
}

