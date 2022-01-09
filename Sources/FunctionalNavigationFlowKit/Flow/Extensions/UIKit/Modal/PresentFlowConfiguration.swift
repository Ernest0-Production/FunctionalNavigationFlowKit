//
//  PresentFlowConfiguration.swift
//
//
//  Created by Бабаян Эрнест on 12.04.2021.
//

#if canImport(UIKit)
import UIKit


public typealias PresentFlowConfiguration<
    Presenting: UIViewController,
    Presented: UIViewController
> = FlowConfiguration<Presenting, Presented>


public extension PresentFlowConfiguration {
    static func transitionStyle(_ modalTransitionStyle: UIModalTransitionStyle) -> PresentFlowConfiguration {
        PresentFlowConfiguration(preparation: { _, presented in
            presented.modalTransitionStyle = modalTransitionStyle
        })
    }

    static func presentationStyle(_ modalPresentationStyle: UIModalPresentationStyle) -> PresentFlowConfiguration {
        PresentFlowConfiguration(preparation: { _, presented in
            presented.modalPresentationStyle = modalPresentationStyle
        })
    }

    @available(iOS 13.0, *)
    static var modalInPresentation: PresentFlowConfiguration {
        PresentFlowConfiguration(preparation: { _, presented in
            presented.isModalInPresentation = true
        })
    }

    static var definingPresentingContext: PresentFlowConfiguration {
        PresentFlowConfiguration(preparation: { presenting, _ in
            presenting.definesPresentationContext = true
        })
    }
    
    static func transitioningDelegate(_ transitioningDelegate: UIViewControllerTransitioningDelegate) -> PresentFlowConfiguration {
        PresentFlowConfiguration(preparation: { _, presented in
            presented.transitioningDelegate = transitioningDelegate
        })
    }
}
#endif
