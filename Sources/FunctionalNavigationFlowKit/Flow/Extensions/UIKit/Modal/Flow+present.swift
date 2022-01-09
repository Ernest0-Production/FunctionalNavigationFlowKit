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
    static func present<Presenting, Presented>(
        in presenting: Presenting,
        animated: Bool = true,
        with configuration: PresentFlowConfiguration<Presenting, Presented> = .empty,
        _ presentedFactory: @escaping @autoclosure () -> Presented,
        completion: Optional<() -> Void> = .none
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
}
#endif
