//
//  PresentFlow.swift
//  
//
//  Created by Бабаян Эрнест on 11.04.2021.
//

#if canImport(UIKit)
import UIKit


public extension Flow {
    /// Presents a view controller modally.
    ///
    /// - Parameters:
    ///   - presenting: View controller that present presenting view controller.
    ///
    ///   - animated: Pass true to animate the presentation; otherwise, pass false.
    ///
    ///   - configuration: Flow configuration that executed before and after presenting.
    ///
    ///   - presentedFactory: View controller to be preesnted.
    ///
    ///   - completion: The flow to execute after the presentation finishes.
    ///
    /// - Returns: Flow that present view controller.
    static func present<Presenting: UIViewController, Presented: UIViewController>(
        in presenting: Presenting,
        animated: Bool = true,
        with configuration: FlowConfiguration<Presenting, Presented> = .empty,
        _ presentedFactory: @escaping @autoclosure () -> Presented,
        onComplete completion: Optional<() -> Void> = .none
    ) -> Flow {
        Flow({
            let presented = presentedFactory()

            configuration.preparationHandler?(presenting, presented)

            presenting.present(
                presented,
                animated: animated,
                completion: completion
            )

            configuration.completionHandler?(presenting, presented)
        }).synchonize(with: .mainThread)
    }

    /// Presents a view controller modally in topmost of presenting controllers hierarchy.
    ///
    /// - Parameters:
    ///   - presenting: View controller from which the topmost controller will be presented presenting view controller.
    ///
    ///   - animated: Pass true to animate the presentation; otherwise, pass false.
    ///
    ///   - configuration: Flow configuration that executed before and after presenting.
    ///
    ///   - presentedFactory: View controller to be preesnted.
    ///
    ///   - completion: The flow to execute after the presentation finishes.
    ///
    /// - Returns: Flow that present view controller.
    static func present<Presented: UIViewController>(
        inTopmost presenting: UIViewController,
        animated: Bool = true,
        with configuration: FlowConfiguration<UIViewController, Presented> = .empty,
        _ presentedFactory: @escaping @autoclosure () -> Presented,
        onComplete completion: Optional<() -> Void> = .none
    ) -> Flow {
        Flow({
            var presenting = presenting
            while let topmostPresenting = presenting.presentingViewController {
                presenting = topmostPresenting
            }

            let presented = presentedFactory()

            configuration.preparationHandler?(presenting, presented)

            presenting.present(
                presented,
                animated: animated,
                completion: completion
            )

            configuration.completionHandler?(presenting, presented)
        }).synchonize(with: .mainThread)
    }
}
#endif
