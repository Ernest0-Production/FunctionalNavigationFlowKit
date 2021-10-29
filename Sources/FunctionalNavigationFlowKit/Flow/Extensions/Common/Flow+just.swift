//
//  File.swift
//  
//
//  Created by Ernest Babayan on 12.11.2021.
//

public extension Flow {
    /// Wraps closure into flow.
    ///
    /// - Parameter execute: Closure to be executed.
    ///
    /// - Returns: Flow that executes passed closure.
    static func just(_ execute: @escaping () -> Void) -> Flow {
        Flow(execute)
    }

    /// Wraps closure into flow.
    ///
    /// - Parameter execute: Closure to be executed.
    ///
    /// - Returns: Flow that executes passed closure.
    static func just(_ execute: @escaping @autoclosure  () -> Void) -> Flow {
        Flow(execute)
    }
}
