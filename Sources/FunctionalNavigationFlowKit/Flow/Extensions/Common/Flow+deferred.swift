//
//  File.swift
//  
//
//  Created by Ernest Babayan on 29.06.2021.
//

public extension Flow {
    /// Wraps flow build and execution and performs them deferred when execute wrapper.
    ///
    /// - Parameter flowFactory: Provide flow that will be executed when deferred flow executes.
    ///
    /// - Returns: Flow that awaits own execution before getting and executing flow from factory.
    static func deferred(_ flowFactory: @escaping () -> Flow) -> Flow {
        Flow({ flowFactory().execute() })
    }
}
