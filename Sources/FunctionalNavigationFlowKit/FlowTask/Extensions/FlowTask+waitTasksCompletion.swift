//
//  File.swift
//  
//
//  Created by Ernest Babayan on 20.11.2021.
//

public extension FlowTask {
    /// Waits completion of all pending tasks of specified task queue.
    ///
    /// - Parameter queue: Pending task queue.
    ///
    /// - Returns: Task that completes when all pending tasks of queue have finished executing.
    static func waitTasksCompletion(of queue: FlowTaskQueue) -> FlowTask {
        FlowTask.create({ completion in
            let task = FlowTask.just(Flow(completion))
            queue.execute(task)
            return Flow.empty
        })
    }
}
