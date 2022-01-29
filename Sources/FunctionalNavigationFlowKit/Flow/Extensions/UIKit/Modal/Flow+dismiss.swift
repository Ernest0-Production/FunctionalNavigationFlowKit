//
//  DismissFlow.swift
//  
//
//  Created by Бабаян Эрнест on 12.04.2021.
//

#if canImport(UIKit)
import UIKit


public extension Flow {
    /// Dismisses the view controller that was presented modally.
    ///
    /// - Parameters:
    ///   - animated: Pass true to animate the transition.
    ///
    ///   - configuration: Flow configuration that executed before and after dismissing.
    ///
    ///   - presented: View controller to be dismissed.
    ///
    ///   - completion: The flow to execute after the view controller is dismissed.
    ///
    /// - Returns: Flow that dismiss view controller.
    static func dismiss<Presented: UIViewController>(
        animated: Bool = true,
        with configuration: FlowConfiguration<UIViewController, Presented> = .empty,
        _ presented: Presented,
        completion: Optional<() -> Void> = .none
    ) -> Flow {
        Flow({
            guard let presenting = presented.presentingViewController else {
                throwException("\(presented) has not presenting View Controller")
                return
            }

            configuration.preparationHandler?(presenting, presented)

            presented.dismiss(
                animated: animated,
                completion: completion
            )

            configuration.completionHandler?(presenting, presented)
        }).synchonize(with: .mainThread)
    }

    /// Dismisses the view controller that was presented modally by the presenting view controller..
    ///
    /// - Parameters:
    ///   - animated: Pass true to animate the transition.
    ///
    ///   - configuration: Flow configuration that executed before and after dismissing.
    ///
    ///   - presenting: View controller in which the presented view controller to be dismissed.
    ///
    ///   - completion: The flow to execute after the view controller is dismissed.
    ///
    /// - Returns: Flow that dismiss view controller.
    static func dismiss<Presenting: UIViewController>(
        animated: Bool = true,
        with configuration: FlowConfiguration<Presenting, UIViewController> = .empty,
        in presenting: Presenting,
        completion: Optional<() -> Void> = .none
    ) -> Flow {
        Flow({
            guard let presented = presenting.presentedViewController else {
                throwException("\(presenting) has not any presented View Controller ")
                return
            }

            configuration.preparationHandler?(presenting, presented)

            presented.dismiss(
                animated: animated,
                completion: completion
            )

            configuration.completionHandler?(presenting, presented)
        }).synchonize(with: .mainThread)
    }

    /// Dismisses **all** view controllers that was presented modally by the presenting view controller..
    ///
    /// - Parameters:
    ///   - animated: Pass true to animate the transition.
    ///
    ///   - configuration: Flow configuration that executed before and after dismissing.
    ///
    ///   - presenting: View controller in which the **all** presented view controller to be dismissed.
    ///
    ///   - completion: The flow to execute after the view controller is dismissed.
    ///
    /// - Returns: Flow that dismiss view controller.
    static func dismiss<Presenting: UIViewController>(
        animated: Bool = true,
        with configuration: FlowConfiguration<Presenting, UIViewController> = .empty,
        to presenting: Presenting,
        completion: Optional<() -> Void> = .none
    ) -> Flow {
        Flow.dismiss(
            animated: animated,
            with: configuration,
            in: presenting,
            completion: {
                if presenting.presentedViewController == nil {
                    completion?()
                    return
                }

                Flow.dismiss(
                    animated: animated,
                    with: configuration,
                    in: presenting,
                    completion: completion
                ).execute()
            }
        )
    }
}
#endif
