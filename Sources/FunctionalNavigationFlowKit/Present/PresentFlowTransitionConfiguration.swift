//
//  PresentFlowTransitionConfiguration.swift
//  
//
//  Created by Бабаян Эрнест on 12.04.2021.
//

import UIKit


public typealias PresentFlowTransitionConfiguration<
    Presenting: UIViewController,
    Presented: UIViewController
> = FlowConfiguration<Presenting, Presented>


public extension PresentFlowTransitionConfiguration {
    static func transitionStyle(_ modalTransitionStyle: UIModalTransitionStyle) -> PresentFlowTransitionConfiguration {
        PresentFlowTransitionConfiguration(prepare: { _, presented in
            presented.modalTransitionStyle = modalTransitionStyle
        })
    }

    static func presentedStyle(_ modalPresentedStyle: UIModalPresentationStyle) -> PresentFlowTransitionConfiguration {
        PresentFlowTransitionConfiguration(prepare: { _, presented in
            presented.modalPresentationStyle = modalPresentedStyle
        })
    }

    @available(iOS 13.0, *)
    static var modalInPresentation: PresentFlowTransitionConfiguration {
        PresentFlowTransitionConfiguration(prepare: { _, presented in
            presented.isModalInPresentation = true
        })
    }

    static func transitionDelegate(_ transitionDelegate: UIViewControllerTransitioningDelegate) -> PresentFlowTransitionConfiguration {
        var currentDelegate: UIViewControllerTransitioningDelegate?

        return PresentFlowTransitionConfiguration(
            prepare: { _, presented in
                currentDelegate = presented.transitioningDelegate
                presented.transitioningDelegate = transitionDelegate
            },
            completion: { _, presented in
                presented.transitioningDelegate = currentDelegate
            })
    }
}
