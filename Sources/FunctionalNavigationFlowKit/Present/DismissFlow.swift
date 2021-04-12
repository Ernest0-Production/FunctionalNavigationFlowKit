//
//  DismissFlow.swift
//  
//
//  Created by Бабаян Эрнест on 12.04.2021.
//

import UIKit


public func DismissFlow(
    animated: Bool = true,
    _ controller: UIViewController,
    completionFlow: @escaping Flow
) -> Flow {
    onMainThread {
        controller.dismiss(
            animated: animated,
            completion: completionFlow
        )
    }
}

public func DismissFlow(
    animated: Bool = true,
    in presentingController: UIViewController,
    completionFlow: @escaping Flow
) -> Flow {
    return {
        guard let presentedController = presentingController.presentedViewController else {
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
    in window: UIWindow = UIApplication.shared.keyWindow!,
    completionFlow: @escaping Flow
) -> Flow {
    return {
        guard let topmostViewController = window.rootViewController?.topmostViewController() else {
            return
        }

        DismissFlow(
            animated: animated,
            topmostViewController,
            completionFlow: completionFlow
        )()
    }
}

private extension UIViewController {
   func topmostViewController() -> UIViewController {
       if let presented = self.presentedViewController {
           return presented.topmostViewController()
       }

       if let tabBarController = self as? UITabBarController {
           return tabBarController.selectedViewController?.topmostViewController() ?? self
       }

       if let navigationController = self as? UINavigationController {
        return navigationController.visibleViewController?.topmostViewController() ?? self
       }

       return self
   }
}
