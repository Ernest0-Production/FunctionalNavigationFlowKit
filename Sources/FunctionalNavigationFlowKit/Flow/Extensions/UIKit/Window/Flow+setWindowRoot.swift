//
//  SetWindowRootFlow.swift
//  
//
//  Created by Бабаян Эрнест on 11.04.2021.
//

#if canImport(UIKit)
import UIKit


public extension Flow {
    /// Sets the the root view controller for the window.
    ///
    /// - Parameters:
    ///   - window: The backdrop for your app’s user interface and the object that dispatches events to your views.
    ///
    ///   - configuration: Flow configuration that executed before and after settig view controller.
    ///
    ///   - rootFactory: The root view controller for the window.
    ///
    /// - Returns: Flow that set view controller for the window.
    static func setWindowRoot<Window, Root>(
        in window: Window,
        with configuration: SetWindowRootFlowConfiguration<Window, Root> = .empty,
        _ rootFactory: @autoclosure @escaping () -> Root
    ) -> Flow {
        Flow({
            let root = rootFactory()

            configuration.preparationHandler?(window, root)

            window.rootViewController = root

            configuration.completionHandler?(window, root)
        }).synchonize(with: .mainThread)
    }
}
#endif
