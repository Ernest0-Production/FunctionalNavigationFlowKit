//
//  File.swift
//  
//
//  Created by Ernest Babayan on 25.11.2021.
//

public extension FlowTask {
    /// Wraps this task into another.
    ///
    /// - Example:
    ///
    ///       appLoadingTask.flatMap({ currentTask in
    ///           let nextTask = userSession.isAuthorized ? mainFlowTask : authorizationFlowTask
    ///
    ///           return currentTask.then(nextTask)
    ///       })
    ///
    func flatMap(_ transform: (FlowTask) -> FlowTask) -> FlowTask { transform(self) }
}

public extension Sequence where Element == FlowTask {
    /// Wraps this task sequence into one task.
    ///
    /// - Example:
    ///
    ///       tasks.flatMap(FlowTask.zip)
    ///       tasks.flatMap(FlowTask.concat)
    ///
    func flatMap(_ transform: (Self) -> FlowTask) -> FlowTask { transform(self) }
}
