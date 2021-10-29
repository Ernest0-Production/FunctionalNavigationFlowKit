//
//  File.swift
//  
//
//  Created by Ernest Babayan on 19.11.2021.
//

public extension Flow {
    /// Performs flow task execution into flow.
    ///
    /// - Parameters:
    ///   - queue: Task queue on which flow task should be executed. By default this is the main flow queue.
    ///
    ///   - taskFactory: Provide flow task that will be executed when flow executes.
    ///
    /// - Returns: Flow that execute flow task on task queue.
    static func task(
        on queue: FlowTaskQueue = FlowTaskQueue.main,
        _ taskFactory: @escaping @autoclosure Deferred<FlowTask>
    ) -> Flow {
        Flow({
            queue.execute(taskFactory())
        })
    }
}
