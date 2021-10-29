//
//  File.swift
//  
//
//  Created by Ernest Babayan on 14.11.2021.
//

public extension FlowConfiguration {
    /// Middleware that executes before and after flow execution.
    ///
    /// - Parameters:
    ///   - preparation:handler that executes before flow execution.
    ///
    ///   - completion: handler that executes after flor execution.
    ///
    /// - Returns: FlowConfiguration that contains middleware before and after flow execution.
    static func middleware(
        before preparation: Handler?,
        after completion: Handler?
    ) -> FlowConfiguration {
        FlowConfiguration(preparation: preparation, completion: completion)
    }

    /// Middleware that executes only before flow execution.
    ///
    /// - Parameter handler: handler that executes before flow execution.
    ///
    /// - Returns: FlowConfiguration that contains middleware before flow execution.
    static func preparation(_ handler: @escaping Handler) -> FlowConfiguration {
        FlowConfiguration(preparation: handler, completion: nil)
    }

    /// Middleware that executes only after flow execution.
    ///
    /// - Parameter handler: handler that executes after flow execution.
    ///
    /// - Returns: FlowConfiguration that contains middleware after flow execution.
    static func completion(_ handler: @escaping Handler) -> FlowConfiguration {
        FlowConfiguration(preparation: nil, completion: handler)
    }
}
