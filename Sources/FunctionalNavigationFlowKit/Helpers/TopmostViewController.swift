//
//  TopmosViewController.swift
//  
//
//  Created by Бабаян Эрнест on 13.04.2021.
//

import UIKit


extension UIViewController {
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

public var KeyWindow: UIWindow! { UIApplication.shared.keyWindow! }
