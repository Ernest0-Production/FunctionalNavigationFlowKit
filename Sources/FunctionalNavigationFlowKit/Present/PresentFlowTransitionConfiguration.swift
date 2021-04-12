//
//  PresentFlowTransitionConfiguration.swift
//  
//
//  Created by Бабаян Эрнест on 12.04.2021.
//

import UIKit


public extension PresentFlowTransitionConfiguration {
    static func transitionStyle(_ modalTransitionStyle: UIModalTransitionStyle) -> PresentFlowTransitionConfiguration {
        PresentFlowTransitionConfiguration({ _, presenting in
            presenting.modalTransitionStyle = modalTransitionStyle
        })
    }

    static func presentedStyle(_ modalPresentedStyle: UIModalPresentationStyle) -> PresentFlowTransitionConfiguration {
        PresentFlowTransitionConfiguration({ _, presenting in
            presenting.modalPresentationStyle = modalPresentedStyle
        })
    }

    @available(iOS 13.0, *)
    static var modalInPresentation: PresentFlowTransitionConfiguration {
        PresentFlowTransitionConfiguration({ _, presenting in
            presenting.isModalInPresentation = true
        })
    }

    static func transitionDelegate(_ transitionDelegate: UIViewControllerTransitioningDelegate) -> PresentFlowTransitionConfiguration {
        PresentFlowTransitionConfiguration({ _, presenting in
            presenting.transitioningDelegate = transitionDelegate
        })
    }
}
