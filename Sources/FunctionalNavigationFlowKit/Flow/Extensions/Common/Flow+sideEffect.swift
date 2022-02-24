//
//  File.swift
//  
//
//  Created by Ernest Babayan on 25.11.2021.
//

public extension Flow {
    /// Middleware for adding side effects that executes before executing this flow.
    ///
    /// - Parameter execute: action that executes before starting flow execution.
    ///
    /// - Returns: Flow that execute this flow and additonal action before it.
    func beforeStart(_ execute: @escaping () -> Void) -> Flow {
        Flow({
            execute()
            self.execute()
        })
    }

    /// Middleware for adding side effects that executes after executing this flow.
    ///
    /// - Parameter execute: action that executes after starting flow execution.
    ///
    /// - Returns: Flow that execute this flow and additonal action after it.
    func afterStart(_ execute: @escaping () -> Void) -> Flow {
        Flow({
            self.execute()
            execute()
        })
    }
}
