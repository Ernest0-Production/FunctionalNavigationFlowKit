//
//  File.swift
//  
//
//  Created by Ernest Babayan on 08.12.2021.
//

import Foundation


public extension FlowTask {
    /// Executes this task only once from the moment the task was created.
    func once() -> FlowTask {
        lazy var alreadyExecuting = false

        return FlowTask.deferred({
            if alreadyExecuting { return FlowTask.never }

            alreadyExecuting = true

            return self
        }).synchonizeExecution(with: .lock)
    }
}
