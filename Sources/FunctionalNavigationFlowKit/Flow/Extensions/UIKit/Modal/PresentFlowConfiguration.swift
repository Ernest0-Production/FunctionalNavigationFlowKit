//
//  PresentFlowConfiguration.swift
//
//
//  Created by Бабаян Эрнест on 12.04.2021.
//

#if canImport(UIKit)
import UIKit


public extension FlowConfiguration where Departure: UIViewController, Destination: UIViewController {
    static func transitionStyle(_ modalTransitionStyle: UIModalTransitionStyle) -> FlowConfiguration {
        FlowConfiguration(preparation: { _, presented in
            presented.modalTransitionStyle = modalTransitionStyle
        })
    }

    static func presentationStyle(_ modalPresentationStyle: UIModalPresentationStyle) -> FlowConfiguration {
        FlowConfiguration(preparation: { _, presented in
            presented.modalPresentationStyle = modalPresentationStyle
        })
    }

    @available(iOS 13.0, *)
    static var modalInPresentation: FlowConfiguration {
        FlowConfiguration(preparation: { _, presented in
            presented.isModalInPresentation = true
        })
    }

    static var definingPresentingContext: FlowConfiguration {
        FlowConfiguration(preparation: { presenting, _ in
            presenting.definesPresentationContext = true
        })
    }
    
    static func transitioningDelegate(_ transitioningDelegate: UIViewControllerTransitioningDelegate) -> FlowConfiguration {
        FlowConfiguration(preparation: { _, presented in
            presented.transitioningDelegate = transitioningDelegate
        })
    }
}
#endif
