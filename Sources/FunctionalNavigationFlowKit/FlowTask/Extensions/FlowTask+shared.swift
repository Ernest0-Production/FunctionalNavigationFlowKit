//
//  File.swift
//  
//
//  Created by Ernest Babayan on 08.12.2021.
//

import Foundation


public extension FlowTask {
    /// Share task completion if it has already start execution.
    func shared() -> FlowTask {
        lazy var alreadyExecuting = false
        lazy var pendingHandlers: [CompletionHandler] = []
        let lock = NSRecursiveLock()

        return FlowTask.deferred({
            if alreadyExecuting {
                return FlowTask.create({ completionHandler in
                    pendingHandlers.append(completionHandler)
                    return Flow.empty
                }).synchonizeExecution(with: .lock(lock))
            }

            alreadyExecuting = true

            return self
                .sideEffect(onComplete: {
                    alreadyExecuting = false
                    pendingHandlers.forEach({ $0() })
                    pendingHandlers.removeAll()
                })
                .synchonizeCompletion(with: .lock(lock))
        }).synchonizeExecution(with: .lock(lock))
    }
}
