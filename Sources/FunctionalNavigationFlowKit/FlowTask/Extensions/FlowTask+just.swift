//
//  File.swift
//  
//
//  Created by Ernest Babayan on 20.11.2021.
//

public extension FlowTask {
    /// Wraps flow into task.
    ///
    /// - Parameter flowFactory: Provide executing flow.
    ///
    /// - Returns: Task that execute flow and then immediately call completion handler.
    static func just(_ flowFactory: @escaping @autoclosure Deferred<Flow>) -> FlowTask {
        FlowTask.create({ completion in
            flowFactory().zip(Flow(completion))
        })
    }
}
