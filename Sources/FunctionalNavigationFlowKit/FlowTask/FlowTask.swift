//
//  File.swift
//  
//
//  Created by Ernest Babayan on 19.11.2021.
//

import Foundation

/// The flow you want to perform, encapsulated in a way that lets you attach a completion handler.
public final class FlowTask {
    public typealias CompletionHandler = () -> Void
    public typealias FlowFactory = (@escaping CompletionHandler) -> Flow

    private init(_ flowFactory: @escaping FlowFactory) {
        self.flowFactory = flowFactory
    }

    /// Wraps flow into task with attached completion handler.
    ///
    /// - NOTE: Completion handler must be called at most once.
    ///
    /// - Parameter flowFactory: Provide flow and execution completion handler.
    ///
    /// - Returns: Task that execute flow with user-defined completion.
    public static func create(_ flowFactory: @escaping FlowFactory) -> FlowTask {
        FlowTask(flowFactory)
    }

    private let flowFactory: FlowFactory

    /// Run task execution.
    ///
    /// - Parameter onComplete: Completion handler of task.
    public func execute(onComplete completionHandler: CompletionHandler?) {
        flowFactory(assertingOnlyOneCall(completionHandler)).execute()
    }
}

private func assertingOnlyOneCall(_ completionHandler: FlowTask.CompletionHandler?) -> FlowTask.CompletionHandler {
    lazy var alreadyCompleted = false
    let lock = NSLock()

    return {
        lock.lock(); defer { lock.unlock() }

        if alreadyCompleted {
            throwException("Flow task already completed.")
            return
        }

        alreadyCompleted = true
        completionHandler?()
    }
}
