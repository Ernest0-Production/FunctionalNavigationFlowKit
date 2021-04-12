//
//  PopFlow.swift
//  
//
//  Created by Бабаян Эрнест on 12.04.2021.
//

import UIKit


public func PopFlow(
    in navigationController: UINavigationController,
    animated: Bool = true
) -> Flow {
    onMainThread {
        navigationController.popViewController(animated: animated)
    }
}

public func PopFlow(
    in navigationController: UINavigationController,
    animated: Bool = true,
    to viewController: UIViewController
) -> Flow {
    onMainThread {
        navigationController.popToViewController(
            viewController,
            animated: animated
        )
    }
}

public func PopToRootFlow(
    in navigationController: UINavigationController,
    animated: Bool = true
) -> Flow {
    onMainThread {
        navigationController.popToRootViewController(animated: animated)
    }
}
