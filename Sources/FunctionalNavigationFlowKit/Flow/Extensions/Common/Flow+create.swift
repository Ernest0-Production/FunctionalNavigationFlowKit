//
//  File.swift
//  
//
//  Created by Ernest Babayan on 12.11.2021.
//

public extension Flow {
    /// Create flow from closure.
    ///
    /// - Parameter execute: Closure to be executed.
    ///
    /// - Returns: Flow that executes passed closure.
    static func create(_ execute: @escaping () -> Void) -> Flow {
        Flow(execute)
    }
}
