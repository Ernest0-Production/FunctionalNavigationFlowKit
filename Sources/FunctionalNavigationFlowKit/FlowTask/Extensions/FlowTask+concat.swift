//
//  File.swift
//  
//
//  Created by Ernest Babayan on 25.11.2021.
//

public extension FlowTask {
    /// Compose flow tasks into one that executes them step-by-step (i.e. the next task will be excuted after the completion of the current task).
    ///
    /// - Parameters tasks: Flow tasks that executes step-by-step.
    ///
    /// - Returns: Task that serial execute passed tasks.
    static func concat<TaskSequence: Sequence>(_ tasks: TaskSequence) -> FlowTask where TaskSequence.Element == FlowTask {
        tasks.reduce(FlowTask.empty, { $0.then($1) })
    }

    /// Performs task serially on task queue.
    ///
    /// - Parameter queue: Task queue on which flow task should be executed.
    ///
    /// - Returns: Task that execute flow task on task queue.
    func concat(on queue: FlowTaskQueue) -> FlowTask {
        FlowTask.create({ [self] completion in
            queue.execute(
                sideEffect(onComplete: completion)
            )

            return Flow.empty
        })
    }
}
