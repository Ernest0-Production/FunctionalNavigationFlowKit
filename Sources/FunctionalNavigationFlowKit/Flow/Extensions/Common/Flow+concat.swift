//
//  Flow+stepByStep.swift
//  
//
//  Created by Ernest Babayan on 29.10.2021.
//

public extension Flow {
    /// Schedule flow execution as task on specific task queue.
    ///
    /// - Parameter queue: Task queue on which flow will be executed.
    ///
    /// - Returns: Flow that will execute this flow when the specified task queue is ready to process it.
    func concat(on queue: FlowTaskQueue) -> Flow {
        Flow({
            let task = FlowTask.just(self)
            queue.execute(task)
        })
    }
}
