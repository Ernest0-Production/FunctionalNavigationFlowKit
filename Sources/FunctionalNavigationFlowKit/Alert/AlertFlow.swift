//
//  File.swift
//  
//
//  Created by Бабаян Эрнест on 13.04.2021.
//

import UIKit


public func AlertFlow(
    in presenting: UIViewController,
    animated: Bool = true,
    title: String? = nil,
    message: String? = nil,
    style: UIAlertController.Style
) -> Flow {
    onMainThread {
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: style
        )

        PresentFlow(
            in: presenting,
            animated: animated,
            alertController
        )()
    }
}


public func AlertFlow(
    in window: UIWindow = KeyWindow,
    animated: Bool = true,
    title: String? = nil,
    message: String? = nil,
    style: UIAlertController.Style
) -> Flow {
    onMainThread {
        guard let presenting = window.rootViewController?.topmostViewController() else {
            return
        }

        AlertFlow(
            in: presenting,
            animated: animated,
            title: title,
            message: message,
            style: style
        )()
    }
}
