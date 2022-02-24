//
//  File.swift
//  
//
//  Created by Ernest Babayan on 29.06.2021.
//

public extension Flow {
    /// Wraps flow build and execution and performs them deferred when execute this flow.
    ///
    /// - Parameter flowFactory: Provide flow that will be executed when this flow executes.
    ///
    /// - Returns: Flow that create and execute passed flow build.
    static func deferred(_ flowFactory: @escaping () -> Flow) -> Flow {
        Flow({ flowFactory().execute() })
    }
}
