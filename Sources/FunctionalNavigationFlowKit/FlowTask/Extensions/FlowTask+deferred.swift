//
//  File.swift
//  
//
//  Created by Ernest Babayan on 25.11.2021.
//

public extension FlowTask {
    /// Wraps flow task build and execution and performs them deferred when execute wrapper.
    ///
    /// - Parameter taskFactory: Provide task that will be executed when deferred task executes.
    ///
    /// - Returns: Flow task that awaits own execution before getting and executing task from factory.
    static func deferred(_ taskFactory: @escaping Deferred<FlowTask>) -> FlowTask {
        FlowTask.create({ completion in
            taskFactory().execute(onComplete: completion)
            return Flow.empty
        })
    }
}
