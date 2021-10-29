//
//  File.swift
//  
//
//  Created by Ernest Babayan on 25.11.2021.
//

public extension FlowTask {
    /// Middleware fow adding any side effects that should not affect on the task execution.
    ///
    /// - Parameters:
    ///   - beforeStart: executes before starting task execution.
    ///
    ///   - afterStart: executes after starting task execution.
    ///
    ///   - onComplete: executes after completion task execution.
    ///
    /// - Returns: Task that incapsulate side effects while executing this task.
    func sideEffect(
        beforeStart: @escaping () -> Void = {},
        afterStart: @escaping () -> Void = {},
        onComplete: @escaping () -> Void = {}
    ) -> FlowTask {
        FlowTask.create({ [self] completion in
            beforeStart()

            execute(onComplete: {
                completion()
                onComplete()
            })

            afterStart()

            return Flow.empty
        })
    }
}
