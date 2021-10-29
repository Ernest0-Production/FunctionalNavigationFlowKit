//
//  File.swift
//  
//
//  Created by Ernest Babayan on 23.11.2021.
//

public extension FlowTask {
    /// Concatenates the passed task with this task.
    ///
    /// - Parameter nextTask: Task to be executed after this task completion.
    ///
    /// - Returns: Task that will serially execute this and passed task.
    func then(_ nextTask: FlowTask) -> FlowTask {
        FlowTask.create({ [self] completion in
            execute(onComplete: { nextTask.execute(onComplete: completion) })
            return Flow.empty
        })
    }
}
