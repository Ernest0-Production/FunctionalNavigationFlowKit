//
//  File.swift
//  
//
//  Created by Ernest Babayan on 19.11.2021.
//

/// The flow you want to perform, encapsulated in a way that lets you attach a completion handler.
public final class FlowTask {
    public typealias CompletionHandler = () -> Void
    public typealias FlowFactory = (@escaping CompletionHandler) -> Flow

    private init(_ flowFactory: @escaping FlowFactory) {
        self.flowFactory = flowFactory
    }

    private let flowFactory: FlowFactory

    /// Run execution task.
    /// - Parameter onComplete: Completion handler of task.
    public func execute(onComplete completionHandler: @escaping CompletionHandler) {
        flowFactory(completionHandler).execute()
    }
}

public extension FlowTask {
    /// Wraps flow into task with attached completion handler.
    ///
    /// - Parameter flowFactory: Provide flow and execution completion handler.
    ///
    /// - Returns: Task that execute flow with user-defined completion.
    static func create(_ flowFactory: @escaping FlowFactory) -> FlowTask {
        FlowTask(flowFactory)
    }
}
