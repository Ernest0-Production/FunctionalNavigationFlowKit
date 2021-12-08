//
//  File.swift
//  
//
//  Created by Ernest Babayan on 21.11.2021.
//

public extension FlowTask {
    /// Schedule task execution in the specific synchronized environment (such as DispatchQueue or NSLocking).
    ///
    /// - Parameter synchronizer: A way to organize safety execution of task.
    ///
    /// - Returns: Task that execute this task in the specific synchronized environment.
    func synchonizeExecution(with synchronizer: FlowSynchronizer) -> FlowTask {
        FlowTask.create({ [self] completion in
            synchronizer.sync({
                execute(onComplete: completion)
            })

            return Flow.empty
        })
    }

    /// Schedule task completion in the specific synchronized environment (such as DispatchQueue or NSLocking).
    ///
    /// - Parameter synchronizer: A way to organize safety task completion.
    ///
    /// - Returns: Task that execute this task and complete it in the specific synchronized environment.
    func synchonizeCompletion(with synchronizer: FlowSynchronizer) -> FlowTask {
        FlowTask.create({ [self] completion in
            execute(onComplete: {
                synchronizer.sync(completion)
            })

            return Flow.empty
        })
    }
}
